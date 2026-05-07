local M = {}

-- Langzeit Effekt für Lasttier

-- Aufgabe: Speichern und Übergeben des Lasttierbesitzers

function M.addEffect(Effect, Carrier)
    return true;
end

function M.callEffect(Effect, Carrier)
    Effect.nextCalled = 360000;
    return true;
end

function M.removeEffect(Effect, Carrier)
    return true;
end
return M
