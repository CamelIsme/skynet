local skynet = require "skynet"
require "skynet.manager"

skynet.register_protocol {
    name = 'testProtocol',
    id = skynet.PTYPE_SYSTEM,
    unpack = skynet.unpack,
    pack = skynet.pack
}

local function dispatch(session, address, cmd, ...)
    skynet.retpack('testProtocol Recevie message: ', cmd, ...)
end

skynet.start(
    function()
        skynet.dispatch('testProtocol', dispatch)
        skynet.register('.systemMsgReceiver')
    end
)
