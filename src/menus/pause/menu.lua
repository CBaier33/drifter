local PauseMenu = {}

local Buttons = require('menus.pause.buttons')
-- add functionality in game to stop all movement
-- while also saving state.

function PauseMenu:load(stateManager)
  self.stateManager = stateManager
  Buttons:load(self.stateManager)
  self.active = false
end

function PauseMenu:update(dt)
  Buttons:update(dt)
end

function PauseMenu:draw()
  if (self.active) then
    Buttons:draw()
  end
end

function PauseMenu:open()
  self.active = true
end

function PauseMenu:close()
  self.active = false
end

return PauseMenu
