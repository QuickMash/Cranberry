local player = {inCredits = true, inMenu = false, inGame = false, x = 0, y = 0, speed = 3, hidden = true, level = nil, sprite = nil, animation = nil}
local window = {x = 0, y = 0, fullscreen = false}
local scaleX, scaleY = 1, 1
local scale = math.min(scaleX, scaleY)
local clock = {timer = 0, seconds = 0, minutes = 0, hours = 0, days = 0, weeks = 0, months = 0, years = 0}
local title = "You were not supposed to know about the Cranberries"
local creditsData = {speed = 1, y = 0, }
local save = {file = nil, data = nil, location = "1"} -- location refers to the location last saved defined by an id, the file is the location of the save file on the system, and data... i am adding more systems so idk
local level1
-- Load the game

function love.load()

    -- Window

    if not fullscreen then
        window.fullscreen = love.window.setFullscreen(true)
    else
        print("Could Not Fullscreen")
    end
    
    end
    
    function love.update(dt)
        -- Game Updates, like timer - Based on FPS
        player.animation:update(dt)
        anim8:update()
    
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
        end
    
        local titleWidth = love.graphics.getFont():getWidth(title)
        love.graphics.print(title, (window.x - titleWidth) / 2, 50)
        local offset = titleWidth * .1
        love.graphics.print("by QuickMash Games", (window.x - titleWidth) / 2 + offset, 70)
        local text = "Press ENTER to Start"
        local x = (window.x - love.graphics.getFont():getWidth(text)) / 2
        love.graphics.print(text, x, 400)
    
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
        local creditsText = {
            "Game by QuickMash Games",
            "Game Design by Quackers",
            "Music by Nokkvi",
            "Programming by QuickMash",
            "Art by Example",
            "Special Thanks to Example"
        }
        for i, text in ipairs(creditsText) do
            local textWidth = love.graphics.getFont():getWidth(text)
            local x = (window.x - textWidth) / 2
            love.graphics.print(text, x, creditsData.y + (i - 1) * 20, 0, 1)
        end
    
        if creditsData.y > window.y then
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

    love.window.setTitle(title)
    window.x = love.graphics.getWidth()
    window.y = love.graphics.getHeight()

    -- Librarys

    local anim8 = require("assets/lib/anim8")
    local sti = require("assets/lib/sti")


    -- Window

    window.x = love.graphics.getWidth()
    window.y = love.graphics.getHeight()

    -- Font

    local fontSize = math.min(window.x, window.y) * 0.05
    local font = love.graphics.newFont("assets/fonts/silkscreen.ttf", fontSize)
    love.graphics.setFont(font)


    -- Player

    player.sprite = love.graphics.newImage("assets/sprites/player.png")
    local grid = anim8.newGrid(16, 16, player.sprite:getWidth(), player.sprite:getHeight())
    -- Removed redundant line
    anim8.newGrid(16, 16, player.sprite:getWidth(), player.sprite:getHeight(), 0, 0, 10);


    -- Game Map

    level1 = sti("assets/map/level1.lua", {"box2d"})
    love.physics.setMeter(32)
    world = love.physics.newWorld(0, 0)
    level1:box2d_init(world)
    spriteLayer = level1:addCustomLayer("Sprite Layer", 3)
    local mapWidth = level1.width * level1.tilewidth
    local mapHeight = level1.height * level1.tileheight
    spriteLayer.sprites = {
        {sprite = player.sprite, x = 100, y = 200, animation = player.animation}
    }
    player.animation:draw(player.sprite, 100, 200)
end

-- Game Updates, like timer - Based on FPS
    player.animation:update(dt)
    player.animation:update(dt)
    anim8:update()

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

function loadSaveFile()
    local save.file = love.filesystem.read("save")
    if save then
        local save.

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
    local titleWidth = love.graphics.getFont():getWidth(title)
    love.graphics.print(title, (window.x - titleWidth) / 2, 50)
    local offset = titleWidth * .1
    love.graphics.print("by QuickMash Games", (window.x - titleWidth) / 2 + offset, 70)
    local text = "Press ENTER to Start"
    local x = (window.x - love.graphics.getFont():getWidth(text)) / 2
    love.graphics.print(text, x, 400)
    love.graphics.print(text, x, 400)
    x = (window.x - love.graphics.getFont():getWidth(text)) / 2
    love.graphics.print("Press ENTER to Start", x, 400)

    if x < 0 then
        x = 0
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
    player.inCredits = true
    if player.inCredits then
        local creditsText = {
            "Game by QuickMash Games",
            "Game Design by Quackers",
            "Music by Nokkvi",
            "Programming by QuickMash",
            "Art by Example",
            "Special Thanks to Example",
        }
        local textWidth = love.graphics.getFont():getWidth(text)
        local x = (window.x - textWidth) / 2
    local creditsText = {
        "Game by QuickMash Games",
        "Game Design by Quackers",
        "Music by Nokkvi",
        "Programming by QuickMash",
        "Art by Example",
        "Special Thanks to Example"
    }
    for i, text in ipairs(creditsText) do
        local textWidth = love.graphics.getFont():getWidth(text)
        local x = (window.x - textWidth) / 2
        love.graphics.print(text, x, creditsData.y + (i - 1) * 20, 0, 1)
    end

    if creditsData.y > window.y then
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
    if debug then
        love.graphics.setColor(1, 0, 1)
        level1:box2d_draw()
    end
end