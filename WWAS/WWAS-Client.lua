-- Version 2.0

WWAS_AUDIO_PROTOCOL = "WWAS_AUDIO"
WWAS_TEXT_PROTOCOL = "WWAS_TEXT"
WWAS_STOP_PROTOCOL = "WWAS_STOP"
WWAS_ID = "NULL"


function ReceiveAlarm()
    local monitor = peripheral.find("monitor")
    monitor.clear()
    monitor.setCursorPos(1,4)
    monitor.write(WWAS_ID)
    monitor.setCursorPos(1,1)

    rednet.open("back")
    local id, message = rednet.receive(WWAS_AUDIO_PROTOCOL)
    if not message then
        if message == WWAS_ID then
            local id, mode = rednet.receive(WWAS_AUDIO_PROTOCOL)
            local id, sound = rednet.receive(WWAS_AUDIO_PROTOCOL)
            local id, text1 = rednet.receive(WWAS_TEXT_PROTOCOL)
            local id, text2 = rednet.receive(WWAS_TEXT_PROTOCOL)
            DisplayAlarm(message,sound,mode,text1,text2)
        else
            ReceiveAlarm()
        end
    else
        local id, mode = rednet.receive(WWAS_AUDIO_PROTOCOL)
        local id, sound = rednet.receive(WWAS_AUDIO_PROTOCOL)
        local id, text1 = rednet.receive(WWAS_TEXT_PROTOCOL)
        local id, text2 = rednet.receive(WWAS_TEXT_PROTOCOL)
        DisplayAlarm(message,mode,sound,text1,text2)
    end
end 

function DisplayAlarm(message,mode,sound,text1,text2)
    local monitor = peripheral.find("monitor")
    if message then
        if mode == "siren" then
            redstone.setOutput("top",true)
        elseif mode == "speaker" then
            local speaker = peripheral.find("speaker")
            PlaySoundFile(sound)
        end
        monitor.clear()
        monitor.setCursorPos(1,1)
        monitor.write(text1)
        monitor.setCursorPos(1,2)
        monitor.write(text2)
        StopAlarm()
    else
        ReceiveAlarm()
    end
end

function StopAlarm()
    rednet.open("back")
    local monitor = peripheral.find("monitor")
    local id, message = rednet.receive(WWAS_STOP_PROTOCOL)
    if message then
        redstone.setOutput("top",false)
        monitor.clear()
        monitor.setCursorPos(1,1)
        ReceiveAlarm()
    else
        StopAlarm()
    end
end

function PlaySoundFile(filename)
    local dfpwm = require("cc.audio.dfpwm")
    local speaker = peripheral.find("speaker")
    local decoder = dfpwm.make_decoder()
    for chunk in io.lines("data/" .. filename, 16 * 1024) do
        local buffer = decoder(chunk)

        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end

local monitor = peripheral.find("monitor")
monitor.clear()
ReceiveAlarm()