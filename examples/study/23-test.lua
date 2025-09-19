local skynet = require "skynet"
local socket = require "skynet.socket"

local receive_message = function(id)
    local i = 0
    while i < 3 do
        local str = socket.readline(id)
        if str then
            skynet.error('Client receive message: ' .. str, 'Message count:' .. i)
        else
            skynet.error("Server disconnected")
            break
        end
        i = i + 1
    end
    socket.close(id)
    skynet.exit()
end

local send_message = function(id)
    local i = 0
    while i < 3 do
        skynet.error("Send message to ", i)
        socket.write(id, 'data:' .. i .. '\n')
        i = i + 1
    end
end

skynet.start(
    function()
        local address = '127.0.0.1:8001'
        skynet.error("Connect to server", address)
        local id = socket.open(address)
        skynet.fork(receive_message, id)
        skynet.fork(send_message, id)
    end
)
