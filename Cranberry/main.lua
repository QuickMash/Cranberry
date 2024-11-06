local player = {inCredits = true, inMenu = false, inGame = false, x = 0, y = 0, speed = 3, hidden = true, level = nil}
local window = {x = 0, y = 0, fullscreen = false}
local scale = math.min(scaleX, scaleY)
local clock = {timer = 0, seconds = 0, minutes = 0, hours = 0, days = 0, weeks = 0, months = 0, years = 0}
local title = "You were not supposed to know about the Cranberries"
local creditsData = {speed = 1, y = 0, }

-- Load the game

function love.load()

    -- Window

    if not fullscreen then
        window.fullscreen = love.window.setFullscreen(true)
    else
        print("Could Not Fullscreen")
    end

    love.window.setTitle(title)
    window.x = love.graphics.getWidth()
    window.y = love.graphics.getHeight()

    -- Librarys

    local sti = require("assets/lib/sti")

    -- Window

    window.x = love.graphics.getWidth()
    window.y = love.graphics.getHeight()

    -- Font

    local fontSize = math.min(window.x, window.y) * 0.05
    local font = love.graphics.newFont("assets/fonts/silkscreen.ttf", fontSize)
    love.graphics.setFont(font)

    function spriteLayer:draw()
        love.graphics.rectangle("fill", player.x, player.y, 10, 10)
    end

    -- Player

    love.graphics.newImage("assets/sprites/player.png")


    -- Game Map

    local level1 = sti("assets/map/level1.lua", {"box2d"})
    love.physics.setMeter(32)
    world = love.physics.newWorld(0, 0)
    level1:box2d_init(world)
    spriteLayer = level1:addCustomLayer("Sprite Layer", 3)
    local mapWidth = level1.width * level1.tilewidth
    local mapHeight = level1.height * level1.tileheight
    local scaleX = window.x / mapWidth
    local scaleY = window.y / mapHeight
    spriteLayer.sprites = {
        love.graphics.draw(player.sprite, player.x, player.y)
    }
end

-- Game Updates, like timer - Based on FPS

function love.update(dt)

    -- Frame Skipping
    if love.timer.getFPS() > 60 then
        love.timer.sleep(1 / 60)
    end
    
    if player.inMenu and love.keyboard.isDown("return") then
        game()
    end

    -- Movement for player

    if player.inMenu then
        if love.keyboard.isDown("s") then
            player.y = player.y + player.speed
        end
        if love.keyboard.isDown("d") then
            player.x = player.x + player.speed
        end
        if love.keyboard.isDown("w") then
            player.y = player.y - player.speed
        end
        if love.keyboard.isDown("a") then
            player.x = player.x - player.speed
        end
    end

    -- Debugging

    if love.keyboard.isDown("f1") then
        if debug then
            debug = false
        else
            debug = true
        end
    end

    clock.timer = clock.timer + 1 -- Other Timer
    clock.ticks = clock.ticks + 1 -- Game Timer

    -- Timer Logic
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
                        if clock.weeks == 3 then
                            clock.weeks = 0
                            clock.months = clock.months + 1
                            if clock.months == 12 then
                                clock.months = 0
                                clock.years = clock.years + 1
                                local years = ""
                                if clock.years == 1 then
                                    years = "Year"
                                else
                                    years = "Years"
                                end
                                print("The user is taking a long time, they have took " .. clock.years .. " " .. years .. " to get to this point!")
                            end
                        end
                    end
                end
            end
        end
    end

    -- For the Credits

    if player.inCredits then
        creditsData.y = creditsData.y + creditsData.speed
    end
end

function love.draw()

    -- Selector For Game State, Menu, Credits, Game
    if player.inCredits then
        credits()
    elseif player.inMenu then
        mainMenu()
    elseif player.inGame then
        game()
    end
end

function mainMenu()
    player.inMenu = true
    love.graphics.setBackgroundColor(.5, .5, 0)
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
    local titleWidth = love.graphics.getFont():getWidth(title)
    love.graphics.print(title, titleWidth / 2, 50)
    local offset = titleWidth * .1
    love.graphics.print("by QuickMash Games", (window.x - titleWidth) / 2 + offset, 70)
    local text = "Press ENTER to Start"
    local x = (window.x - love.graphics.getFont():getWidth(text)) / 2
    love.graphics.print("Press ENTER to Start", x, 400)``

    if x < 0 then
        x = 0
    elseif x + textWidth > window.x then
        x = window.x - textWidth
    end

    love.graphics.setColor(1, 0, 0)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setColor(1, 0, 0)
    local bobAmount = 5
    local bobSpeed = 2
    local textRotate = math.sin(love.timer.getTime() * bobSpeed) * 0.1
    local bobOffset = math.sin(love.timer.getTime() * bobSpeed) * bobAmount
    love.graphics.print(
        "Press ENTER to Start",
        (window.x - love.graphics.getFont():getWidth("Press ENTER to Start")) / 2 + bobOffset,
        400,
        textRotate
    )
    love.graphics.setColor(0, 0, 0)
end

function credits()
    player.inCredits = true
    if player.inCredits then
        local creditsText = {
            "Game by QuickMash Games",
            "Game Design by Quackers",
            "Music by Nokkvi",
            "Programming by QuickMash",
            "Art by Example",
            "Special Thanks to Example",
            "Enjoy The Game!"
        }

        for i, text in ipairs(creditsText) do
            local textWidth = love.graphics.getFont():getWidth(text)
            local x = (window.x - textWidth) / 2
            love.graphics.print(text, x, creditsData.y + (i - 1) * spacing, 0, 1)
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
            creditsData.speed = 10
        else
            creditsData.speed = 1
        end
    end
end

function game()
    love.graphics.setColor(1, 1, 1)
    level1:draw()
    level1:resize(mapWidth * scale, mapHeight * scale)
    if debug then
        love.graphics.print(
            "X:" ..
                player.x ..
                    " | Y:" ..
                        player.y ..
                            "\nPlayer Speed:" ..
                                player.speed .. "\nTimer:" .. clock.timer .. "\nFPS:" .. love.timer.getFPS(),
            10,
            10
        )
        love.graphics.setColor(1, 0, 1)
        level1:box2d_draw()
    end
end