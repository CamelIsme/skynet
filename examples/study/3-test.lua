local skynet = require('skynet')

skynet.init(
    function()
        skynet.error("init")
    end
)

skynet.start(
    function()
        skynet.error("start")
    end
)
