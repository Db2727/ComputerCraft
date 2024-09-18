VProt = "vote"
AProt = "answer"
VList = {}
VTxt = ""
Recieved = false

local function clr()
    term.clear()
end


local function loadVote()
    local txt = "Waiting for Vote"
    clr()
    local list = {"",".","..","..."}
    
    for i = 1, #list do
        print(txt.."" ..list[i])
        term.setCursorPos(1,1)
        sleep(0.3)
    end
end

local function receiveVote()
    local id,txt = rednet.receive(VProt)
    local id,list = rednet.receive(VProt)
    VTxt = txt
    VList = list
    Received = true
end

--all paralell functions above

local function receive()
    while Received == false do
        parallel.waitForAny(receiveVote,loadVote)
    end
end

local function printVote()

end
