Button = {}
Button.__index = Button

function Button:new(label, x, y, width, height, onClick)
    local btn = {
        label = label,
        x = x,
        y = y,
        width = width,
        height = height,
        onClick = onClick,
        isHovered = false
    }
    setmetatable(btn, Button)
    return btn
end

function Button:draw()
    if self.isHovered then
        love.graphics.setColor(0.8, 0.8, 0.8)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.label, self.x, self.y + self.height / 2 - 6, self.width, "center")
end

function Button:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    self.isHovered = mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height
end

function Button:mousepressed(x, y, button)
    if button == 1 and self.isHovered then
        self.onClick()
    end
end

return Button