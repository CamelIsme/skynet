local skynet = require "skynet"
require "skynet.manager"

local service = ...

local function dispatch(session, address, cmd, ...)
    skynet.retpack(skynet.call(service, 'lua', cmd, ...))
end

skynet.start(
    function()
        skynet.register('.proxy')
        skynet.dispatch('lua', dispatch)
    end
)
