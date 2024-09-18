VOTE_PROTOCOL = "vote"
ANSWER_PROTOCOL = "answer"
VoteList = {}
AnsList = {}
Time = 20

rednet.open("back")


function Clr()
    term.clear()
end

function ReadVote()
    local question = io.read()
    print()
    local stop = false
    local i = 1
    while not stop do
        
        local inp = io.read()
        
        if inp ~= "stop" then
            VoteList[i] = inp
            i = i+1
        else
            stop = true
        end
    end
    
    print(VoteList[1])
    rednet.broadcast(question,VOTE_PROTOCOL)
    
    for index, value in ipairs(VoteList) do
        rednet.broadcast(value,VOTE_PROTOCOL)
        sleep(0.1)
    end
    rednet.broadcast("stop", VOTE_PROTOCOL)
    ReceiveVote()
end

function Countdown()
    for i=1,Time do
        print(Time - i)
        sleep(1)
        
    end
end

function PrlReceive()
    local i = 1
    while true do
        local id,ans = rednet.receive(VOTE_PROTOCOL)
        AnsList[i] = tonumber(ans)
        i = i + 1
    end
end


function ReceiveVote()
    parallel.waitForAny(PrlReceive,Countdown)
    CountVote()
end

function CountVote()
   local ans,ans2,ind,ind2 = CountNumbersInList(AnsList)

   if ans == ans2 then
        -- do sth
   else
        local win = VoteList[ind]
        rednet.broadcast(win,ANSWER_PROTOCOL)
        rednet.broadcast(ans,ANSWER_PROTOCOL)
        print(win.. " has won with " ..ans.. " Votes!")
   end
end


function CountNumbersInList(list)
    local num = {0,0,0,0,0,0,0,0,0}
    local ans = -1
    local ans2 = -1
    local ind = 0
    local ind2 = 0

    for i,v in ipairs(AnsList) do
        num[v] = num[v] + 1
    end

    for i,v in ipairs(num) do
        if num[i] > ans then
            ans = num[i]
            ind = i
        elseif num[i] == ans then
            ans2 = num[i]
            ind2 = i
        end
    end
    return ans,ans2,ind,ind2
end



ReadVote()


