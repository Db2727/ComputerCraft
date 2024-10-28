WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"
WWAS_STOP_PROTOCOL = "WWAS_STOP"
Mode = ... --(test, nuclear, power, stop, custom)




function ReadNuclear()
    local input = false
    while not input do
        sleep(0.1)
        input = redstone.getInput("right")
    end
    
    if input then
        SendAlarm("siren", false, "NUCLEAR EMERGENCY", "PLEASE STAY CALM")
    end
end

function TestAlarm()
    local input = false
    while not input do
        sleep(0.1)
        input = redstone.getInput("front")
    end
    if input then
        SendAlarm("siren", false, "THIS IS A WWAS TEST", "DO NOT PANIC")
    end
    Activate()
end

function PowerLoss()
    SendAlarm("siren", false, "BLACKOUT ON MAINGRID", "PLEASE STAY CALM")
end

function CustomAlert()
    print("siren or speaker?")
    local mode = read("")
    term.clear()
    if mode == "speaker" then
        print("Sound Filename")
        local sound = read("")
        term.clear()
    else
        local sound = false
    end
    print("text1")
    local text1 = read("")
    term.clear()
    print("text2")
    local text2 = read("")
    term.clear()

    SendAlarm(mode,sound,text1,text2)
    print("Alarm send")
    read()
    Activate()
end


function SendAlarm(mode,sound, text1, text2)
    rednet.open("top")
    rednet.broadcast(true, WWAS_AUDIO_PROTOCOL)
    sleep(0.5)
    rednet.broadcast(mode,WWAS_AUDIO_PROTOCOL)
    sleep(0.5)
    rednet.broadcast(sound,WWAS_AUDIO_PROTOCOL)
    sleep(0.5)
    rednet.broadcast(text1, WWAS_TEXT_PROTOCOL)
    sleep(0.5)
    rednet.broadcast(text2, WWAS_TEXT_PROTOCOL)
end

function StopAlarm()
    rednet.open("top")
    local input = false
    while not input do
        sleep(0.1)
        input = redstone.getInput("front")
    end
    if input then
        rednet.broadcast(true, WWAS_STOP_PROTOCOL)
    end
end

function Activate()
    if Mode == "test" then
        TestAlarm()
    elseif Mode == "nuclear" then
        ReadNuclear()
    elseif Mode == "power" then
        PowerLoss()
    elseif Mode == "stop" then
        StopAlarm()
    elseif Mode == "custom" then
        CustomAlert()
    else
        printError("Invalid Mode")
    end
end