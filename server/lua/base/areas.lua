local Registries = require("selene.registries")
local M = {}

local function identifier(name)
    assert(type(name) == "string" and name ~= "", "Area name must be a non-empty string")
    return name:find(":", 1, true) and name or "illarion:" .. name
end

---Read a named registry area. Returns its shape object and ignoreFloor flag.
---Disabled entries resolve to an empty area for all gameplay helpers.
---Resolve each call so editor changes and registry reloads are immediately visible.
function M.get(name)
    local id = identifier(name)
    local entry = assert(Registries.findByName("illarion:areas", id), "Unknown area: " .. id)
    if entry:getField("enabled") ~= true then return { include = {}, exclude = {} }, false end
    local area = entry:getField("area")
    assert(type(area) == "table" and type(area.include) == "table" and type(area.exclude) == "table",
        "Invalid area: " .. id)
    return area, entry:getField("ignoreFloor") == true
end

---Check a typed rectangle/circle against a coordinate. Boundaries include tile centers.
function M.containsShape(shape, coordinate, ignoreFloor)
    if not ignoreFloor and coordinate.z ~= shape.z then return false end
    if shape.type == "rectangle" then
        return coordinate.x >= shape.x and coordinate.x < shape.x + shape.width
            and coordinate.y >= shape.y and coordinate.y < shape.y + shape.height
    elseif shape.type == "circle" then
        local dx, dy = coordinate.x - shape.x, coordinate.y - shape.y
        return dx * dx + dy * dy <= shape.radius * shape.radius
    end
    error("Unsupported area shape: " .. tostring(shape.type))
end

---Accepts a short/qualified registry name or a raw {include, exclude} object.
---Coordinates may be a position or a character with .pos. options.ignoreFloor
---overrides the registry flag, including an explicit false to enforce floors.
function M.contains(area, coordinate, options)
    local ignoreFloor = false
    if type(area) == "string" then area, ignoreFloor = M.get(area) end
    if options and options.ignoreFloor ~= nil then ignoreFloor = options.ignoreFloor end
    coordinate = coordinate.pos or coordinate
    assert(type(area) == "table" and type(area.include) == "table" and type(area.exclude) == "table",
        "Expected an area with include and exclude arrays")
    local included = false
    for _, shape in ipairs(area.include) do
        if M.containsShape(shape, coordinate, ignoreFloor) then included = true; break end
    end
    if not included then return false end
    for _, shape in ipairs(area.exclude) do
        if M.containsShape(shape, coordinate, ignoreFloor) then return false end
    end
    return true
end

---Check every area carrying a tag, keeping each area's own exclusions and floors.
function M.containsTag(tag, coordinate, options)
    assert(type(tag) == "string" and tag ~= "", "Area tag must be a non-empty string")
    for _, entry in pairs(Registries.findAll("illarion:areas")) do
        for _, entryTag in ipairs(entry:getField("enabled") == true and (entry:getField("tags") or {}) or {}) do
            if entryTag == tag then
                local ignoreFloor = entry:getField("ignoreFloor") == true
                if options and options.ignoreFloor ~= nil then ignoreFloor = options.ignoreFloor end
                if M.contains(entry:getField("area"), coordinate, { ignoreFloor = ignoreFloor }) then
                    return true
                end
                break
            end
        end
    end
    return false
end

local function bounds(shape)
    if shape.type == "rectangle" then
        return shape.x, shape.y, shape.x + shape.width - 1, shape.y + shape.height - 1
    elseif shape.type == "circle" then
        return shape.x - shape.radius, shape.y - shape.radius, shape.x + shape.radius, shape.y + shape.radius
    end
    error("Unsupported area shape: " .. tostring(shape.type))
end

