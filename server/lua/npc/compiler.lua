-- Parse easyNPC declarations into VBU framework objects without evaluating Lua source.
local Compiler = {}
local unpackValues = table.unpack or unpack
local languages = {common=0, human=1, dwarf=2, elf=3, lizard=4, orc=5, halfling=6, fairy=7, gnome=8, goblin=9, ancient=10}
local races = {human=0, dwarf=1, halfling=2, elf=3, orc=4, lizard=5, gnome=6, fairy=7, goblin=8}
local properties = {}
for name in ("name race sex position direction affiliation job author language defaultLanguage autointroduce lookatDE lookatUS useMsgDE useMsgUS wrongLangDE wrongLangUS radius hairID beardID colorHair colorSkin itemHead itemChest itemCoat itemMainHand itemSecondHand itemHands itemTrousers itemShoes state sellItem buyPrimaryItem buySecondaryItem sellItems buyPrimaryItems buySecondaryItems tradeWrongItemMsg tradeNotEnoughMoneyMsg tradeFinishedMsg tradeFinishedWithoutTradingMsg"):gmatch("%S+") do properties[name] = true end
local repeated = {language=true, author=true, sellItem=true, buyPrimaryItem=true, buySecondaryItem=true, sellItems=true, buyPrimaryItems=true, buySecondaryItems=true}
local comparisons = {['=']=true, ['!=']=true, ['~=']=true, ['<>']=true, ['<']=true, ['>']=true, ['<=']=true, ['>=']=true}

local function fail(token, message)
    error(string.format("%s:%d:%d: %s", token.file, token.line, token.column, message), 0)
end

local function utf8(code, token)
    if code < 0 or code > 1114111 or (code >= 55296 and code <= 57343) then fail(token, "invalid Unicode escape") end
    if code < 128 then return string.char(code) end
    if code < 2048 then return string.char(192 + math.floor(code / 64), 128 + code % 64) end
    if code < 65536 then return string.char(224 + math.floor(code / 4096), 128 + math.floor(code / 64) % 64, 128 + code % 64) end
    return string.char(240 + math.floor(code / 262144), 128 + math.floor(code / 4096) % 64, 128 + math.floor(code / 64) % 64, 128 + code % 64)
end

