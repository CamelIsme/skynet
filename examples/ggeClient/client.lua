-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-09-12 14:03:12
-- @Last Modified time  : 2025-09-19 16:51:34
local SDL = require('SDL')
local gge = require('ggelua')
local base = require('hv.tcp.客户端')
local myclient = class('myclient', base)

function myclient:初始化()
    self:HVTCPClient()
    self._buf = {
        need = 2, --skynet netpack使用2字节包头
        ishead = true,
        data = ''
    }

    self._hv:setcb_message(function(buf)
        if self.接收事件 then
            local b = self._buf
            b.data = b.data .. buf
            local remain = #b.data -- 剩余数据长度

            while remain >= b.need do
                remain = remain - b.need

                if b.ishead then --是否是包头
                    local bodylen = string.unpack('>I2', b.data) --大端序2字节长度
                    b.need = bodylen --包体长度
                    b.data = b.data:sub(3) --去掉2字节包头
                else
                    local data = b.data:sub(1, b.need) --包体
                    b.data = b.data:sub(b.need + 1) --去掉包体
                    b.need = 2 --包头长度
                    gge.xpcall(self.接收事件, self, data)
                end
                b.ishead = not b.ishead
            end
        end
    end)
end

function myclient:置自动拆包()
    error('无效')
end

function myclient:发送(data)
    local head = string.pack('>I2', #data)
    self._hv:send(head .. data)
end


return myclient