---Pick a uniformly distributed tile from a named or raw area without enumerating it.
---Requires fixed floors. Returns nil for empty/disabled areas or exhausted attempts
---(default 256); very sparse areas may require a higher maxAttempts.
function M.randomPosition(area, maxAttempts)
    local ignoreFloor = false
    if type(area) == "string" then area, ignoreFloor = M.get(area) end
    assert(not ignoreFloor, "Cannot pick a position from a floor-independent area")
    maxAttempts = maxAttempts or 256
    assert(type(maxAttempts) == "number" and maxAttempts >= 1 and maxAttempts % 1 == 0,
        "Random position attempts must be a positive integer")
    local boxes, total = {}, 0
    for _, shape in ipairs(area.include) do
        local x1, y1, x2, y2 = bounds(shape)
        local width, height = x2 - x1 + 1, y2 - y1 + 1
        local size = width * height
        assert(size >= 1 and size <= 9007199254740991 - total, "Area is too large to sample")
        boxes[#boxes + 1] = { x = x1, y = y1, z = shape.z, width = width, height = height, size = size }
        total = total + size
    end
    if total == 0 then return nil end
    for _ = 1, maxAttempts do
        local index = math.random(1, total) - 1
        local coordinate
        for _, box in ipairs(boxes) do
            if index < box.size then
                coordinate = position(box.x + index % box.width, box.y + math.floor(index / box.width), box.z)
                break
            end
            index = index - box.size
        end
        if M.contains(area, coordinate) then
            -- Correct for tiles appearing in multiple include bounding boxes.
            local overlaps = 0
            for _, box in ipairs(boxes) do
                if coordinate.z == box.z and coordinate.x >= box.x and coordinate.x < box.x + box.width
                    and coordinate.y >= box.y and coordinate.y < box.y + box.height then
                    overlaps = overlaps + 1
                end
            end
            if overlaps == 1 or math.random(1, overlaps) == 1 then return coordinate end
        end
    end
    return nil
end

---An anchor for visual effects: the center of the first include shape.
---Empty areas have no anchor. Additional includes do not change this anchor.
function M.center(name)
    local area = M.get(name)
    local shape = area.include[1]
    if not shape then return nil end
    local x1, y1, x2, y2 = bounds(shape)
    return position(math.floor((x1 + x2) / 2), math.floor((y1 + y2) / 2), shape.z)
end

---Enumerate each included tile once, honoring exclusions and floors.
---Floor-independent bands cannot be enumerated; default scan limit is one million.
function M.positions(name, maxCandidates)
    local area, ignoreFloor = M.get(name)
    assert(not ignoreFloor, "Cannot enumerate a floor-independent area: " .. name)
    maxCandidates = maxCandidates or 1000000
    local candidates = 0
    for _, shape in ipairs(area.include) do
        local x1, y1, x2, y2 = bounds(shape)
        candidates = candidates + (x2 - x1 + 1) * (y2 - y1 + 1)
    end
    assert(candidates <= maxCandidates, "Area is too large to enumerate: " .. name)
    local result, seen = {}, {}
    for _, shape in ipairs(area.include) do
        local x1, y1, x2, y2 = bounds(shape)
        for y = y1, y2 do
            for x = x1, x2 do
                local coordinate = position(x, y, shape.z)
                local key = x .. ":" .. y .. ":" .. shape.z
                if not seen[key] and M.contains(area, coordinate) then
                    seen[key] = true
                    result[#result + 1] = coordinate
                end
            end
        end
    end
    return result
end

---Query include bounds, then filter against the complete area and deduplicate.
function M.getPlayers(name)
    local area, ignoreFloor = M.get(name)
    assert(not ignoreFloor, "Cannot query players across unrestricted floors: " .. name)
    local result, seen = {}, {}
    for _, shape in ipairs(area.include) do
        local x1, y1, x2, y2 = bounds(shape)
        local x, y = math.floor((x1 + x2) / 2), math.floor((y1 + y2) / 2)
        local radius
        if shape.type == "circle" then radius = shape.radius
        else
            local dx, dy = math.max(x - x1, x2 - x), math.max(y - y1, y2 - y)
            radius = math.ceil(math.sqrt(dx * dx + dy * dy))
        end
        for _, player in pairs(world:getPlayersInRangeOf(position(x, y, shape.z), radius)) do
            local key = player.id or player
            if not seen[key] and M.contains(area, player) then
                seen[key] = true
                result[#result + 1] = player
            end
        end
    end
    return result
end

return M
