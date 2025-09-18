local skynet = require "skynet"
require "skynet.manager"
local multicast = require "skynet.multicast"
local co
local msg_id = 0
local channel
local running = false

local function publishTask()
    while running do
        msg_id = msg_id + 1
        channel:publish('msg', msg_id)
        skynet.sleep(100)
    end
end

local function dispatch(session, address, cmd, ...)
    if cmd == 'startTask' then
        if not running then
            running = true
            co = skynet.fork(publishTask)
        end
    elseif cmd == 'stopTask' then
        skynet.error('stop task', co, msg_id)
        running = false
        if co then
            skynet.wakeup(co)
            co = nil
        end
    end
end

skynet.start(
    function()
        skynet.dispatch('lua', dispatch)
        skynet.register('.multicastPublisher')
        channel = multicast.new()
        skynet.error('publisher channel:', channel.channel)
    end
)
