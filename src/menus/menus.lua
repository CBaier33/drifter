local Menus = {
  menuManager = require('menus.manager'),
  OverlayMenu = require('menus.overlay.menu'),
  PauseMenu = require('menus.pause.menu')
  -- ExitMenu
  -- StartMenu?
}

function Menus:load(stateManager)
  self.stateManager = stateManager
  self.menuManager:load()
  self.OverlayMenu:load(self.menuManager)
  self.PauseMenu:load(self.stateManager, self.menuManager)
end

function Menus:update(dt)
  self.OverlayMenu:update(dt)
  self.PauseMenu:update(dt)
end

function Menus:draw()
  if self.menuManager:isPaused() then
    self.PauseMenu:open()
    self.OverlayMenu:close()
  else
    self.OverlayMenu:open()
    self.PauseMenu:close()
  end

  self.PauseMenu:draw()
  self.OverlayMenu:draw()
end

return Menus

