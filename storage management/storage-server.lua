local chest = peripheral.wrap("right")
local output = peripheral.wrap("left")
local function getItemList()
    print("Search for Item: ")
    local input = read()
    local found = {}
    local i = 0
    for slot,item in pairs(chest.list()) do
        if string.match(item.name,input) then
            i = i+1
            found[i] = slot
            print(i.." "..item.name.." "..item.count)
        end
    end
    print("Input Item id: ")
    input = tonumber(read()) 
    

    print("Input amount max 64:")
    local count = tonumber(read())
    GetItem(found[input],count)
end
 
function GetItem(slot,count)
    chest.pushItems(peripheral.getName(output),slot)
    term.clear()
    print("repeat action (r) new search (s) exit (ENTER)")
    local input = read()
    if input == "r" then
        GetItem(slot,CountVote)
    elseif input == "s" then
        getItemList()
    end
end
 
getItemList()