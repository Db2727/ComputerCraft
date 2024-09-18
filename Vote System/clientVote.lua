VProt = "vote"
AProt = "answer"
VList = {}
VTxt = ""
TxtReceived = false
ListReceived = false
Received = false
It = 1

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

    local msgList = {}
    id, VTxt = rednet.receive(VProt)
        
    
    while ListReceived == false do
        local id, msg = rednet.receive(VProt)
        if msg ~= "stop" then
            msgList[It] = msg
            It = It + 1
        elseif msg == "stop" then
            VList = msgList
            ListReceived = true
            Received = true
        end
    end
    Clr()
end

--all parallel functions above

function Receive()
    while Received == false do
        parallel.waitForAny(ReceiveVote,LoadVote)
    end
    if Received == true then
        PrintVote()
    else
        Receive()
    end
    
end

function PrintVote()
    
    print(VTxt)
    print()
    for i,v in ipairs(VList) do
        print(i.. ". " ..v)
    end
end

Receive()