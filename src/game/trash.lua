local anim8 = require 'libs/anim8'

local TrashPile = {}
TrashPile.__index = TrashPile

function TrashPile:new()
  local self = setmetatable({}, TrashPile)

  self.width = 44
  self.height = 74

  self.speed = 1100
  self.mobile = false

  return self

end

function TrashPile:load(xCoord)
  self.x = xCoord
  self.y = -100

  self.frameNum = 2  -- how many frames are in this animation
  self.spritesheet = love.graphics.newImage('game/images/trash-sprite-sheet.png')
  self.animation = self:buildAnimation()

end

function TrashPile:move(dt)
  self.y = self.y + self.speed * dt
  self.animation:update(dt)

end

function TrashPile:draw()
  local scaleX = self.width / (self.spritesheet:getWidth() / self.frameNum)
  local scaleY = self.height / self.spritesheet:getHeight()
  --love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
  self.animation:draw(self.spritesheet, self.x, self.y, 0, scaleX, scaleY)
end

function TrashPile:buildAnimation()
  local g = anim8.newGrid(self.width, self.height, self.spritesheet:getWidth(), self.spritesheet:getHeight())

  return anim8.newAnimation(g('1-' .. self.frameNum .. '', 1), 1)

end

return TrashPile
