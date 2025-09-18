local skynet = require "skynet"

local args = { ... }

if #args == 0 or (args[1] == "true" and #args == 1) then
    table.insert(args, '1-test')
end

local testQueryUniqueService = function()
    skynet.error('query unique service')
    local service
    if #args == 2 and type(args[2]) == 'string' then
        service = skynet.queryservice(true, args[2])
        skynet.error('query global unique service:', skynet.address(service))
    else
        service = skynet.queryservice(args[1])
        skynet.error('query unique service:', skynet.address(service))
    end
end

skynet.start(testQueryUniqueService)
