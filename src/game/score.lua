local Score = {}

function Score:load()
  self.width = 60
  self.height = 60

  self.x = 10
  self.y = 10

  self.font = love.graphics.getFont() -- default font
  self.textHeight = self.font:getHeight()

  self.score = 0

  self.crash = false

end

function Score:update(dt)
  if not self.crash then
    self.score = self.score + dt
  end
end

function Score:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

  love.graphics.setColor(0,0,0)
  love.graphics.printf(string.format("%d", self.score * 1000), self.x, self.y + (self.height - self.textHeight) / 2, self.width, "center")
  love.graphics.setColor(1, 1, 1, 1)

end

function Score:setCrash()
  self.crash = true

end

return Score
