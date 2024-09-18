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
    id, Vtxt = rednet.receive(VProt)
    id, VList = rednet.receive(VProt)

    
    Clr()
    print(VList[1])
    Received = true
end

--all parallel functions above

function Receive()
    while Received == false do
        parallel.waitForAny(ReceiveVote,LoadVote)
    end
    PrintVote()
end

function PrintVote()
    print(Vtxt)
    print()
    for i,v in ipairs(VList) do
        print(i.. ". " ..v)
    end
end

Receive()