local skynet = require "skynet"
require "skynet.manager"

local value = ...

skynet.start(
    function()
        skynet.fork(
            function()
                local set = skynet.send('.db', 'lua', 'set', 'hello', value)
                skynet.error('set hello:', set)

                local get = skynet.call('.db', 'lua', 'get', 'hello')
                skynet.error('get hello:', get)
            end
        )
    end
)
