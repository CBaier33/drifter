local Obstacle = {}
Obstacle.__index = Obstacle

local Car = require('game.car')
local Truck = require('game.truck')
local TrashPile = require('game.trash')

function Obstacle:load()
  self.table = {}
  self.crash = false
  self:newObstacle()

end

function Obstacle:update(dt)
  print(#self.table)
  for _, obstacle in ipairs(self.table) do
    if not self.crash or (self.crash and obstacle.mobile) then
      obstacle:move(dt)
    end

  end
  -- prunes table of obstacles that are gone
  self:clearTable()

end

function Obstacle:draw()
  for _, obstacle in ipairs(self.table) do
    obstacle:draw()
  end

end

function Obstacle:newObstacle()

  local newObstacle = self:generateObstacle()
  newObstacle:load()

  if #self.table > 0 and self:obstacleInLane(newObstacle.x, newObstacle.width) then
    return
  end
  table.insert(self.table, newObstacle)

end

function Obstacle:generateObstacle()
  local obstacleType = math.random(3)
  if self.crash then
    obstacleType = math.random(2)
  end
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
  end

  return false

end

function Obstacle:registerCrash()
  self.crash = true

end

function Obstacle:clearTable()
  for i, obstacle in ipairs(self.table) do
    if obstacle.y > love.graphics.getHeight() then
      table.remove(self.table, i)
    end
  end
end


return Obstacle
