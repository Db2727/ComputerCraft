local BANNED_PLAYERS = {"Db_27YT"}
rednet.open("top")

local function main()
    local x = false
    local id,message = rednet.receive()
    for index, value in ipairs(BANNED_PLAYERS) do
        if value == message then
            x = true
        end
    end
    x = false
    rednet.send(id,x)
    main()
end

main()
