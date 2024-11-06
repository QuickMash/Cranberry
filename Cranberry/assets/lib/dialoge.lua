-- dialoge.lua

local Dialog = {}
Dialog.__index = Dialog

function Dialog:new(text, x, width, height, font)
    local self = setmetatable({}, Dialog)
    self.text = text
    self.x = x
    self.width = width
    self.height = height
    self.font = font or love.graphics.getFont()
    self.y = love.graphics.getHeight() - height -- Anchor to the bottom
    self.visible = false
    self.currentText = ""
    self.textSpeed = 0.05
    self.timer = 0
    self.charIndex = 1
    return self
end

function Dialog:show()
    self.visible = true
    self.currentText = ""
    self.timer = 0
    self.charIndex = 1
end

function Dialog:hide()
    self.visible = false
end

function Dialog:update(dt)
    if self.visible then
        self.timer = self.timer + dt
        if self.timer >= self.textSpeed then
            self.timer = 0
            if self.charIndex <= #self.text then
                self.currentText = self.currentText .. self.text:sub(self.charIndex, self.charIndex)
                self.charIndex = self.charIndex + 1
            end
        end
    end
end

function Dialog:draw()
    if self.visible then
        love.graphics.setFont(self.font)
        love.graphics.printf(self.currentText, self.x, self.y, self.width)
    end
end

return Dialog