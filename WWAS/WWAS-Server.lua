WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"

local function main()
    testAlarm()
end


local function readNuclear()
    local input = false
    while !input do
        input = redstone.getInput("right")
    end
    
    if input then
        sendAlarm("NUCLEAR EMERGENCY PLEASE STAY CALM")
    end
end

local function testAlarm()
    sendAlarm("THIS IS A WWAS TEST DO NOT PANIC")
end

local function powerLoss()
    sendAlarm("BLACKOUT ON MAINGRID PLEASE STAY CALM")
end


local function sendAlarm(message)
    rednet.open("top")
    rednet.broadcast(true, WWAS_AUDIO_PROTOCOL)
    sleep(1)
    rednet.broadcast(message,WWAS_TEXT_PROTOCOL)
end

main()