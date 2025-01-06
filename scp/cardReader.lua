local LEVEL = 1
local PLAYER_DETECTOR_NUM = "1"
local READ_PLAYER = true
local OUTPUT = "left"



local card = peripheral.find("magnetic_card_manipulator")
local player = peripheral.find("playerDetector_" ..PLAYER_DETECTOR_NUM)

local function readCard()
    if card.hasCard() then
        local data = card.readCard()
        if tonumber(data) >= LEVEL then
            if READ_PLAYER then
                local x = ReadPlayer()
                if x then
                    print("no no no")
                else
                    print("yes yes yes")
                end
            end
            redstone.setOutput(OUTPUT, true)
            os.sleep(5)
            redstone.setOutput(OUTPUT,false)
        end
    end
    readCard()
end

for i = 1, 10, 1 do
    
end

function ReadPlayer()
    rednet.open("front")
    local event, username, device = os.pullEvent("playerClick")
    rednet.send(49,username)
    local id,message = rednet.receive()
    if message then
        return true
    else
        return false
    end
end

readCard()