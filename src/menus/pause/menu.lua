local PauseMenu = {}
local Buttons = require('menus.pause.buttons')
--local Game = require('game.game')
-- add functionality in game to stop all movement
-- while also saving state.

function PauseMenu:load()
  Buttons:load()
  self.active = false
end

function PauseMenu:update(dt)
  self.screen:update(dt)
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
  self.screen = false
end

return PauseMenu
