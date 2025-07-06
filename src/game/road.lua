local Road = {}

function Road:load()
  self.width = 400
  self.height = 800

  self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
  self.y = love.graphics.getHeight() - self.height

  self.image = love.graphics.newImage('images/Road.png')


end

function Road:update(dt)
  -- add animations
end

function Road:draw()
  local scaleX = self.width / self.image:getWidth()
  local scaleY = self.height / self.image:getHeight()
  love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
end

return Road
