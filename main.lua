local Player = require("player")
local Obstacle = require("obstacle")

-- obstacles table
local obstacles = {}

function love.load()
  Player:load()
  local o = Obstacle:new()
  o:load()
  table.insert(obstacles, o)

end

function love.update(dt)
  Player:update(dt)
  for _, obstacle in ipairs(obstacles) do
    obstacle:update(dt)
  end

  -- load in new obstacle when last obstacle reaches screen
  local last = obstacles[#obstacles]
  if (last.obstacle.y > 50) then
    newObstacle()
  end

  -- remove obstacle once its off the screen
  if obstacles[1].obstacle.y > 800 then
    table.remove(obstacles, 1)
  end

end

function love.draw()
  Player:draw()
  for _, barrier in ipairs(obstacles) do
    barrier:draw()
  end

end

-- function to create new barriers
function newObstacle()
  local newObstacle = Obstacle:new()
  newObstacle:load()
  table.insert(obstacles, newObstacle)

end

