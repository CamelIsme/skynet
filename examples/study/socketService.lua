local skynet = require "skynet"
local socket = require "skynet.socket"

local function handle_message(cid, address)
    while true do
        local str, end_str = socket.read(cid)
        if str then
            skynet.error("Receive message from " .. address .. ": " .. str)
            socket.write(cid, 'I got your message:' .. str)
        else
            socket.close(cid)
            skynet.error("Client from " .. address .. " disconnected", end_str)
            return
        end
    end
end

local function handle_connect(cid, address)
    skynet.error("New client from " .. address .. " with id " .. cid)
    socket.start(cid)
    skynet.fork(handle_message, cid, address)
end

skynet.start(
    function()
        local address = '0.0.0.0:8001'
        skynet.error("Server start at " .. address)
        local id = socket.listen(address)
        assert(id, "Listen socket failed")
        socket.start(id, handle_connect)
    end
)
