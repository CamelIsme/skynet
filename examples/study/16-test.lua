local skynet = require "skynet"
require "skynet.manager"

local key, value = ...

local function handle()
    local result = skynet.send('.proxy', 'lua', 'set', key, value)
    skynet.error('set result:', result)

    local result = skynet.call('.proxy', 'lua', 'get', key)
    skynet.error('get result:', result)


    skynet.exit()
end

skynet.start(
    function ()
        skynet.fork(handle)
    end
)
