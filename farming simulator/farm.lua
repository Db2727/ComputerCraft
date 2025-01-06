LENGHT = 30
WIDTH = 4

Current_Cycle = 0

function StartCycle()
    for i = 1, WIDTH, 1 do
        Current_Cycle = Current_Cycle + 1
        MineLane()
        if Current_Cycle % 2 == 0 then
            turtle.turnLeft()
            turtle.forward()
            turtle.turnLeft()
        else
            turtle.turnRight()
            turtle.forward()
            turtl.turnRight()
        end
    end

    if WIDTH % 2 == 0 then
        turtle.turnLeft()
        Move(WIDTH)
    else
        Move(LENGHT + 1)
        turtle.turnRight()
        Move(WIDTH)
    end
    turtle.turnRight()
    Unload()
    StartCycle()
end

function Move(count)
    for i = 1, count, 1 do
        turtle.forward()
    end
end

function MineLane()
    for i = 1, LENGHT, 1 do
        local exist,data = turtle.inspectDown()
        if exist then
            local data2 = data["state"]
            if data2["age"] == 7 then
                turtle.digDown()
                turtle.select(1)
                turtle.placeDown()
            end
        end
        turtle.forward()
    end
end

function Unload()
    for i = 2, 16, 1 do
        turtle.select(i)
        turtle.dropUp()
    end
    turtle.select(1)
end

function Loop()
    StartCycle()
end

StartCycle()