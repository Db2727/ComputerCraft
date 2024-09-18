VProt = "vote"
AProt = "answer"
VList = {}
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

function Countdown()
    for i=1,Time do
        print(Time)
        sleep(1)
    end
end

function PrlReceive()
    local i = 1
    while true do
        local id,ans = rednet.receive(VProt)
        AnsList[i] = ans
        i = i + 1
    end
end


function ReceiveVote()
    parallel.waitForAny(PrlReceive,Countdown)
    CountVote()
end

function CountVote()
    
end

ReadVote()        
