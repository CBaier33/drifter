local Menus = {
  menuManager = require('menus.manager'),
  OverlayMenu = require('menus.overlay.menu'),
  PauseMenu = require('menus.pause.menu'),
  ExitMenu = require('menus.exit.menu')
}

function Menus:load(stateManager)
  self.stateManager = stateManager
  self.menuManager:load()
  self.OverlayMenu:load(self.menuManager)
  self.PauseMenu:load(self.stateManager, self.menuManager)
  self.ExitMenu:load(self.stateManager, self.menuManager)
end

function Menus:update(dt)
  self.OverlayMenu:update(dt)
  self.PauseMenu:update(dt)
  self.ExitMenu:update(dt)
end

function Menus:draw()
  if self.menuManager:isPaused() then
    self.PauseMenu:open()
    self.OverlayMenu:close()
  else
    self.OverlayMenu:open()
    self.PauseMenu:close()
  end

  if not self.stateManager:isGameActive() then
    self.OverlayMenu:close()
    self.ExitMenu:open()
  end

  self.PauseMenu:draw()
  self.OverlayMenu:draw()
  self.ExitMenu:draw()
end

return Menus

