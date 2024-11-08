-- Author: QuickMash
-- Version: 1.0
-- Title: You Were Not Supposed to Know About the Cranberrys
-- Licence: Coming soon!
local player = {x=0, y=0, speed=1, sprite=false, inMenu=false, inGame=false, inCredits=true}
local window = {x=0, y=0, fullscreen=false, ColorAlpha=1}
local save = {path="save.txt", first=true}
local clock = {ticks=0, seconds=0, till = 0}
local game = {whiteDone=false}
local debug = false
local deviceInfo = love.system.getOS()

function love.load()
    local mainMenu = love.audio.newSource("assets/music/1.ogg", "stream")
    mainMenu:setLooping(true)
    local openingSound = love.audio.newSource("assets/sounds/opening.ogg", "stream")
end

function love.update(dt)
    if love.timer.getFPS() < 60 then
        love.timer.sleep(1/60 - love.timer.getDelta())
    end
    -- Ticks
    clock.ticks = clock.ticks + 1
    if clock.ticks == 60 then
        clock.seconds = clock.seconds + 1
    end
    -- Movement
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

    if (love.keyboard.isDown("right") or love.keyboard.isDown("left")) and 
       (love.keyboard.isDown("down") or love.keyboard.isDown("up")) then
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
        game()
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
    local creditCard = 0
    local credits = ""
    love.graphics.print(credits, (love.graphics.getWidth() - love.graphics.getFont():getWidth(credits)) / 2, (love.graphics.getHeight() - love.graphics.getFont():getHeight()) / 2)
    if creditCard == 0 then
        credits = "Game by QuickMash Games"
        clock.till = 10 + clock.seconds()
        if clock.seconds() >= clock.till then
            creditCard = 1
        end
    elseif creditCard == 1 then
        credits = "Art by "
        clock.till = 10 + clock.seconds()
        if clock.seconds() >= clock.till then
            creditCard = 2
        end
    elseif creditCard == 2 then
        credits = "Music by Nokkvi"
        clock.till = 10 + clock.seconds()
        if clock.seconds() >= clock.till then
            creditCard = 3
        end
    elseif creditCard == 3 then
        credits = "Sound by Nokkvi"
        clock.till = 10 + clock.seconds()
        if clock.seconds() >= clock.till then
            creditCard = 4
        end
    elseif creditCard == 4 then
        credits = "Programming by QuickMash"
        clock.till = 10 + clock.seconds()
        if clock.seconds() >= clock.till then
            creditCard = 5
        end
    elseif creditCard == 5 then
        credits = "Design by Quackers"
        clock.till = 10 + clock.seconds()
        if clock.seconds() >= clock.till then
            creditCard = 6
        end
    elseif creditCard == 6 then
        credits = "Enjoy the Game!"
        clock.till = 12 + clock.seconds()
        if clock.seconds() >= clock.till then
            player.inMenu = true
        end
    end
end

function mainMenu()
    love.window.setTitle("YWNSATC V1.0 - Main Menu")
    love.graphics.setBackgroundColor(0,1,0,.5)
    love.graphics.print("You were not supposed to know about the cranberrys", 10, 10)
    love.graphics.print("By QuickMash Games", window.x - 10, window.y - 10)
    love.graphics.setColor(1,0,.5, 1)
    love.graphics.print("Press Enter to Start", window.x - 10, window.y + 10)
end

function game()
    love.graphics.setColor(1, 1, 1, window.ColorAlpha)
    love.graphics.rectangle(fill, window.x, window.y)
    openingSound:play()
    if game.whiteDone then
        openingSound:stop() -- just to be safe...
        -- level1:draw()
        love.graphics.setcolor(0, 0, 0, 1)
        love.graphics.print("EEE",10,10)
    end
end