local skynet = require "skynet"
local socket = require "skynet.socket"

local mode, sep = ...
local handle_message

if not mode or mode == 'read' then
    handle_message = function(cid, address)
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
elseif mode == 'readline' then
    handle_message = function(cid, address)
        while true do
            local str, end_str = socket.readline(cid, sep)
            if str then
                skynet.error("Receive message from " .. address .. ": " .. str)
                socket.write(cid, 'I got your message:' .. str .. '\n')
            else
                socket.close(cid)
                skynet.error("Client from " .. address .. " disconnected", end_str)
                return
            end
        end
    end
elseif mode == 'readall' then
    handle_message = function(cid, address)
        local str = socket.readall(cid)
        if str then
            skynet.error("Receive message from " .. address .. ": " .. str)
            socket.write(cid, 'I got your message:' .. str)
        end
        socket.close(cid)
        skynet.error("Client from " .. address .. " disconnected")
        return
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
        skynet.error("Server start at " .. address, 'mode:' .. mode)
        local id = socket.listen(address)
        assert(id, "Listen socket failed")
        socket.start(id, handle_connect)
    end
)
