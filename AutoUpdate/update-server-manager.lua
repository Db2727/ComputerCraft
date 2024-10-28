UPDATE_MANAGER_PROTOCOL = "UPDATE_MANAGER_PROTOCOL"
UPDATE_PROTOCOL = "UPDATE"
ID_LIST = {25,26,27,28,29}

Active_List = {false,false,false,false,false}


function ManageServers()
    rednet.open("top")
    local id,request = rednet.receive(UPDATE_MANAGER_PROTOCOL)

    if request == "active" then
        for i,v in ipairs(ID_LIST) do
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
                local id,message = rednet.receive(UPDATE_MANAGER_PROTOCOL)
                if message then
                    rednet.send(server_id,request,UPDATE_PROTOCOL)
                end
                
            else
                i = i + 1
            end
        end
    end
    ManageServers()
end

ManageServers()