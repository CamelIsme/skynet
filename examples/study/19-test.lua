local skynet = require "skynet"
local harbor = require "skynet.harbor"

local key = ...

skynet.start(
    function()
        local globaldb = harbor.queryname('globaldb')
        skynet.error('globaldb get', key, ':', skynet.call(globaldb, 'lua', 'get', key))
    end
)
