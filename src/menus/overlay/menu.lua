local OverlayMenu = {}

local Buttons = require('menus.overlay.buttons')

function OverlayMenu:load()
  Buttons:load()
  self.active = true
end

function OverlayMenu:update(dt)
  Buttons:update(dt)
end

function OverlayMenu:draw()
  if (self.active) then
    Buttons:draw()
  end
end

function OverlayMenu:open()
  self.active = true
end

function OverlayMenu:close()
  self.active = false
end

return OverlayMenu
