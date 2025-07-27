local Road = {}
local anim8 = require 'libs.anim8'

function Road:load()
  self.width = 400
  self.height = 1080

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
  local scaleX = self.width / (self.spritesheet:getWidth() / 16)
  local scaleY = self.height / self.spritesheet:getHeight()
  --love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
  self.animation:draw(self.spritesheet, self.x, self.y, 0 ,scaleX, scaleY)
end

function Road:registerCrash()
  self.crash = true
end

function Road:buildAnimation()

  local g = anim8.newGrid(self.width, self.height, self.spritesheet:getWidth(), self.spritesheet:getHeight())

  return anim8.newAnimation(g('1-16', 1), .01)
end


return Road


