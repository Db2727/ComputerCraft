WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"


function readNuclear()
    local input = false
    while !input do
        input = redstone.getInput("right")
    end
    
    if input then
        sendAlarm("NUCLEAR EMERGENCY PLEASE STAY CALM")
    end
end

function testAlarm()
    sendAlarm("THIS IS A WWAS TEST DO NOT PANIC")
end

function powerLoss()
    sendAlarm("BLACKOUT ON MAINGRID PLEASE STAY CALM")
end


function sendAlarm(message)
    rednet.open("top")
    rednet.broadcast(true, WWAS_AUDIO_PROTOCOL)
    sleep(1)
    rednet.broadcast(message,WWAS_TEXT_PROTOCOL)
end

testAlarm()