UPDATE_PROTOCOL = "UPDATE"
UPDATE_MANAGER_PROTOCOL = "UPDATE_MANAGER_PROTOCOL"
SERVER_MANAGER_ID = 13

function GetFileName()
    term.clear()
    print("Name of Program to update")
    name = read()

    filepath = name .. ".lua"
    if fs.exists(filepath) then
        RequestFile(filepath,name)
    else
        print("file not found")
    end
end

function RequestFile(filepath,name)
    rednet.open("back")
    rednet.send(SERVER_MANAGER_ID,name,UPDATE_MANAGER_PROTOCOL)
    local id,data = rednet.receive(UPDATE_PROTOCOL)
end

function UpdateFile(filepath,name,data)
    fs.delete(filepath)
    file = fs.open(filepath,"w")
    file.write(data)
    file.close()
end

GetFileName()