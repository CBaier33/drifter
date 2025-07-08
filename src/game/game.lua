local Game = {}
Game.__index = Game

-- Dependencies
local Player = require('game.player')
local Obstacle = require('game.obstacle')
local Road = require('game.road')
local Menus = require('menus.menus')

function Game:new(stateManager)
  local self = setmetatable({}, Game)

  self.stateManager = stateManager
  self.obstacles = {}
  self.gameTime = 0

  Menus:load(stateManager)
  Road:load()
  Player:load()

  local o = Obstacle:new()
  o:load()
  table.insert(self.obstacles, o)

  return self
end

function Game:update(dt)
  Menus:update(dt)
  self.gameTime = self.gameTime + dt

  Player:update(dt)

  if self.gameTime < 1 then return end

  for _, obstacle in ipairs(self.obstacles) do
    obstacle:update(dt)
  end

  for _, obstacle in ipairs(self.obstacles) do
    if self:playerObjectCheckCollision(Player, obstacle) then
      Player:encounterObject()
      -- trigger menus, etc.
    end
  end

  local last = self.obstacles[#self.obstacles]
  if last and last.obstacle.y > love.graphics.getHeight() / 4 then
    self:newObstacle()
  end

  if #self.obstacles > 0 and self.obstacles[1].obstacle.y > love.graphics.getHeight() then
    table.remove(self.obstacles, 1)
  end
end

function Game:draw()
  Road:draw()
  Player:draw()

  for _, barrier in ipairs(self.obstacles) do
    barrier:draw()
  end

  Menus:draw()
end

function Game:newObstacle()
  local newObstacle = Obstacle:new()
  newObstacle:load()

  while #self.obstacles > 0 and self:obstacleInLane(newObstacle.obstacle.x, newObstacle.obstacle.width) do
    newObstacle = Obstacle:new()
    newObstacle:load()
  end

  table.insert(self.obstacles, newObstacle)
end

function Game:obstacleInLane(x, width)
  for _, value in pairs(self.obstacles) do
    if x + width >= value.obstacle.x and x <= value.obstacle.x + value.obstacle.width then
      return true
    end
  end
  return false
end

function Game:playerObjectCheckCollision(player, obstacle)
  return player.x < obstacle.obstacle.x + obstacle.obstacle.width and
         obstacle.obstacle.x < player.x + player.width and
         player.y < obstacle.obstacle.y + obstacle.obstacle.height and
         obstacle.obstacle.y < player.y + player.height
end

return Game

