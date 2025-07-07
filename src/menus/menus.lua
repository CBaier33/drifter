local Menus = {}

local Manager = require('menus.manager')
local OverlayMenu = require('menus.overlay.menu')
local PauseMenu = require('menus.pause.menu')
-- ExitMenu
-- StartMenu?

function Menus:load(stateManager)
  self.stateManager = stateManager

  Manager:load()
  OverlayMenu:load()
  PauseMenu:load(self.stateManager)
end

function Menus:update(dt)
  OverlayMenu:update(dt)
  PauseMenu:update(dt)
end

function Menus:draw()
  if Manager:isPaused() then
    PauseMenu:open()
    OverlayMenu:close()
  else
    OverlayMenu:open()
    PauseMenu:close()
  end

  PauseMenu:draw()
  OverlayMenu:draw()
end

return Menus

