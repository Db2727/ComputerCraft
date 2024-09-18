VOTE_PROTOCOL = "vote"
ANSWER_PROTOCOL = "answer"
VoteList = {}
VoteText = ""
TextReceived = false
ListReceived = false
Received = false
Iterator = 1

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
    id, VoteText = rednet.receive(VOTE_PROTOCOL)
        
    
    while ListReceived == false do
        local id, msg = rednet.receive(VOTE_PROTOCOL)
        if msg ~= "stop" then
            msgList[Iterator] = msg
            Iterator = Iterator + 1
        elseif msg == "stop" then
            VoteList = msgList
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
    
    print(VoteText)
    print()
    for i,v in ipairs(VoteList) do
        print(i.. ". " ..v)
    end
    ReadVote()
end


function ReadVote()
    local ans = io.read()
    rednet.broadcast(ans,VOTE_PROTOCOL)
    ReceiveAns()
end

function ReceiveAns()
    print("Waiting for Results")
    local id,win = rednet.receive(ANSWER_PROTOCOL)
    local id,ans = rednet.receive(ANSWER_PROTOCOL)
    Clr()
    print(win.. " has won with " ..ans.. " Votes!")
    
end

Receive()