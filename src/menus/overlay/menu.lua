local OverlayMenu = {
  Buttons = require('menus.overlay.buttons')
}

function OverlayMenu:load(menuManager)
  self.menuManager = menuManager
  self.Buttons:load(self.menuManager)
  self.active = true
end

function OverlayMenu:update(dt)
  self.Buttons:update(dt)
end

function OverlayMenu:draw()
  if (self.active) then
    self.Buttons:draw()
  end
end

function OverlayMenu:open()
  self.active = true
end

function OverlayMenu:close()
  self.active = false
end

return OverlayMenu
