local M = {}

local SCALING_FACTOR = 1000
local AMPLIFICATION = 100
local LOWER_BORDER = 0.5 * AMPLIFICATION / 0.00025
local NORMAL_MC = 10 * LOWER_BORDER
local NORMAL_ACTION_POINTS = 50

local function getLeadAttribute()
    return 10
end

function M.learn(user, skill, actionPoints, learnLimit)
    local skillValue = user:getSkill(skill)
    local mentalCapacity = math.max(LOWER_BORDER, user:getMentalCapacity())

    if skillValue >= learnLimit or skillValue >= 100 then
        return
    end

    if math.random(0, 99) < 100 - skillValue then
        local mentalCapacityFactor = NORMAL_MC / math.max(mentalCapacity, 1)
        local attributeFactor = math.min(1.5, 0.5 + 0.5 * (getLeadAttribute() / 10))
        local actionPointFactor = actionPoints / NORMAL_ACTION_POINTS
        local minorIncrease = math.floor(
            SCALING_FACTOR * attributeFactor * actionPointFactor * mentalCapacityFactor
        )

        while minorIncrease > 0 do
            local realIncrease = math.min(minorIncrease, 10000)
            user:increaseMinorSkill(skill, realIncrease)
            minorIncrease = minorIncrease - 10000
        end
    end

    user:increaseMentalCapacity(AMPLIFICATION * actionPoints)
end

function M.reduceMC(user)
    if user:idleTime() < 300 then
        local reduction = math.floor(user:getMentalCapacity() * 0.00025 + 0.5)
        user:increaseMentalCapacity(-reduction)
    end
end

return M
