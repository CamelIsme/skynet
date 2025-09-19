local skynet = require "skynet"

skynet.start(
    function()
        local gateInfo = {
            port = 8001,
            maxclient = 64,
            nodelay = true
        }
        skynet.error('gateserver startting...')
        local gateserver = skynet.newservice('gateServer')
        skynet.call(gateserver, 'lua', 'open', gateInfo)

        skynet.error('gateserver started', 'port:' .. gateInfo.port)
        skynet.exit()
    end
)
