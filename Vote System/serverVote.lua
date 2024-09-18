VProt = "vote"
AProt = "answer"
VList = {}



local function clr()
    term.clear()
end

local function readVote()
    local question = io.read()
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
    rednet.broadcast(VList,VProt)

end


readVote()        
