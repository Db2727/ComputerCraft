WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"


function ReceiveAlarm()
    rednet.open("front")
    local id, message = rednet.receive(WWAS_AUDIO_PROTOCOL)
    local id, text1 = rednet.receive(WWAS_TEXT_PROTOCOL)
    local id, text2 = rednet.receive(WWAS_TEXT_PROTOCOL)
    DisplayAlarm(message,text1)
end

function DisplayAlarm(message,text1)
    local monitor = peripheral.find("monitor")
    if message then
        redstone.setOutput("right",true)
        monitor.clear()
        monitor.setCursorPos(1,1)
        monitor.write(text1)
    end
end





ReceiveAlarm()