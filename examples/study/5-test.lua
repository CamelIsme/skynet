local skynet = require('skynet')

local args = { ... }

if #args == 0 or (args[1] == "true" and #args == 1) then
    table.insert(args, '1-test')
end

local testUniqueService = function()
    local service
    skynet.error('testUniqueService start')
    if #args == 2 and type(args[2]) == 'string' then
        service = skynet.uniqueservice(true, args[2])
        skynet.error('global unique service:', skynet.address(service))
    else
        service = skynet.uniqueservice(args[1])
        skynet.error('unique service:', skynet.address(service))
    end
end

skynet.start(testUniqueService)
