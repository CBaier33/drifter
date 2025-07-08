local StartMenu = {
  Buttons = require('menus.start.buttons')
}

function StartMenu:load(stateManager)
  self.stateManager = stateManager
  self.Buttons:load(self.stateManager)
end

function StartMenu:update(dt)
  self.Buttons:update(dt)
end

function StartMenu:draw()
  self.Buttons:draw()
end

return StartMenu
