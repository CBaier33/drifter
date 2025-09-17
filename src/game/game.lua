local Game = {}
Game.__index = Game

-- Dependencies
local Player = require('game.player')
local ObstacleTable = require('game.obstacleTable')
local Road = require('game.road')
local Menus = require('menus.menus')
local Score = require('game.score')

function Game:new(stateManager)
  local self = setmetatable({}, Game)

  self.stateManager = stateManager
  self.gameActive = true -- temp to avoid crashes after collision

  self.gameTime = 0
  self.spawnTimer = 0

  Menus:load(stateManager)
  Road:load()
  Player:load()
  ObstacleTable:load()
  Score:load()

  return self

end

function Game:update(dt)
  Menus:update(dt)
  self.gameTime = self.gameTime + dt
  self.spawnTimer = self.spawnTimer + dt

  if Menus.menuManager:isPaused() then
    return
  end

  Player:update(dt)
  Road:update(dt)

  if self.gameTime < 1 then return end

  Score:update(dt)
  ObstacleTable:update(dt)

  if self.spawnTimer >= .75 and self.gameActive then
    ObstacleTable:newObstacle(Player)
    self.spawnTimer = 0
  end

  if self:playerObjectCheckCollision() and self.gameActive then
    Player:registerCrash()
    ObstacleTable:registerCrash()
    Road:registerCrash()
    Score:setCrash()
    self.gameActive = false
    self.stateManager:gameOver()
    -- trigger menus, etc.
  end

end


function Game:draw()
  Road:draw()
  Score:draw()
  ObstacleTable:draw()
  Player:draw()
  Menus:draw()

end

function Game:playerObjectCheckCollision()
  return ObstacleTable:checkCollision(Player)

end

return Game

