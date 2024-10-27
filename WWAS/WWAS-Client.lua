WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"


local function receiveAlarm()
    rednet.open("front")
    local id ,message = rednet.receive(WWAS_AUDIO_PROTOCOL)
    local id ,text = rednet.receive(WWAS_TEXT_PROTOCOL)
    displayAlarm(message,text)
end

local function displayAlarm(message,text)
    local monitor = peripheral.wrap("right")
    if message then
        redstone.setOutput("right",true)
        monitor.clear()
        monitor.ssetCursorPos(1,1)
        monitor.write(text)
    end
end





receiveAlarm()