local anim8 = require 'libs/anim8'

local TrashPile = {}
TrashPile.__index = TrashPile

function TrashPile:new()
  local self = setmetatable({}, TrashPile)

  self.width = 55
  self.height = 93

  self.speed = 1100
  self.mobile = false

  self.crash = false

  return self

end

function TrashPile:load(xCoord)
  self.x = xCoord
  self.y = -100

  self.frameNum = 2  -- how many frames are in this animation
  self.spritesheet = love.graphics.newImage('game/images/trash-sprite-sheet.png')
  self.animation = self:buildAnimation()

end

function TrashPile:update(dt)
  self.animation:update(dt)

  if not self.crash then
    self:move(dt)
  end
end

function TrashPile:move(dt)
  self.y = self.y + self.speed * dt

end

function TrashPile:setCrash()
  self.crash = true
end

function TrashPile:draw()
  local scaleX = self.width / (self.spritesheet:getWidth() / self.frameNum)
  local scaleY = self.height / self.spritesheet:getHeight()

  self.animation:draw(self.spritesheet, self.x, self.y, 0, scaleX, scaleY)
end

function TrashPile:buildAnimation()
  local g = anim8.newGrid(self.width, self.height, self.spritesheet:getWidth(), self.spritesheet:getHeight())

  return anim8.newAnimation(g('1-' .. self.frameNum .. '', 1), .5)

end

function TrashPile:randomSpawnX()
  local spawn = math.random(1, 5)
  local locMap = {}
  locMap[1] = (love.graphics.getWidth() * 0.5 - 200) + 20
  locMap[2] = (love.graphics.getWidth() * 0.5 - 200) + 100
  locMap[3] = (love.graphics.getWidth() * 0.5 - 200) + 173
  locMap[4] = (love.graphics.getWidth() * 0.5 - 200) + 252
  locMap[5] = (love.graphics.getWidth() * 0.5 - 200) + 323

  return locMap[spawn]

end

return TrashPile
