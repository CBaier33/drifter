local Menu = {}
local Game = require('game.game')
local Buttons = require('menu.buttons')

function Menu:load(stateManager)
  self.stateManager = stateManager
  Buttons:load(function()
    self.stateManager:switch(Game, self.stateManager)
  end)

end

function Menu:update(dt)
  Buttons:update(dt)
end

function Menu:draw()
  Buttons:draw()
end

return Menu
