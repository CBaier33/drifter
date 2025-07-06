local StateManager = require('StateManager')
local Game = require('game.game')
local StartMenu = require('menus.start.menu')

function love.load()
    StateManager:switch(StartMenu, StateManager)
end

function love.update(dt)
  StateManager:update(dt)
end

function love.draw()
  StateManager:draw()
end

