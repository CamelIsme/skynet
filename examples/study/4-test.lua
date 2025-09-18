local skynet = require "skynet"

local newservice = function()
    skynet.error('newservice 1-test')
    skynet.newservice('1-test')
    skynet.error('newservice ok 1')
    skynet.error('newservice 2-test')
    skynet.newservice('2-test')
    skynet.error('newservice ok 2')
    skynet.exit()
end

skynet.start(newservice)
