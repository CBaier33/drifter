local ButtonsClass = require('menus.pause.buttons')

local PauseMenu = {
  Buttons = nil
}

function PauseMenu:load(stateManager, menuManager)
  self.stateManager = stateManager
  self.menuManager = menuManager
  self.Buttons = ButtonsClass.new()
  self.Buttons:load(self.stateManager, self.menuManager)
  self.active = false
end

function PauseMenu:update(dt)
  self.Buttons:update(dt)
end

function PauseMenu:draw()
  if (self.active) then
    self.Buttons:draw()
  end
end

function PauseMenu:open()
  self.active = true
end

function PauseMenu:close()
  self.active = false
end

return PauseMenu
