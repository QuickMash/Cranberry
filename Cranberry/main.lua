-- Author: QuickMash
-- Version: 1.0
-- Title: You Were Not Supposed to Know About the Cranberrys
-- Licence: Coming soon!
love = love or {}
local player = {x = 0, y = 0, speed = 1, sprite = false, inMenu = false, inGame = false, inCredits = true}
player.inCredits = true
local window = {x = 0, y = 0, fullscreen = false, ColorAlpha = 1}
local clock = {ticks = 0, seconds = 0, till = 0}
local game = {whiteDone = false}
local debug = true
local debugstat = {status = "Unknown"}
local font = love.graphics.getFont()

function love.load()
    font = love.graphics.setFont()
    menuMusic = love.audio.newSource("/assets/audio/menu.mp3", "stream")
    clock.ticks = 0
end

function love.update(dt)
    if love.timer.getFPS() < 60 then
        love.timer.sleep(1 / 60 - love.timer.getDelta())
    end
    -- Debug Status
    if love.keyboard.isDown("f1") then
        if debug then
            debug = false
        elseif not debug then
            debug = true
        end
    end
    if debug then
        debugstat.status = "Enabled"
    elseif not debug then
        debugstat.status = "Disabled"
    else
        debugstat.status = "Unknown"
    end
    
    clock.ticks = clock.ticks + 1

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
    end
    
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
    end

    if
        (love.keyboard.isDown("right") or love.keyboard.isDown("left")) and
            (love.keyboard.isDown("down") or love.keyboard.isDown("up"))
     then
        player.speed = 0.7071 -- 1/sqrt(2)
    else
        player.speed = 1
    end
end

function love.draw()
    if player.inMenu then
        mainMenu()
    end

    if player.inGame then
        drawGame()
        if not window.ColorAlpha == 1 then
            window.ColorAlpha = window.ColorAlpha - 0.01
            game.whiteDone = true
        end
    end

    if player.inCredits then
        credits()
    end
end

function credits()
    love.audio.play(menuMusic)
    love.audio.setVolume(1.0)
    local credit = ""
    if debug then
        love.graphics.print(
        "Debug Status: " .. debugstat.status .. "\nGame Ticks: " .. clock.ticks,
            10,
            10
        )
    end

    if clock.ticks >= 700 then
        player.inMenu = true
        player.inCredits = false
    elseif clock.ticks >= 550 then
        credit = "Enjoy the game!"
    elseif clock.ticks >= 400 then
        credit = "Programming by QuickMash"
    elseif clock.ticks >= 350 then
        credit = "Sound Effects by Nokkvi"
    elseif clock.ticks >= 250 then
        credit = "Music by Nokkvi"
    elseif clock.ticks >= 150 then
        credit = "Game/Map Design by Quackers"
    else
        credit = "Game by QuickMash Games"
    end
    if love.keyboard.isDown("return") then
        player.inCredits = false
        player.inMenu = true
    end
    local textWidth = font:getWidth(credit)
    local textHeight = font:getHeight(credit)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(credit, (screenWidth - textWidth) / 2, (screenHeight - textHeight) / 2)
end

function rainCranberries()
    -- Make the background(behind the press enter to start)
end

function mainMenu()
    rainCranberries()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local title1Width = font:getWidth("You were not supposed to know about the Cranberries")
    local title1Height = font:getHeight("You were not supposed to know about the Cranberries")
    love.window.setTitle("YWNSATC V1.0 - Main Menu")
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.print("You were not supposed to know about the Cranberries", (screenWidth - title1Width) / 2, (screenHeight - title1Height) - (screenHeight - 100))
    love.graphics.setColor(1, 0, .5, 1)
    love.graphics.print("Press Enter to Start", window.x - 10, window.y + 10)
end

function drawGame()
    love.graphics.setColor(1, 1, 1, window.ColorAlpha)
    love.graphics.rectangle("fill", window.x, window.y, love.graphics.getWidth(), love.graphics.getHeight())
    openingSound:play()
    if game.whiteDone then
        -- Tell Sound to stop
        -- level1:draw()
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print("EEE", 10, 10)
    end
end
