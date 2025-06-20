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
  if (last.obstacle.y > 200) then
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

  -- ensure that no obstacles are ever in the same lane
  while #obstacles > 0 and obstacleInLane(obstacles, newObstacle.obstacle.x, newObstacle.obstacle.width) do
    newObstacle = nil
    newObstacle = Obstacle:new()
    newObstacle:load()
  end

  table.insert(obstacles, newObstacle)

end

-- helper function for checking if obstacles table contains an obstacle in that lane
function obstacleInLane(table, x, width)
  for _, value in pairs(table) do
    if x + width >= value.obstacle.x and x <= value.obstacle.x + value.obstacle.width then
      return true
    end
  end

  return false

end

