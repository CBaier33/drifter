local Player = {}

function Player:load()
  self.width = 50
  self.height = 50

  self.x = love.graphics.getWidth() / 2 - self.width / 2
  self.y = love.graphics.getHeight() - 200

  self.speed = 500

end

function Player:update(dt)
  Player:move(dt)

end

-- player movement methods

function Player:move(dt)
  if love.keyboard.isDown("a") and not self:atBoundary("l") then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown("d") and not self:atBoundary("r") then
    self.x = self.x + self.speed * dt
  end
end

function Player:atBoundary(dir)
  local left = love.graphics.getWidth()/3
  local right = love.graphics.getWidth()/3*2

  if dir == "l" then
    return self.x < left
  elseif dir == "r" then
    return self.x + self.width > right
  end
end

function Player:draw()
  -- temporary player sprite
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
