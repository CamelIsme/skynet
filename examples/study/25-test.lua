local skynet = require "skynet"
local socket_channel = require "skynet.socketchannel"

local dispatch = function(socket)
    local result = socket:readline()
    local session = result:gsub('I got your message:data', '')
    return tonumber(session), true, result
end

local channel = socket_channel.channel {
    host = '127.0.0.1',
    port = 8001,
    response = dispatch
}

local function requestTask()
    local i = 0
    while i < 3 do
        skynet.fork(
            function(session)
                local result = channel:request('data' .. session .. '\n', session)
                skynet.error('session:', session, 'result:', result)
            end,
            i
        )
        i = i + 1
    end
end

skynet.start(function()
    skynet.fork(requestTask)
end)
