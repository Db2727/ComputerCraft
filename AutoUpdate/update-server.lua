UPDATE_PROTOCOL = "UPDATE"
UPDATE_MANAGER_PROTOCOL = "UPDATE_MANAGER_PROTOCOL"
SERVER_MANAGER_ID = 13


function ReceiveRequest()
    rednet.open("top")
    local id,msg = rednet.receive(UPDATE_MANAGER_PROTOCOL)
    rednet.send(SERVER_MANAGER_ID,true,UPDATE_MANAGER_PROTOCOL)

    if id == SERVER_MANAGER_ID then
        local client_id = tonumber(msg)
        local id,request = rednet.receive(UPDATE_PROTOCOL)
    else
        ReceiveRequest()
    end

end

function GatherRequestData(client_id,request)
    filepath = "disk/data/" .. request .. ".lua"
    file = fs.open(filepath,"r")
    data = file.readAll()
    file.close()
    SendData(client_id,data)
end

function SendData(client_id,data)
    rednet.open("top")
    rednet.send(client_id, data, UPDATE_PROTOCOL)
    rednet.send(SERVER_MANAGER_ID, "active", UPDATE_MANAGER_PROTOCOL)
    ReceiveRequest()
end

rednet.send(SERVER_MANAGER_ID, "active", UPDATE_MANAGER_PROTOCOL)
ReceiveRequest()