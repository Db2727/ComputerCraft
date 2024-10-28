UPDATE_MANAGER_PROTOCOL = "UPDATE_MANAGER_PROTOCOL"
ID_LIST = {1,2,3,4}

Active_List = {false,false,false,false}


function ManageServers()
    rednet.open("top")
    local id,message = rednet.receive(UPDATE_MANAGER_PROTOCOL)

    if message == "active" then
        for i,v in ipairs(ID_LIST)
            if v == id then
                Active_List[i] = true
            end
        end 
    else
        local x = false
        local i = 1
        while not x do
            if Active_List[i] == true then
                x = true
                Active_List[i] = false
                local server_id = ID_LIST[i]

                rednet.send(server_id,id,UPDATE_MANAGER_PROTOCOL)
                id,message = rednet.receive(UPDATE_MANAGER_PROTOCOL)
                if message then
                    rednet.send(server_id,message,UPDATE_MANAGER_PROTOCOL)
                end
                
            else
                i = i + 1
            end
        end
    end
    ManageServers()
end

ManageServers()