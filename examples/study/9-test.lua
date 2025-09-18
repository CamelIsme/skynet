local skynet = require "skynet"
require("skynet.manager")

local function dispatch(session, address, ...)
    skynet.error('session:', session, 'address:', skynet.address(address))
    skynet.error('args:', ...)
    local response_handler = skynet.response(skynet.pack)
    skynet.fork(
        function(...)
            skynet.sleep(100)
            skynet.error('send response', response_handler('test', 'I received your message', ...))
        end,
        ...
    )
end

skynet.start(
    function()
        skynet.dispatch('lua', dispatch)
        skynet.register('.msgReceiver')
    end
)
