local StateManager = require('StateManager')

function love.load()
  StateManager:switch("start", StateManager)
end

function love.update(dt)
  StateManager:update(dt)
end

function love.draw()
  StateManager:draw()
end

