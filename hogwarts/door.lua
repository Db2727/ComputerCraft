QUESTIONS = {"a","b","c"}
ANSWERS = {"1","2","3"}

function AskQuestion()
    local x = math.random(1,3)
    print(QUESTIONS[x])
    local inp = io.read()
    if inp == ANSWERS[x] then
        return true
    else
        return false
    end
end

function Main()
    local x = AskQuestion()
    if x then
        redstone.setOutput("right", true)
        sleep(3)
        redstone.setOutput("right", false)
        term.clear()
        Main()
    else
        term.clear()
        Main()
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

PlaySoundFile(door)