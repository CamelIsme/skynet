local skynet = require "skynet"
require("skynet.manager")

skynet.start(
    function()
        skynet.register('.msgSender')

        local result = skynet.send('.msgReceiver', 'lua', 'hello', 'world')
        skynet.error('skynet.send result: ', result)

        local result = skynet.rawsend('.msgReceiver', 'lua', skynet.pack('hello', 'skynet'))
        skynet.error('skynet.rawsend result: ', result)

        skynet.error('skynet.call result: ', skynet.call('.msgReceiver', 'lua', 'callMessage', 1.1))

        skynet.error('skynet.rawcall result: ', skynet.unpack(skynet.rawcall('.msgReceiver', 'lua', skynet.pack('callMessage', 1.2))))
    end
)
