local skynet = require "skynet"
local gateserver = require "snax.gateserver"
local netpack = require "skynet.netpack"
local cmsgpack = require "cmsgpack"

local handler = {}

function handler.connect(id, ipAdderss)
    skynet.error("New client from " .. ipAdderss .. " with id " .. id)
    gateserver.openclient(id)
end

function handler.disconnect(id)
    skynet.error("Client from " .. id .. " disconnected")
end

function handler.message(id, msg, sz)
    msg = netpack.tostring(msg, sz)
    msg = cmsgpack.unpack(msg)
    msg = type(msg) == "table" and msg[1] or msg
    skynet.error("Receive message from " .. id .. ": " .. msg)
end

gateserver.start(handler)