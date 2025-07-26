local Road = {}
local anim8 = require 'libs.anim8'

function Road:load()
  self.width = 400
  self.height = 800

  self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
  self.y = love.graphics.getHeight() - self.height

  self.crash = false

  self.spritesheet = love.graphics.newImage('images/road-sprite-sheet.png')
  self.animation = self.buildAnimation(self)

end

function Road:update(dt)
  -- add animations
  if not self.crash then
    self.animation:update(dt)
  end

end

function Road:draw()
  local scaleX = self.width / 1600
  local scaleY = self.height / 3200
  --love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
  self.animation:draw(self.spritesheet, self.x, self.y, 0 ,scaleX, scaleY)
end

function Road:registerCrash()
  self.crash = true
end

function Road:buildAnimation()

  local g = anim8.newGrid(1600, 3200, self.spritesheet:getWidth(), self.spritesheet:getHeight())

  return anim8.newAnimation(g('1-4', 1), .02)
end


return Road


