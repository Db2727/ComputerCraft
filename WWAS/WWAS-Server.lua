WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"
WWAS_STOP_PROTOCOL = "WWAS_STOP"
MODE = "test" --(test, nuclear, power, stop, custom)


function ReadNuclear()
    local input = false
    while not input do
        input = redstone.getInput("right")
    end
    
    if input then
        SendAlarm("NUCLEAR EMERGENCY", "PLEASE STAY CALM")
    end
    Activate()
end

function TestAlarm()
    local input = false
    while not input do
        input = redstone.getInput("front")
    end
    if input then
        SendAlarm("THIS IS A WWAS TEST", "DO NOT PANIC")
    end
    Activate()
end

function PowerLoss()
    SendAlarm("BLACKOUT ON MAINGRID", "PLEASE STAY CALM")
end


function SendAlarm(text1, text2)
    rednet.open("top")
    rednet.broadcast(true, WWAS_AUDIO_PROTOCOL)
    sleep(0.5)
    rednet.broadcast(text1, WWAS_TEXT_PROTOCOL)
    sleep(0.5)
    rednet.broadcast(text2, WWAS_TEXT_PROTOCOL)
end

function StopAlarm()
    rednet.open("top")
    local input = false
    while not input do
        input = redstone.getInput("front")
    end
    if input then
        rednet.broadcast(true, WWAS_STOP_PROTOCOL)
    end
end

function Activate()
    if MODE == "test" then
        TestAlarm()
    elseif MODE == "nuclear" then
        ReadNuclear()
    elseif MODE == "power" then
        PowerLoss()
    elseif MODE == "stop" then
        StopAlarm()
    end
end