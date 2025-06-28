local Player = {}

function Player:load()
  self.width = 50
  self.height = 50

  self.x = love.graphics.getWidth() / 2 - self.width / 2
  self.y = love.graphics.getHeight() + 50

  self.speed = 500
  self.moveDir = 'n'
  self.crash = false

end

function Player:update(dt)
  if Player.y > love.graphics.getHeight() - 200 then
    Player:initPosition()
  else
    Player:move(dt)
  end

end

function Player:initPosition()
  self.y = self.y - 2
end

function Player:encounterObject()
  self.moveDir = 'c'
  self.crash = true
end

-- player movement methods
function Player:move(dt) 

  -- determine if player is moving
  if self.moveDir == 'l' and not self:atBoundary("l") then
    self.x = self.x - self.speed * dt
    self.speed = self.speed - 5

  elseif self.moveDir == 'r' and not self:atBoundary("r") then
    self.x = self.x + self.speed * dt
    self.speed = self.speed - 5

  elseif self.moveDir == 'c' then
    self.speed = 0

  end

  -- change player direction
  if love.keyboard.isDown("a") and self.moveDir ~= 'c' then
    self.speed = 500
    self.moveDir = 'l'
  elseif love.keyboard.isDown("d") and self.moveDir ~='c' then
    self.speed = 500
    self.moveDir = 'r'

  -- prevent speed from going negative or passing boundaries
  elseif (self.speed <= 0 or self:atBoundary("l") or self:atBoundary("r")) and (self.crash == false) then
    self.moveDir = 'n'
  end

end

function Player:atBoundary(dir)
  local left = 0
  local right = love.graphics.getWidth()

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
