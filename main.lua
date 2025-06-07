local Player = require("player")
local Barrier = require("barrier")

-- barriers table
local barriers = {}

function love.load()
  Player:load()
  local b = Barrier:new()
  b:load()
  table.insert(barriers, b)

end

function love.update(dt)
  print(#barriers)
  Player:update(dt)
  for _, barrier in ipairs(barriers) do
    barrier:update(dt)
  end

  -- load in new barrier when last barrier reaches screen
  local last = barriers[#barriers]
  if (last.left.y > 50) then
    newBarrier()
  end

  -- remove barriers once its off the screen
  if barriers[1].left.y > 800 then
    table.remove(barriers, 1)
  end

end

function love.draw()
  Player:draw()
  for _, barrier in ipairs(barriers) do
    barrier:draw()
  end

end

-- function to create new barriers
function newBarrier()
  local newBarrier = Barrier:new()
  newBarrier:load()
  table.insert(barriers, newBarrier)

end

