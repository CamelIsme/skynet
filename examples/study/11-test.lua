local skynet = require "skynet"
require "skynet.manager"

local queue = require "skynet.queue"
local skynet_queue = queue()

local db = {
    hello = 'world'
}

function db.get(name)
    skynet.sleep(100)
    return db[name]
end

function db.set(key, value)
    db[key] = value
    return true
end

local function dispatch(session, address, cmd, ...)
    return skynet.retpack(skynet_queue(db[cmd], ...))
end

skynet.start(
    function()
        skynet.dispatch('lua', dispatch)
        skynet.register('.db')
        skynet.register('globaldb')
    end
)
