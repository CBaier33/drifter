local StateManager = { current = nil }

local Game = require('game.game')
local StartMenu = require('menus.start.menu')

function StateManager:switch(newState, manager)
  if self.current and self.current.exit then
    self.current:exit()
  end

  if newState == "start" then
    self.current = StartMenu
  elseif newState == "game" then
    self.current = Game
  end

  if self.current.load then
    self.current:load(manager)
  end
end

function StateManager:update(dt)
  if self.current and self.current.update then
    self.current:update(dt)
  end
end

function StateManager:draw()
  if self.current and self.current.draw then
    self.current:draw()
  end
end

return StateManager
