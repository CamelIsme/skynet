local skynet = require "skynet"
local multicast = require "skynet.multicast"
local channel
local channel_id, ifStart = ...
channel_id = tonumber(channel_id)

local channelMsgDispatch = function(channel, source, ...)
    skynet.error('chainnel obj', channel, 'source address', skynet.address(source), ...)
end

skynet.start(
    function()
        if not ifStart then
            skynet.send('.multicastPublisher', 'lua', 'stopTask')
            skynet.exit()
            return
        end

        channel = multicast.new {
            channel = channel_id,
            dispatch = channelMsgDispatch
        }
        channel:subscribe()
        skynet.send('.multicastPublisher', 'lua', 'startTask')
        skynet.timeout(
            500,
            function()
                channel:unsubscribe()
                skynet.exit()
            end
        )
    end
)