local function tokenize(source, file)
    source = source:gsub("^\239\187\191", "")
    local tokens, index, line, column = {}, 1, 1, 1
    local function advance(count)
        for _ = 1, count do
            if source:sub(index,index) == '\n' then line, column = line + 1, 1 else column = column + 1 end
            index = index + 1
        end
    end
    local function token(kind, value)
        return {kind=kind, value=value, file=file, line=line, column=column}
    end
    while index <= #source do
        local char = source:sub(index,index)
        if char == ' ' or char == '\t' or char == '\r' then advance(1)
        elseif char == '\n' then tokens[#tokens+1] = token('newline', '\n'); advance(1)
        elseif source:sub(index,index+1) == '--' then
            while index <= #source and source:sub(index,index) ~= '\n' do advance(1) end
        elseif char == '"' or char == "'" then
            local current, quote, parts, closed = token('string'), char, {}, false
            advance(1)
            while index <= #source do
                char = source:sub(index,index)
                if char == quote then advance(1); closed = true; break end
                if char == '\n' then fail(current, "unclosed string; use \\n for a newline") end
                if char == '\\' then
                    advance(1)
                    local escape = source:sub(index,index)
                    local escapes = {n='\n', r='\r', t='\t', b='\b', f='\f', ['\\']='\\', ['"']='"', ["'"]="'", ['/']='/'}
                    if escape == 'u' then
                        local hex = source:sub(index+1,index+4)
                        if not hex:match('^%x%x%x%x$') then fail(current, "invalid Unicode escape") end
                        local code = tonumber(hex,16)
                        advance(5)
                        if code >= 55296 and code <= 56319 then
                            local low = source:sub(index,index+5)
                            if not low:match('^\\u%x%x%x%x$') then fail(current, "missing Unicode low surrogate") end
                            local lowCode = tonumber(low:sub(3),16)
                            if lowCode < 56320 or lowCode > 57343 then fail(current, "invalid Unicode low surrogate") end
                            code = 65536 + (code-55296)*1024 + lowCode-56320
                            advance(6)
                        end
                        parts[#parts+1] = utf8(code,current)
                    elseif escapes[escape] then parts[#parts+1] = escapes[escape]; advance(1)
                    else fail(current, "unsupported string escape \\" .. escape) end
                else parts[#parts+1] = char; advance(1) end
            end
            if not closed then fail(current, "unclosed string") end
            current.value = table.concat(parts); tokens[#tokens+1] = current
        elseif char:match('%d') then
            local number = source:sub(index):match('^%d+%.?%d*[eE][+-]?%d+') or source:sub(index):match('^%d+%.?%d*')
            tokens[#tokens+1] = token('number', tonumber(number)); advance(#number)
        elseif source:sub(index,index+6) == '%NUMBER' then tokens[#tokens+1] = token('capture', '%NUMBER'); advance(7)
        elseif char:match('[%a_]') then
            local name = source:sub(index):match('^[%a_][%w_]*')
            tokens[#tokens+1] = token('identifier', name); advance(#name)
        else
            local two = source:sub(index,index+1)
            if two == '->' or two == '>=' or two == '<=' or two == '!=' or two == '<>' or two == '~=' then
                tokens[#tokens+1] = token('symbol',two); advance(2)
            elseif char:match('[(),=<>+*/%%%^%-]') then tokens[#tokens+1] = token('symbol',char); advance(1)
            else fail(token('invalid'), "unexpected character " .. char) end
        end
    end
    tokens[#tokens+1] = token('eof','<end>')
    return tokens
end

local function parser(tokens)
    local p = {tokens=tokens, index=1}
    function p:peek() return self.tokens[self.index] end
    function p:take() local result=self:peek(); self.index=self.index+1; return result end
    function p:accept(value) if self:peek().value == value then return self:take() end end
    function p:expect(value)
        local current=self:peek()
        if current.value ~= value then fail(current, "expected '" .. value .. "'") end
        return self:take()
    end
    function p:newlines() while self:peek().kind == 'newline' do self:take() end end
    function p:expression(minimum)
        local current=self:take()
        local node
        if current.kind == 'number' then node={kind='literal', value=current.value, token=current}
        elseif current.kind == 'capture' or (current.kind == 'string' and current.value == '%NUMBER') then node={kind='capture',token=current}
        elseif current.value == '-' or current.value == '+' then node={kind='unary', op=current.value, operand=self:expression(30), token=current}
        elseif current.value == '(' then node=self:expression(0); self:expect(')')
        else fail(current, "expected a number or %NUMBER in expression") end
        local precedence = {['+']=10, ['-']=10, ['*']=20, ['/']=20, ['%']=20, ['^']=40}
        while precedence[self:peek().value] and precedence[self:peek().value] >= minimum do
            local operator=self:take(); local level=precedence[operator.value]
            local right=self:expression(level + (operator.value == '^' and 0 or 1))
            node={kind='binary', op=operator.value, left=node, right=right, token=operator}
        end
        return node
    end
    function p:value()
        local current=self:take()
        if current.kind == 'number' or current.kind == 'string' then return {kind='literal',value=current.value,token=current} end
        if current.kind == 'capture' then return {kind='capture',token=current} end
        if current.value == '-' or current.value == '+' then
            local number=self:take()
            if number.kind ~= 'number' then fail(number,"expected a number after sign") end
            return {kind='literal',value=current.value == '-' and -number.value or number.value,token=current}
        end
        if current.kind ~= 'identifier' then fail(current,"expected a value") end
        if not self:accept('(') then return {kind='symbol',value=current.value,token=current} end
        if current.value == 'expr' then
            local expression=self:expression(0); self:expect(')')
            return {kind='expression',expression=expression,token=current}
        end
        local args={}
        self:newlines()
        if not self:accept(')') then
            repeat
                self:newlines()
                local arg=self:value()
                if self:accept('=') then arg={kind='pair',key=arg,value=self:value(),token=arg.token} end
                args[#args+1]=arg
                self:newlines()
                if not self:accept(',') then break end
            until false
            self:expect(')')
        end
        return {kind='call',name=current.value,args=args,token=current}
    end
    function p:clause()
        local left=self:value()
        local nextToken=self:peek()
        if comparisons[nextToken.value] or nextToken.value == '+' or nextToken.value == '-' then
            local operator=self:take()
            return {kind='operation',subject=left,op=operator.value,value=self:value(),token=left.token}
        end
        return left
    end
    return p
end

local function scalar(node)
    if node.kind ~= 'literal' and node.kind ~= 'symbol' then fail(node.token,"expected a constant value") end
    return node.value
end
local function number(node, positive, integer)
    local result=scalar(node)
    if type(result) ~= 'number' or result ~= result or result == math.huge or result == -math.huge then fail(node.token,"expected a finite number") end
    if positive and result <= 0 then fail(node.token,"expected a positive number") end
    if integer and result ~= math.floor(result) then fail(node.token,"expected an integer") end
    return result
end
local function stringValue(node)
    local result=scalar(node)
    if type(result) ~= 'string' then fail(node.token,"expected text") end
    return result
end
local function args(node, minimum, maximum)
    local count=node.args and #node.args or 0
    if count < minimum or count > maximum then fail(node.token,string.format("expected %d%s argument(s)",minimum,maximum ~= minimum and ".." .. maximum or "")) end
end
local function dynamicNumber(node)
    if node.kind == 'capture' or node.kind == 'expression' then return end
    if node.kind == 'literal' and node.value == '%NUMBER' then return end
    number(node,false,false)
end
local function evaluate(node,capture)
    if node.kind == 'literal' then return node.value end
    if node.kind == 'capture' then return tonumber(capture) or 0 end
    if node.kind == 'unary' then local value=evaluate(node.operand,capture); return node.op == '-' and -value or value end
    local left,right=evaluate(node.left,capture),evaluate(node.right,capture)
    if node.op == '+' then return left+right elseif node.op == '-' then return left-right elseif node.op == '*' then return left*right
    elseif node.op == '/' then return left/right elseif node.op == '%' then return left%right else return left^right end
end
local function runtimeValue(node)
    if node.kind == 'capture' then return '%NUMBER' end
    if node.kind == 'expression' then return function(capture) return evaluate(node.expression,capture) end end
    return scalar(node)
end
local function dataValue(node)
    if node.kind ~= 'call' or node.name ~= 'data' then fail(node.token,"expected data(key = value, ...)") end
    local result={}
    for _,pair in ipairs(node.args) do
        if pair.kind ~= 'pair' then fail(pair.token,"expected a data key and value") end
        local key=stringValue(pair.key)
        if result[key] ~= nil then fail(pair.token,"duplicate data key " .. key) end
        result[key]=scalar(pair.value)
    end
    return result
end

local numericSubjects = {state=true, number=true, money=true, queststatus=true, item=true, skill=true, attrib=true}
local function validateCondition(node)
    if node.kind == 'symbol' and (node.value == 'english' or node.value == 'german' or node.value == 'admin') then return end
    if node.kind == 'call' and node.name == 'basestate' then
        args(node,1,1)
        local value=scalar(node.args[1])
        if value ~= 'busy' and value ~= 'idle' then fail(node.token,"basestate must be busy or idle") end
        return
    end
    if node.kind == 'call' and (node.name == 'race' or node.name == 'sex') then
        args(node,1,1)
        local value=scalar(node.args[1])
        if node.name == 'race' and races[value] == nil then fail(node.token,"unknown NPC race condition") end
        if node.name == 'sex' and value ~= 'male' and value ~= 'female' then fail(node.token,"sex condition must be male or female") end
        return
    end
    if node.kind == 'call' and node.name == 'chance' then
        args(node,1,1); local chance=number(node.args[1]); if chance < 0 or chance > 100 then fail(node.token,"chance must be between 0 and 100") end; return
    end
    if node.kind == 'operation' then
        if not comparisons[node.op] then fail(node.token,"expected a comparison") end
        local subject=node.subject
        local name=subject.name or subject.value
        if not numericSubjects[name] then fail(subject.token,"unsupported condition " .. tostring(name)) end
        dynamicNumber(node.value)
        if name == 'queststatus' then args(subject,1,1); number(subject.args[1],false,true)
        elseif name == 'item' then args(subject,1,3); number(subject.args[1],true,true)
            if subject.args[2] then stringValue(subject.args[2]) end
            if subject.args[3] then scalar(subject.args[3]) end
        elseif name == 'skill' or name == 'attrib' then args(subject,1,1); stringValue(subject.args[1])
        else args(subject,0,0) end
        return
    end
    fail(node.token,"unsupported condition")
end
local function validateAction(node,hasTrades)
    if node.kind == 'literal' and type(node.value) == 'string' then return end
    if node.kind == 'symbol' then
        if node.value == 'trade' then if not hasTrades then fail(node.token,"trade action has no offers or requests") end; return end
        if node.value == 'introduce' then return end
    elseif node.kind == 'operation' then
        local subject=node.subject; local name=subject.name or subject.value
        if node.op ~= '=' and node.op ~= '+' and node.op ~= '-' then fail(node.token,"unsupported assignment operator") end
        if name ~= 'state' and name ~= 'money' and name ~= 'queststatus' and name ~= 'skill' and name ~= 'attrib' then fail(subject.token,"unsupported action " .. tostring(name)) end
        if name == 'money' and node.op == '=' then fail(node.token,"money supports + and - only") end
        dynamicNumber(node.value)
        if name == 'queststatus' then args(subject,1,1); number(subject.args[1],false,true)
        elseif name == 'skill' or name == 'attrib' then args(subject,1,1); stringValue(subject.args[1])
        else args(subject,0,0) end
        return
    elseif node.kind == 'call' then
        local name=node.name
        if name == 'talkstate' then
            args(node,1,1)
            local value=scalar(node.args[1])
            if value ~= 'begin' and value ~= 'end' then fail(node.token,"talkstate must be begin or end") end
            return
        end
        if name == 'inform' then args(node,1,1); stringValue(node.args[1]); return end
        if name == 'item' then
            args(node,2,4); number(node.args[1],true,true); dynamicNumber(node.args[2])
            if node.args[3] then dynamicNumber(node.args[3]) end
            if node.args[4] then
                if node.args[4].kind == 'call' then dataValue(node.args[4]) else number(node.args[4],false,true) end
            end
            return
        end
        if name == 'deleteItem' then args(node,2,3); number(node.args[1],true,true); dynamicNumber(node.args[2]); if node.args[3] then scalar(node.args[3]) end; return end
        local counts={warp=3, spawn=6, treasure=1}
        if counts[name] then
            args(node,counts[name],counts[name])
            for _,value in ipairs(node.args) do
                if name == 'treasure' then dynamicNumber(value) else number(value,false,true) end
            end
            return
        end
    end
    fail(node.token,"unsupported action " .. tostring(node.name or node.value or node.kind))
end

local function tradeFields(statement)
    local fields={}
    for _,field in ipairs(statement.values) do
        if field.kind ~= 'call' then fail(field.token,"expected a trade field") end
        if fields[field.name] then fail(field.token,"duplicate trade field " .. field.name) end
        if field.name == 'data' then fields.data=dataValue(field)
        elseif field.name == 'id' or field.name == 'stack' or field.name == 'quality' or field.name == 'price' then
            args(field,1,1); fields[field.name]=number(field.args[1],field.name == 'id' or field.name == 'stack',true)
            if field.name == 'price' and fields.price < 0 then fail(field.token,"price cannot be negative") end
            if field.name == 'quality' and (fields.quality < 100 or fields.quality > 999) then fail(field.token,"quality must be between 100 and 999") end
        elseif field.name == 'de' or field.name == 'en' then args(field,1,1); fields[field.name]=stringValue(field.args[1])
        else fail(field.token,"unsupported trade field " .. field.name) end
    end
    if not fields.id then fail(statement.token,"trade item needs id(...)") end
    if (fields.de == nil) ~= (fields.en == nil) then fail(statement.token,"provide both de(...) and en(...) names") end
    return fields
end

function Compiler.parse(source,options)
    options=options or {}
    local p=parser(tokenize(source,options.fileName or '<npc>'))
    local definition={properties={}, rules={}, idle={}, trades={}, fileName=options.fileName or '<npc>'}
    while p:peek().kind ~= 'eof' do
        p:newlines()
        if p:peek().kind == 'eof' then break end
        local first=p:peek()
        if first.kind == 'identifier' and first.value == 'cycletext' then
            p:take(); local german=p:value(); p:expect(','); local english=p:value()
            definition.idle[#definition.idle+1]={stringValue(german),stringValue(english)}
        else
            local arrow=false
            local depth=0
            for index=p.index,#p.tokens do
                local token=p.tokens[index]
                if depth == 0 and (token.kind == 'newline' or token.kind == 'eof') then break end
                if token.value == '(' then depth=depth+1 elseif token.value == ')' then depth=depth-1
                elseif depth == 0 and token.value == '->' then arrow=true; break end
            end
            if not arrow then
                local name=p:take()
                if name.kind ~= 'identifier' or not properties[name.value] then fail(name,"unknown NPC property " .. tostring(name.value)) end
                p:expect('=')
                local values={p:value()}
                while p:accept(',') do values[#values+1]=p:value() end
                local statement={values=values, token=name}
                if name.value == 'sellItem' or name.value == 'buyPrimaryItem' or name.value == 'buySecondaryItem' then
                    local fields=tradeFields(statement)
                    fields.type=({sellItem='sell',buyPrimaryItem='buyPrimary',buySecondaryItem='buySecondary'})[name.value]
                    fields.token=name; definition.trades[#definition.trades+1]=fields
                elseif name.value == 'sellItems' or name.value == 'buyPrimaryItems' or name.value == 'buySecondaryItems' then
                    for _,value in ipairs(values) do definition.trades[#definition.trades+1]={id=number(value,true,true),type=({sellItems='sell',buyPrimaryItems='buyPrimary',buySecondaryItems='buySecondary'})[name.value],token=name} end
                else
                    if definition.properties[name.value] and not repeated[name.value] then fail(name,"duplicate NPC property " .. name.value) end
                    if repeated[name.value] then
                        local list=definition.properties[name.value] or {}; list[#list+1]=statement; definition.properties[name.value]=list
                    else definition.properties[name.value]=statement end
                end
            else
                local rule={triggers={},conditions={},actions={},token=first}
                repeat
                    local clause=p:clause()
                    if clause.kind == 'literal' and type(clause.value) == 'string' then
                        if not pcall(string.find,'',clause.value) then fail(clause.token,"invalid Lua trigger pattern") end
                        rule.triggers[#rule.triggers+1]=clause.value
                    else rule.conditions[#rule.conditions+1]=clause end
                    if not p:accept(',') then break end
                until false
                p:expect('->')
                repeat
                    rule.actions[#rule.actions+1]=p:clause()
                    if not p:accept(',') then break end
                until false
                if #rule.triggers == 0 then fail(first,"dialogue needs at least one trigger") end
                definition.rules[#definition.rules+1]=rule
            end
        end
        if p:peek().kind ~= 'newline' and p:peek().kind ~= 'eof' then fail(p:peek(),"expected end of declaration") end
    end
    for _,rule in ipairs(definition.rules) do
        for _,condition in ipairs(rule.conditions) do validateCondition(condition) end
        for _,action in ipairs(rule.actions) do validateAction(action,#definition.trades > 0) end
    end
    -- Validate metadata even though existing NPC data remains responsible for spawning.
    for name,statement in pairs(definition.properties) do
        local entries=repeated[name] and statement or {statement}
        for _,entry in ipairs(entries) do
            local values=entry.values
            if name == 'position' or name == 'colorHair' or name == 'colorSkin' then
                if #values ~= 3 then fail(entry.token,name .. " needs three numbers") end
                for _,value in ipairs(values) do number(value,false,true) end
            elseif name == 'language' or name == 'defaultLanguage' then
                if #values ~= 1 or languages[scalar(values[1])] == nil then fail(entry.token,"unknown spoken language") end
            elseif name == 'race' then
                if #values ~= 1 or races[scalar(values[1])] == nil then fail(entry.token,"unknown NPC race") end
            elseif name == 'sex' then
                if #values ~= 1 or (scalar(values[1]) ~= 'male' and scalar(values[1]) ~= 'female') then fail(entry.token,"sex must be male or female") end
            elseif name == 'autointroduce' then
                if #values ~= 1 or (scalar(values[1]) ~= 'on' and scalar(values[1]) ~= 'off') then fail(entry.token,"autointroduce must be on or off") end
            elseif name == 'direction' then
                if #values ~= 1 or not ({north=true,northeast=true,east=true,southeast=true,south=true,southwest=true,west=true,northwest=true})[scalar(values[1])] then fail(entry.token,"unknown facing direction") end
            elseif name:match('^trade.*Msg$') then
                if #values ~= 2 then fail(entry.token,"trade message needs German and English text") end
                for _,value in ipairs(values) do stringValue(value) end
            else
                if #values ~= 1 then fail(entry.token,name .. " needs one value") end
                scalar(values[1])
                if name:match('^item') or name == 'radius' or name == 'hairID' or name == 'beardID' or name == 'state' then
                    number(values[1],false,true)
                else stringValue(values[1]) end
            end
        end
    end
    return definition
end

local function makeCondition(node)
    if node.kind == 'symbol' then
        if node.value == 'admin' then return require('npc.base.condition.admin')() end
        return require('npc.base.condition.language')(node.value)
    end
    if node.kind == 'call' then
        if node.name == 'basestate' then return require('npc.base.condition.basestate')(scalar(node.args[1])) end
        if node.name == 'race' then return require('npc.base.condition.race')(races[scalar(node.args[1])]) end
        if node.name == 'sex' then return require('npc.base.condition.sex')(scalar(node.args[1])) end
        return require('npc.base.condition.chance')(scalar(node.args[1]))
    end
    local subject=node.subject; local name=subject.name or subject.value
    local value=runtimeValue(node.value)
    if name == 'queststatus' then return require('npc.base.condition.quest')(scalar(subject.args[1]),node.op,value) end
    if name == 'item' then return require('npc.base.condition.item')(scalar(subject.args[1]),subject.args[2] and scalar(subject.args[2]) or 'all',node.op,value,subject.args[3] and scalar(subject.args[3])) end
    if name == 'skill' or name == 'attrib' then return require('npc.base.condition.' .. (name == 'attrib' and 'attribute' or 'skill'))(scalar(subject.args[1]),node.op,value) end
    return require('npc.base.condition.' .. name)(node.op,value)
end
local function makeAction(node,trader)
    if node.kind == 'symbol' then
        if node.value == 'trade' then return require('npc.base.consequence.trade')(trader) end
        return require('npc.base.consequence.introduce')()
    end
    if node.kind == 'operation' then
        local subject=node.subject; local name=subject.name or subject.value
        local value=runtimeValue(node.value)
        if name == 'queststatus' then return require('npc.base.consequence.quest')(scalar(subject.args[1]),node.op,value) end
        if name == 'skill' or name == 'attrib' then return require('npc.base.consequence.' .. (name == 'attrib' and 'attribute' or 'skill'))(scalar(subject.args[1]),node.op,value) end
        return require('npc.base.consequence.' .. name)(node.op,value)
    end
    local name=node.name
    if name == 'item' then
        local data=node.args[4]
        data=data and (data.kind == 'call' and dataValue(data) or {data=scalar(data)}) or nil
        return require('npc.base.consequence.item')(scalar(node.args[1]),runtimeValue(node.args[2]),node.args[3] and runtimeValue(node.args[3]) or 333,data)
    end
    if name == 'deleteItem' then return require('npc.base.consequence.deleteitem')(scalar(node.args[1]),runtimeValue(node.args[2]),node.args[3] and scalar(node.args[3])) end
    local values={}
    for index,value in ipairs(node.args) do values[index]=runtimeValue(value) end
    return require('npc.base.consequence.' .. name)(unpackValues(values))
end

function Compiler.instantiate(definition)
    local Base=require('npc.base.basic')
    local Talk=require('npc.base.talk')
    local root=Base()
    local talk=Talk(root)
    local property=definition.properties
    local function get(name,default)
        local entry=property[name]
        return entry and scalar(entry.values[1]) or default
    end
    for _,entry in ipairs(property.language or {}) do root:addLanguage(languages[scalar(entry.values[1])]) end
    root:setDefaultLanguage(languages[get('defaultLanguage','common')])
    root:setLookat(get('lookatDE',''),get('lookatUS',''))
    root:setUseMessage(get('useMsgDE',''),get('useMsgUS',''))
    root:setConfusedMessage(get('wrongLangDE',''),get('wrongLangUS',''))
    root:setAutoIntroduceMode(get('autointroduce','on') == 'on')
    local equipment={itemHead=1,itemChest=4,itemCoat=3,itemMainHand=5,itemSecondHand=6,itemHands=7,itemTrousers=10,itemShoes=11}
    for name,slot in pairs(equipment) do if property[name] and get(name,0) > 0 then root:setEquipment(slot,get(name)) end end
    talk._state=get('state',0)
    local trader
    if #definition.trades > 0 then
        local Trade=require('npc.base.trade')
        trader=Trade(root)
        for _,offer in ipairs(definition.trades) do
            trader:addItem(Trade.tradeNPCItem(offer.id,offer.type,offer.de,offer.en,offer.price,offer.stack,offer.quality,offer.data))
        end
        local messages={tradeWrongItemMsg='addWrongItemMsg',tradeNotEnoughMoneyMsg='addNotEnoughMoneyMsg',tradeFinishedMsg='addDialogClosedMsg',tradeFinishedWithoutTradingMsg='addDialogClosedNoTradeMsg'}
        for name,method in pairs(messages) do if property[name] then trader[method](trader,scalar(property[name].values[1]),scalar(property[name].values[2])) end end
    end
    for _,rule in ipairs(definition.rules) do
        local entry=Talk.talkNPCEntry()
        for _,pattern in ipairs(rule.triggers) do entry:addTrigger(pattern:lower()) end
        for _,condition in ipairs(rule.conditions) do entry:addCondition(makeCondition(condition)) end
        for _,action in ipairs(rule.actions) do
            if action.kind == 'literal' then entry:addResponse(action.value) else entry:addConsequence(makeAction(action,trader)) end
        end
        talk:addTalkingEntry(entry)
    end
    for _,pair in ipairs(definition.idle) do talk:addCycleText(pair[1],pair[2]) end
    root:initDone()
    return {root=root,talk=talk,trader=trader,definition=definition}
end

function Compiler.compile(source,options)
    local definition=Compiler.parse(source,options)
    -- Constructors are checked before the caller replaces any live definition.
    local ok,result=pcall(Compiler.instantiate,definition)
    if not ok then error(definition.fileName .. ": cannot construct NPC: " .. tostring(result),0) end
    return {definition=definition, newInstance=function() return Compiler.instantiate(definition) end}
end

return Compiler
