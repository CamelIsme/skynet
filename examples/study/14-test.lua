local skynet = require "skynet"
require "skynet.manager"

skynet.register_protocol {
    name = 'testProtocol',
    id = skynet.PTYPE_SYSTEM,
    unpack = skynet.unpack,
    pack = skynet.pack
}

skynet.start(
    function()
        skynet.register('.systemMsgSender')

        local list = { skynet.call('.systemMsgReceiver', 'testProtocol', 'msg1', 1, 2, 3) }

        skynet.error('skynet.call result:', table.unpack(list))
    end
)
