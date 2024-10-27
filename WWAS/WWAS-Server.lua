WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"


function ReadNuclear()
    local input = false
    while not input do
        input = redstone.getInput("right")
    end
    
    if input then
        SendAlarm("NUCLEAR EMERGENCY \nPLEASE STAY CALM")
    end
end

function TestAlarm()
    SendAlarm("THIS IS A WWAS TEST \nDO NOT PANIC")
end

function PowerLoss()
    SendAlarm("BLACKOUT ON MAINGRID \nPLEASE STAY CALM")
end


function SendAlarm(message)
    rednet.open("top")
    rednet.broadcast(true, WWAS_AUDIO_PROTOCOL)
    sleep(1)
    rednet.broadcast(message,WWAS_TEXT_PROTOCOL)
end

TestAlarm()