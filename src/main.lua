local StateManager = require("StateManager")
local Game = require('game/game')
local Menu = require('menu/menu')

function love.load()
    StateManager:switch(Menu, StateManager)
end

function love.update(dt)
  StateManager:update(dt)
end

function love.draw()
  StateManager:draw()
end

