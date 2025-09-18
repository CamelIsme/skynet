local skynet = require "skynet"
require "skynet.manager"

skynet.register_protocol {
    name = 'proxyMsg',
    id = skynet.PTYPE_SYSTEM,
    unpack = function(...)
        return ...
    end
}

local protocal_map = {
    [skynet.PTYPE_LUA] = skynet.PTYPE_SYSTEM
}

local service = ...

local function dispatch(session, address, msg, size)
    skynet.ret(skynet.rawcall(service, 'lua', msg, size))
end

skynet.forward_type(
    protocal_map,
    function()
        skynet.dispatch('proxyMsg', dispatch)
        skynet.register('.proxy')
    end
)
