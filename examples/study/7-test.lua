local skynet = require "skynet"
local harbor = require "skynet.harbor"
require "skynet.manager"

local bNewService = ...

skynet.start(
    function()
        local handler
        if bNewService then
            handler = skynet.newservice('1-test')
            skynet.error('1-test service handler:', skynet.address(handler))
            skynet.name('.localTest', handler)
            skynet.name('globalTest', handler)
        end

        local handler_by_localName = skynet.localname('.localTest')
        skynet.error('localName .localTest:', skynet.address(handler_by_localName))

        local handler_by_globalName = skynet.localname('globalTest')
        skynet.error('localName globalTest:', skynet.address(handler_by_globalName))

        handler_by_localName = harbor.queryname('.localTest')
        skynet.error('queryname .localTest:', skynet.address(handler_by_localName))


        handler_by_globalName = harbor.queryname('globalTest')
        skynet.error('queryname globalTest:', skynet.address(handler_by_globalName))
    end
)
