local skynet = require "skynet"

local src, dst = ...

skynet.start(
    function()
        local src_handle = skynet.localname(src)
        local dst_handle = skynet.localname(dst)
        if not src_handle or not dst_handle then
            return
        end
        skynet.redirect(src_handle, dst_handle, 'lua', 0, skynet.pack('get', 'hello'))
    end
)
