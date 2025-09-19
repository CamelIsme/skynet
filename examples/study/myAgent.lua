local skynet = require "skynet"
local netpack = require "skynet.netpack"
local cmsgpack = require "cmsgpack"
local socket = require "skynet.socket"
local agent = {}
local client_id = ...

skynet.register_protocol {
    name = 'client',
    id = skynet.PTYPE_CLIENT,
    unpack = function(msg, sz)
        local msg = netpack.tostring(msg, sz)
        local t = cmsgpack.unpack(msg)
        return type(t) == 'table' and t or msg
    end
}

local function pack_message(msg)
    if type(msg) == "table" then
        msg = cmsgpack.pack(msg)
    end
    return netpack.pack(msg)
end

local function dispatch(session, address, msg)
    skynet.error("Receive message from client " .. client_id .. ": " .. skynet.address(address), tostring(msg))
    socket.write(client_id, pack_message { 'I got your message', msg })
end

skynet.start(
    function()
        skynet.dispatch('client', dispatch)
        skynet.dispatch(
            'lua',
            function(session, source, cmd, ...)
                if cmd == 'quit' then
                    skynet.error('client ' .. client_id .. ' quit')
                    skynet.exit()
                end
            end
        )
    end
)
