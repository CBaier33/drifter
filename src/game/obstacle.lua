local Obstacle = {}
Obstacle.__index = Obstacle

local Car = require('game.car')
local Truck = require('game.truck')
local TrashPile = require('game.trash')

function Obstacle:load()
  self.table = {}
  self.newObstacle(self)

end

function Obstacle:update(dt)
  for _, obstacle in ipairs(self.table) do
    obstacle:move(dt)
  end

  -- adds new obstacle when necessary
  local last = self.table[#self.table]
  if last and last.y > love.graphics.getHeight() / 4 then
    self:newObstacle()
  end

  -- deletes obstacles that are gone
  if #self.table > 0 and self.table[1].y > love.graphics.getHeight() then
    table.remove(self.table, 1)
  end

end

function Obstacle:draw()
  for _, obstacle in ipairs(self.table) do
    obstacle:draw()
  end

end

function Obstacle:newObstacle()

  local newObstacle = self:generateObstacle()
  newObstacle:load()

  while #self.table > 0 and self:obstacleInLane(newObstacle.x, newObstacle.width) do
    newObstacle = self:generateObstacle()
    newObstacle:load()
  end

  table.insert(self.table, newObstacle)

end

function Obstacle:generateObstacle()
  local obstacleType = math.random(3)
  local obstacle = nil

  if obstacleType == 1 then
    obstacle = Car:new()

  elseif obstacleType == 2 then
    obstacle = Truck:new()

  else
    obstacle = TrashPile:new()

  end

  return obstacle

end

function Obstacle:obstacleInLane(x, width)
  for _, value in pairs(self.table) do
    if x + width >= value.x and x <= value.x + value.width then
      return true
    end
  end
  return false

end

function Obstacle:checkCollision(player)
  for _, obstacle in ipairs(self.table) do
    if player.x < obstacle.x + obstacle.width and
       obstacle.x < player.x + player.width and
       player.y < obstacle.y + obstacle.height and
       obstacle.y < player.y + player.height then
         return true
    end

  return false

  end

end

return Obstacle

