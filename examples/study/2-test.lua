local skynet = require('skynet')

skynet.start(function()
    local myName = skynet.getenv("myName")
    print("myName:", myName)
    skynet.error("error myName:", myName)

    skynet.setenv("testNewName", "newName") -- 设置新的环境变量
    local newName = skynet.getenv("testNewName")
    print("newName:", newName)
    skynet.error("error newName:", newName)
    skynet.exit()
end)
