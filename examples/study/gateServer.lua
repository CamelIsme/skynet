local skynet = require "skynet"
local gateserver = require "snax.gateserver"
local agentServers = {}

skynet.register_protocol {
    name = 'client',
    id = skynet.PTYPE_CLIENT,
}

local handler = {}

function handler.connect(id, ipAdderss)
    skynet.error("New client from " .. ipAdderss .. " with id " .. id)
    gateserver.openclient(id)
    local agent = skynet.newservice('myAgent', id)
    agentServers[id] = agent
end

function handler.disconnect(id)
    skynet.error("Client from " .. id .. " disconnected")
    local agent = agentServers[id]
    if agent then
        skynet.send(agent, 'lua', 'quit')
        agentServers[id] = nil
    end
end

function handler.message(id, msg, sz)
    skynet.error("Receive message from " .. id .. ": " .. tostring(sz))
    skynet.redirect(agentServers[id], id, "client", 0, msg, sz)
end

function handler.error(id, msg)
    skynet.error("Client from " .. id .. " error: " .. msg)
    gateserver.closeclient(id)
end

function handler.warning(id, size)
    skynet.error('warning id =', id, 'unsend data over 1MB', size)
end

function handler.command(cmd, address, ...)

end

gateserver.start(handler)
