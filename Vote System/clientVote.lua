VProt = "vote"
AProt = "answer"
VList = {}
VTxt = ""
TxtReceived = false
ListReceived = false
Received = false

rednet.open("back")

function Clr()
    term.clear()
end


function LoadVote()
    local txt = "Waiting for Vote"
    Clr()
    local list = {"",".","..","..."}
    
    for i = 1, #list do
        print(txt.."" ..list[i])
        term.setCursorPos(1,1)
        sleep(0.3)
    end
end

function ReceiveVote()
    if TxtReceived == false then
        id, Vtxt = rednet.receive(VProt)
        TxtReceived = true
    end
    local msgList = {}
    local it = 1
    while ListReceived == false do
        local id, msg = rednet.receive(VProt)
        if msg ~= "stop" then
            msgList[it] = msg
            it = it + 1
        else
            VList = msgList
            ListReceived = true
        end
    end
    
    Clr()
    print(msgList[1])
    Received = true
    PrintVote()
end

--all parallel functions above

function Receive()
    ReceiveVote()
    
end

function PrintVote()
    print(Vtxt)
    print()
    
end

Receive()