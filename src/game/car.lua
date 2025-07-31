local anim8 = require 'libs/anim8'

local Car = {}
Car.__index = Car

function Car:new()
  local self = setmetatable({}, Car)

  self.width = 50
  self.height = 80

  self.speed = 300
  self.mobile = true

  return self

end

function Car:load(xCoord)
  self.x = xCoord
  self.y = -80

  self.movementFrameNum = 21  -- how many frames are in this animation
  self.movementSpritesheet = love.graphics.newImage('game/images/car-sprite-sheet.png')
  self.movementAnimation = self:buildAnimation()

end

function Car:move(dt)
  self.y = self.y + self.speed * dt

  if self.mobile then
    self.movementAnimation:update(dt)
  end
end

function Car:buildAnimation()
  local g = anim8.newGrid(self.width, self.height, self.movementSpritesheet:getWidth(), self.movementSpritesheet:getHeight())

  return anim8.newAnimation(g('1-' .. self.movementFrameNum .. '', 1), .05)
end

function Car:draw()
  local scaleX = self.width / (self.movementSpritesheet:getWidth() / self.movementFrameNum)
  local scaleY = self.height / self.movementSpritesheet:getHeight()
  --love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
  self.movementAnimation:draw(self.movementSpritesheet, self.x, self.y, 0, scaleX, scaleY)
end

return Car
