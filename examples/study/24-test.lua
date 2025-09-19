local skynet = require "skynet"
local socket_channel = require "skynet.socketchannel"

local channel = socket_channel.channel {
    host = '127.0.0.1',
    port = 8001
}

local function response(sock)
    return true, sock:read()
end

local function requestTask()
    local i = 0
    while i < 3 do
        local result = channel:request('data' .. i .. '\n', response)
        skynet.error('result:', result)
        i = i + 1
    end
    channel:close()
    skynet.exit()
end

skynet.start(function()
    skynet.fork(requestTask)
end)
