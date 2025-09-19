local skynet = require "skynet"
local socket = require "skynet.socket"

local function client(id)
    local i = 0
    while i < 3 do
        skynet.error("Send message to server", i)
        socket.write(id, 'data:' .. i .. '\n')
        local str = socket.readline(id)
        if str then
            skynet.error("Receive message from server: " .. str)
        else
            skynet.error("Server disconnected")
            break
        end
        i = i + 1
    end
    skynet.exit()
end

skynet.start(
    function()
        local address = '127.0.0.1:8001'
        skynet.error("Connect to server", address)
        local id = socket.open(address)
        skynet.fork(client, id)
    end
)
