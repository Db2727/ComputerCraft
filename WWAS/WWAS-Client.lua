WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"


function ReceiveAlarm()
    rednet.open("front")
    local id ,message = rednet.receive(WWAS_AUDIO_PROTOCOL)
    local id ,text = rednet.receive(WWAS_TEXT_PROTOCOL)
    DisplayAlarm(message,text)
end

function DisplayAlarm(message,text)
    local monitor = peripheral.find("monitor")
    if message then
        redstone.setOutput("right",true)
        monitor.clear()
        monitor.ssetCursorPos(1,1)
        monitor.write(text)
    end
end





ReceiveAlarm()