local ObstacleTable = {}
ObstacleTable.__index = ObstacleTable

local Car = require('game.car')
local Truck = require('game.truck')
local TrashPile = require('game.trash')

function ObstacleTable:load()
  self.table = {}
  self.crash = false
  self:newObstacle(nil)

end

function ObstacleTable:update(dt)
  for _, obstacle in ipairs(self.table) do
    if not self.crash or (self.crash and obstacle.mobile) then
      obstacle:move(dt)
    end

  end
  -- prunes table of obstacles that are gone
  self:clearTable()

end

function ObstacleTable:draw()
  for _, obstacle in ipairs(self.table) do
    obstacle:draw()
  end

end

function ObstacleTable:newObstacle(player)

  local newObstacle = self:generateObstacle()
  local x = math.random(0, 500)
  local i = 0

  while #self.table > 0 and (not self:validSpawnPoint(x, newObstacle.width, player)) do
    x = math.random(0, 500)
    i = i + 1
    if i > 500 then
      return
    end
  end

  newObstacle:load(x)

  table.insert(self.table, newObstacle)

end

function ObstacleTable:validSpawnPoint(x, width, player)
  for _, value in pairs(self.table) do
    if x + width >= value.x and x <= value.x + value.width then
      return false
    end
    if self.crash and player and x + width >= player.x and x <= player.x + player.width then
      return false
    end
  end
  return true
end


function ObstacleTable:generateObstacle()
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

function ObstacleTable:checkCollision(player)
  for _, obstacle in ipairs(self.table) do
    if (player.x < obstacle.x + obstacle.width and
        obstacle.x < player.x + player.width and
        player.y < obstacle.y + obstacle.height and
        obstacle.y < player.y + player.height) then
         obstacle.mobile = false
         return true
    end
  end

  return false

end

function ObstacleTable:registerCrash()
  self.crash = true

end

function ObstacleTable:clearTable()
  for i, obstacle in ipairs(self.table) do
    if obstacle.y > love.graphics.getHeight() then
      table.remove(self.table, i)
    end
  end
end


return ObstacleTable
