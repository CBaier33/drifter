local StateManager = { 
  current = nil,
  gameActive = nil
}

local Game = require('game.game')
local StartMenu = require('menus.start.menu')

function StateManager:switch(newState, manager)
  if self.current and self.current.exit then
    self.current:exit()
  end

  if newState == "start" then
    self.current = StartMenu
    self.gameActive = false
    self.current:load(manager)
  elseif newState == "game" then
    self.current = Game:new(manager)
    self.gameActive = true
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

function StateManager:gameOver()
  self.gameActive = false
end

function StateManager:isGameActive()
  return self.gameActive
end

return StateManager
