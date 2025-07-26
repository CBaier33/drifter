local Car = {}
Car.__index = Car

function Car:new()
  local self = setmetatable({}, Car)

  self.width = 50
  self.height = 80

  self.speed = 650
  self.mobile = true

  return self

end

function Car:load(xCoord)
  self.x = xCoord
  self.y = -80

  -- error handling for failed image loads
  local success, imageOrError = pcall(love.graphics.newImage, 'images/Car.png')
  if success then
    self.image = imageOrError
  else
    print("Failed to load Car image:", imageOrError)
    self.image = nil
  end

end

function Car:move(dt)
  self.y = self.y + self.speed * dt

end

function Car:draw()
  if self.image then
    local scaleX = self.width / self.image:getWidth()
    local scaleY = self.height / self.image:getHeight()
    love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
  else
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
end

return Car
