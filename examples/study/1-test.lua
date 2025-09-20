local skynet = require('skynet')

skynet.start(function()
    skynet.error('Hello world', SERVICE_NAME)
end)
