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
  self.fire = false

  self.movementFrameNum = 21 -- how many frames are in this animation
  self.movementSpritesheet = love.graphics.newImage('game/images/driver-sprite-sheet.png')
  self.movementAnimation = self:buildMovementAnimation()

  self.crashFrameNum = 87
  self.crashSpritesheet = love.graphics.newImage('game/images/driver-sprite-sheet-collision.png')
  self.crashAnimation = self:buildCrashAnimation()

  self.fireFrameNum = 12
  self.fireSpritesheet = love.graphics.newImage('game/images/driver-sprite-sheet-fire.png')
  self.fireAnimation = self:buildFireAnimation()


end

function Player:update(dt)
  if not self.crash then
    self.movementAnimation:update(dt)

  elseif self.crash and not self.fire then
    self.crashAnimation:update(dt)

    -- set fire to true when crash animation finishes
    local currentFrame = math.floor(self.crashAnimation.position) + 1
    if currentFrame == #self.crashAnimation.frames then
      self.fire = true
    end

  end

  if self.fire then
    self.fireAnimation:update(dt)
  end

  if self.y > love.graphics.getHeight() - 200 then
    self:initPosition()
  else
    self:move(dt)
  end

end

function Player:buildMovementAnimation()
  local g = anim8.newGrid(self.width, self.height, self.movementSpritesheet:getWidth(), self.movementSpritesheet:getHeight())
  return anim8.newAnimation(g('1-' .. self.movementFrameNum .. '', 1), .02)

end

function Player:buildCrashAnimation()
  local g = anim8.newGrid(self.width, self.height, self.crashSpritesheet:getWidth(), self.crashSpritesheet:getHeight())
  return anim8.newAnimation(g('1-' .. self.crashFrameNum .. '', 1), .03, 'pauseAtEnd')

end

function Player:buildFireAnimation()
  local g = anim8.newGrid(self.width, self.height, self.fireSpritesheet:getWidth(), self.fireSpritesheet:getHeight())
  return anim8.newAnimation(g('1-' .. self.fireFrameNum .. '', 1), .03)

end

function Player:initPosition()
  self.y = self.y - 2

end

function Player:registerCrash()
  self.width = 80
  self.height = 113
  self.crash = true
  self.y = self.y - 32
  self.x = self.x - 18

  self.crashAnimation = self:buildCrashAnimation()
  self.fireAnimation = self:buildFireAnimation()

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
    if (self.vx < 0 and self.x <= (love.graphics.getWidth() * 0.5 - self.width * 0.5) - 180) or
       (self.vx > 0 and self.x >= (love.graphics.getWidth() * 0.5 - self.width * 0.5) + 180) then
      self.x = self.x - self.vx * dt
    else
      self.x = self.x + self.vx * dt
    end

  end
end

function Player:draw()
  if not self.crash then
    local scaleX = self.width / (self.movementSpritesheet:getWidth() / self.movementFrameNum)
    local scaleY = self.height / self.movementSpritesheet:getHeight()

    self.movementAnimation:draw(self.movementSpritesheet, self.x, self.y, 0, scaleX, scaleY)

  elseif self.fire then
    local scaleX = self.width / (self.fireSpritesheet:getWidth() / self.fireFrameNum)
    local scaleY = self.height / self.fireSpritesheet:getHeight()

    self.fireAnimation:draw(self.fireSpritesheet, self.x, self.y, 0, scaleX, scaleY)


  else
    local scaleX = self.width / (self.crashSpritesheet:getWidth() / self.crashFrameNum)
    local scaleY = self.height / self.crashSpritesheet:getHeight()

    self.crashAnimation:draw(self.crashSpritesheet, self.x, self.y, 0, scaleX, scaleY)
  end

end

return Player
