local anim8 = require 'libs/anim8'
local Player = {}

function Player:load()
  self.width = 45
  self.height = 80

  self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
  self.y = love.graphics.getHeight() + 50

  self.vx = 0                   -- horizontal velocity
  self.acceleration = 900      -- how fast input builds velocity
  self.maxSpeed = 500          -- max horizontal speed
  self.driftForce = 100        -- how strongly car drifts back to center

  self.crash = false

  self.image = love.graphics.newImage('images/Player_small.png')
  self.movementSpritesheet = love.graphics.newImage('images/driver-sprite-sheet.png')
  self.movementAnimation = self:buildAnimation()
end

function Player:update(dt)
  if not self.crash then  
    self.movementAnimation:update(dt)
  end

  if self.y > love.graphics.getHeight() - 200 then
    self:initPosition()
  else
    self:move(dt)
  end

end

function Player:buildAnimation()
  local g = anim8.newGrid(self.width, self.height, self.movementSpritesheet:getWidth(), self.movementSpritesheet:getHeight())
  
  return anim8.newAnimation(g('1-21', 1), .02)
end

function Player:initPosition()
  self.y = self.y - 2

end

function Player:registerCrash()
  self.crash = true

end

function Player:move(dt)
  local movingLeft = love.keyboard.isDown("a")
  local movingRight = love.keyboard.isDown("d")

  if not self.crash then
    if movingLeft and not movingRight then
      if self.vx > 0 then
        -- actively braking
        self.vx = self.vx - self.acceleration * 3 * dt
      else
        -- normal acceleration left
        self.vx = self.vx - self.acceleration * dt
      end
    elseif movingRight and not movingLeft then
      if self.vx < 0 then
        -- actively braking
        self.vx = self.vx + self.acceleration * 3 * dt
      else
        -- normal acceleration right
        self.vx = self.vx + self.acceleration * dt
      end
    else
      -- no input = light friction (passive slow down)
      self.vx = self.vx * 0.97
      if math.abs(self.vx) < 1 then self.vx = 0 end
    end

    -- Clamp velocity
    self.vx = math.max(math.min(self.vx, self.maxSpeed), -self.maxSpeed)

    -- Move player
    self.x = self.x + self.vx * dt

  end
end

function Player:draw()
  local scaleX = self.width / (self.movementSpritesheet:getWidth() / 21)
  local scaleY = self.height / self.movementSpritesheet:getHeight()
  --love.graphics.draw(self.movementSpritesheet, self.x, self.y, 0, scaleX, scaleY)
  self.movementAnimation:draw(self.movementSpritesheet, self.x, self.y, 0, scaleX, scaleY)
end

return Player
