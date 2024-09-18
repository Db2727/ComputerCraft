VProt = "vote"
AProt = "answer"
VList = {}

rednet.open("back")


function Clr()
    term.clear()
end

local function ReadVote()
    local question = io.read()
    print()
    local stop = false
    local i = 1
    while not stop do
        
        local inp = io.read()
        
        if inp ~= "stop" then
            VList[i] = inp
            i = i+1
        else
            stop = true
        end
    end
    
    print(VList[1])
    rednet.broadcast(question,VProt)
    
    for index, value in ipairs(VList) do
        rednet.broadcast(value,VProt)
        sleep(0.1)
    end
    rednet.broadcast("stop", VProt)
end


ReadVote()        
