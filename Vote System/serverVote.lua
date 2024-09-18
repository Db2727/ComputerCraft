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
    
    while not stop do
        local i = 0
        local inp = io.read()
        
        if inp ~= "stop" then
            VList[i] = inp
            i = i+1
        else
            stop = true
        end
    end
    
    rednet.broadcast(question,VProt)
    sleep(1)
    rednet.broadcast(VList,VProt)

end


ReadVote()        
