require("base.common")
local M = {}

-- Character bekommt einen Attributs-Boost, der erst ansteigt und dann sinkt --
function M.initBoost(User)
   User:inform("function initBoost erreicht")
   --if firsttime == nil then
      --firsttime = 1
      AttribToBoost = "perception"
      boostSteps = 6
      boostValue = 1
      reboostValue = -1
      return AttribToBoost,boostSteps, boostValue, reboostValue
   --end
end   


function M.addEffect(addPerc, User)    -- Wird nur beim Start des Effektes aufgerufen (-> Perc+1)
    User:inform("function addEffect erreicht")
    AttribToBoost, boostSteps, boostValue, reboostValue = M.initBoost(User)
    base.common.InformNLS(User, "Deine Sinne werden merkbar sensibler.", "Your senses grow noticably.");
    User:increaseAttrib(AttribToBoost,boostValue);    -- (erste Steigerung)
end


-- Wird regelmaessig aufgerufen (das erste mal nach einer Minute)

function M.callEffect(percBoost, User)                    -- Effect wird ausgeführt
    User:inform("function callEffect erreicht")
    percBoost.nextCalled = 60;                          -- Erneut in einer Minute aufrufen
    found,addPerc = percBoost:findValue("addPerc");     -- Wieviel wurde bisher "geboostet"?
    if found then                                       -- sicherheitshalber: wenn ueberhaupt geboostet wurde
        if percBoost.numberCalled < boostSteps then          
            User:increaseAttrib(AttribToBoost,boostValue); 
            percBoost:addValue("addPerc",addPerc+1);    -- Buchhaltung: Um eins hinaufzaehlen
            return true;                                -- "true" zurueckliefern (=noch einmal aufrufen)
        else                                            
            User:increaseAttrib(AttribToBoost,reboostValue);      
            percBoost:addValue("addPerc",addPerc-1);   -- Buchhaltung: um 1 runter zaehlen
            if addPerc==1 then                          -- wir sind am Ende angekommen: Effekt aufheben.
                return false;                           -- "false" zurueckgeben: Effekt wird aufgehoben.
            end
            return true;                                -- "true" -> wird wieder aufgerufen
        end
    else
        return false;                                   -- Nicht mehr aufrufen
    end
end

function M.removeEffect( Effect, Character )
    -- do nothing
end

function M.loadEffect(Effect, Character)                  -- wenn der Charakter einloggt...
    found,addPerc = coldEffect:findValue("addPerc");
    if found then
        User:increaseAttrib(AttribToBoost,addPerc);     -- Buchhaltung: Auslesen der aktuellen "steigerung" und steigern
        percBoost.nextCalled = 600;                     -- in einer Minute wieder aufrufen
    end
end

return M
