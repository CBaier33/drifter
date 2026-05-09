local ButtonsClass = require('menus.start.buttons')

local StartMenu = {
  background = nil,
  logo = nil,
  Buttons = nil,
}

function StartMenu:load(stateManager)
  self.stateManager = stateManager
  self.background = love.graphics.newImage("menus/images/background.png")
  self.logo = love.graphics.newImage("menus/images/logo.png")
  self.Buttons = ButtonsClass.new()
  self.Buttons:load(self.stateManager)

end

function StartMenu:update(dt)
  self.Buttons:update(dt)
end

function StartMenu:draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  -- Draw background stretched to fill screen
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(
    self.background,
    0, 0, 0,
    ww / self.background:getWidth(),
    wh / self.background:getHeight()
  )

  -- Draw logo centered near top
  local logoScale = 0.5
  local logoW = self.logo:getWidth() * logoScale
  love.graphics.draw(
    self.logo,
    (ww - logoW) * 0.5,
    40,
    0,
    logoScale, logoScale
  )

  self.Buttons:draw()
end

return StartMenu
