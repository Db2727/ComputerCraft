local LEVEL = 1
local OUTPUT = "right"

local card = peripheral.find("magnetic_card_manipulator")


local function readCard()
    local data = card.readCard()
    if tonumber(data) == LEVEL then
        redstone.setOutput(OUTPUT, true)
        card.ejectCard()
        os.sleep(5)
        redstone.setOutput(OUTPUT,false)
    else
        card.ejectCard()
    end

    readCard()
end

readCard()