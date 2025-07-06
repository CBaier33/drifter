local StartMenu = {}
local Game = require('game.game')
local Buttons = require('menus.start.buttons')

function StartMenu:load(stateManager)
  self.stateManager = stateManager
  Buttons:load(function()
    self.stateManager:switch(Game, self.stateManager)
  end)

end

function StartMenu:update(dt)
  Buttons:update(dt)
end

function StartMenu:draw()
  Buttons:draw()
end

return StartMenu
