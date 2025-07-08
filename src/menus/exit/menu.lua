local ExitMenu = {
  Buttons = require('menus.exit.buttons'),
}

function ExitMenu:load(stateManager, menuManager)
  self.stateManager = stateManager
  self.menuManager = menuManager
  self.Buttons:load(self.stateManager, self.menuManager)
  self.active = false
end

function ExitMenu:update(dt)
  self.Buttons:update(dt)
end

function ExitMenu:draw()
  if (self.active) then
    self.Buttons:draw()
  end
end

function ExitMenu:open()
  self.active = true
end

function ExitMenu:close()
  self.active = false
end

return ExitMenu
