local SQLite = require("selene.sqlite")

local M = {}
local database = SQLite.open("gobaith/taxes.sqlite")

database:execute([[
    CREATE TABLE IF NOT EXISTS taxes (
        account TEXT PRIMARY KEY,
        amount INTEGER NOT NULL DEFAULT 0 CHECK (amount >= 0)
    )
]])

function M.add(account, amount)
    database:execute([[
        INSERT INTO taxes (account, amount) VALUES (?, ?)
        ON CONFLICT(account) DO UPDATE SET amount = amount + excluded.amount
    ]], account, amount)
end

function M.collect(account)
    database:execute("BEGIN IMMEDIATE")
    local ok, amount = pcall(function()
        local collected = database:scalar("SELECT amount FROM taxes WHERE account = ?", account) or 0
        database:execute("UPDATE taxes SET amount = 0 WHERE account = ?", account)
        return collected
    end)

    if not ok then
        database:execute("ROLLBACK")
        error(amount)
    end

    database:execute("COMMIT")
    return amount
end

return M
