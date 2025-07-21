local Car = {}
Car.__index = Car

function Car:new()
  local self = setmetatable({}, Car)
  return self

end

function Car:load()
  self.width = 50
  self.height = 80

  self.x = math.random(0, 500)
  self.y = -80

  self.speed = 500
  self.mobile = true

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
