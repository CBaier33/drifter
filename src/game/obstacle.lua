local Obstacle = {}
Obstacle.__index = Obstacle

local Car = require('game.car')
local Truck = require('game.truck')
local TrashPile = require('game.trash')

function Obstacle:new()
  local self = setmetatable({}, Obstacle)
  return self

end

function Obstacle:load()
  self.obstacleType = math.random(3)
  self.obstacle = nil

  if self.obstacleType == 1 then
    self.obstacle = Car:new()

  elseif self.obstacleType == 2 then
    self.obstacle = Truck:new()

  elseif self.obstacleType == 3 then
    self.obstacle = TrashPile:new()

  end

  self.obstacle:load()

end

function Obstacle:update(dt)
  self.obstacle:move(dt)

end

function Obstacle:draw()
  self.obstacle:draw()

end

return Obstacle
