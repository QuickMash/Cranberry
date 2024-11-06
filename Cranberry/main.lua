local player = {inCredits = true, inMenu = false, inGame = false, x = 0, y = 0, speed = 3, hidden = true, level = nil}
local window = {x = 0, y = 0}
local cheats = {x = 10, y = 10, dragy = 100, active = false, index = 1}
local cheat = {"up", "up", "down", "down", "left", "right", "left", "right", "b", "a"}
local clock = {
    timer = 0,
    seconds = 0,
    minutes = 0,
    hours = 0,
    days = 0,
    weeks = 0,
    fortnites = 0,
    months = 0,
    years = 0
}

local creditsData = {speed = 1, y = 0}
debug = false
showplaytime = true
tia = "Not Tested."
tiae = true
function love.load()
    love.window.setTitle("You were not supposed to know about the cranberrys")

    buttons = require("assets/lib/simplebutton")
    map = require("assets/lib/sti")

    buttons.default.width = 100
    buttons.default.height = 40
    buttons.default.alignment = "center"

    start = buttons.new("Start", 100, 100, 200, 50)
    local creditsbtn = buttons.new("Credits", 100, 200, 200, 50)
    local quitbtn = buttons.new("Quit", 100, 300, 200, 50)

    start.onClick = function()
        player.inMenu = false
        player.inGame = true
    end

    creditsbtn.onClick = function()
        player.inMenu = false
        player.inCredits = true
    end

    quitbtn.onClick = function()
        love.event.quit()
    end

    window.x = love.graphics.getWidth()
    window.y = love.graphics.getHeight()
    timer = 0
end

function love.update(dt)
    buttons.update(dt)

    if love.timer.getFPS() == 60 then
        if not tiae then
            tia = "Yes"
        end
    else
        tia = "No"
        tiae = false
    end

    if player.inMenu then
        if love.keyboard.isDown("w") then
            player.y = player.y + player.speed
        end
        if love.keyboard.isDown("a") then
            player.x = player.x + player.speed
        end
        if love.keyboard.isDown("s") then
            player.y = player.y - player.speed
        end
        if love.keyboard.isDown("d") then
            player.x = player.x - player.speed
        end
    end

    if love.keyboard.isDown("f1") then
        if debug then
            debug = false
        else
            debug = true
        end
    end

    clock.timer = clock.timer + 1

    if clock.timer == 60 then
        clock.timer = 0
        clock.seconds = clock.seconds + 1
        if clock.seconds == 60 then
            clock.seconds = 0
            clock.minutes = clock.minutes + 1
            if clock.minutes == 60 then
                clock.minutes = 0
                clock.hours = clock.hours + 1
                if clock.hours == 24 then
                    clock.hours = 0
                    clock.days = clock.days + 1
                    if clock.days == 7 then
                        clock.days = 0
                        clock.weeks = clock.weeks + 1
                    end
                end
            end
        end
    end

    local key = love.keyboard.isDown("l")

    if key then
        cheat_index = cheat_index + 1

        if cheat_index > #cheat then
            print("hi")
            cheats(true)
        end
    else
        cheat_index = 1
    end

    if player.inCredits then
        creditsData.y = creditsData.y + creditsData.speed
    end
end

function love.draw()
    if player.inCredits then
        credits()
    elseif player.inMenu then
        mainMenu()
    elseif player.inGame then
        game()
    end

    if not player.hidden then
        love.graphics.rectangle("fill", player.x, player.y, 10, 10)
    end
end

function mainMenu()
    love.graphics.setBackgroundColor(.5, .5, 0)
    player.inMenu = true
    love.graphics.setColor(0, 0, 0)

    if debug then
        love.graphics.setColor(0, 0, 1)
        love.graphics.print(
            clock.weeks ..
                ":" ..
                    clock.days ..
                        ":" ..
                            clock.hours ..
                                ":" ..
                                    clock.minutes ..
                                        ":" ..
                                            clock.seconds ..
                                                "\nFPS:" .. love.timer.getFPS() .. "\nTimer is Correct: " .. tia,
            10,
            10
        )
        love.graphics.setColor(0, 0, 0)
    end

    love.graphics.print(
        "You were not supposed to know about the Cranberries",
        (window.x - love.graphics.getFont():getWidth("You were not supposed to know about the Cranberries")) / 2,
        50
    )
    local title = "You were not supposed to know about the Cranberries"
    local titleWidth = love.graphics.getFont():getWidth(title)
    local offset = titleWidth * .1
    love.graphics.print("by QuickMash Games", (window.x - titleWidth) / 2 + offset, 70)

    love.graphics.setColor(1, 0, 0)
    love.graphics.print("Press ENTER to Start", (window.x - love.graphics.getFont():getWidth("Press ENTER to Start")) / 2, 400, textRotate)
    love.graphics.setColor(0, 0, 0)
end

function cheats(active)
    if active then
        cheats.active = true
        debug = true
    elseif active == nil then
        cheats.active = false
    else
        cheats.active = false
        print(
            "01010100 01101000 01100101 00100000 01000110 01101111 01110010 01100011 01100101 00100000 01101001 01110011 00100000 01110111 01101001 01110100 01101000 00100000 01111001 01101111 01110101 00101100 00100000 01111001 01101111 01110101 01101110 01100111 00100000 01010011 01101011 01111001 01110111 01100001 01101100 01101011 01100101 01110010 00101110 00100000 01000010 01110101 01110100 00100000 01111001 01101111 01110101 00100000 01100001 01110010 01100101 00100000 01101110 01101111 01110100 00100000 01100001 00100000 01001010 01100101 01100100 01101001 00100000 01111001 01100101 01110100 00101110"
        )
    end

    if cheats.active then
        player.hidden = not player.hidden
        cheats.active = false
    end
end

function credits()
    if player.inCredits then
        local creditsText = {
            "Game by QuickMash Games",
            "Game Design by Quackers",
            "Music by Nokkvi",
            "Programming by QuickMash",
            "Art by ",
            "Special Thanks to ",
            "Enjoy The Game!"
        }

        for i, text in ipairs(creditsText) do
            local textWidth = love.graphics.getFont():getWidth(text)
            local x = (window.x - textWidth) / 2
            love.graphics.print(text, x, creditsData.y + (i - 1) * 20, 0, 1)
        end

        if creditsData.y < window.y then
        else
            mainMenu()
            player.inCredits = false
            player.inMenu = true
        end
        if debug then
            love.graphics.print("Credits y:" .. creditsData.y .. "\nspeed: " .. creditsData.speed, 10, 10)
        end

        if love.keyboard.isDown("space") then
            speed = 10
        else
            speed = 1
        end
    end
end

function game()
    player.inGame = true
    player.hidden = false
    -- level1:draw()
end