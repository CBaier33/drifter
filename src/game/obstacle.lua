local Obstacle = {}
local TrashPile = {}
local Car = {}
local Truck = {}

Obstacle.__index = Obstacle
Car.__index = Car
TrashPile.__index = TrashPile
Truck.__index = Truck


function Obstacle:new()
  local self = setmetatable({}, Obstacle)
  return self

end

function Obstacle:load()
  self.obstacleType = math.random(3)
  self.obstacle = nil

  if self.obstacleType == 1 then
    self.obstacle = Car:new()

  elseif self.obstacleType == 2 then
    self.obstacle = Truck:new()

  elseif self.obstacleType == 3 then
    self.obstacle = TrashPile:new()

  end

  self.obstacle:load()

end

function Car:new()
  local self = setmetatable({}, Car)
  return self

end

function Car:load()
  self.width = 50
  self.height = 80

  self.x = math.random(0, 500)
  self.y = -50

  self.speed = 500

  -- error handling for failed image loads
  local success, imageOrError = pcall(love.graphics.newImage, 'images/Car.png')
  if success then
    self.image = imageOrError
  else
    print("Failed to load Car image:", imageOrError)
    self.image = nil
  end

end

function Truck:new()
  local self = setmetatable({}, Truck)
  return self

end

function Truck:load()
  self.width = 50
  self.height = 95

  self.x = math.random(0, 500)
  self.y = -50

  self.speed = 500

  local success, imageOrError = pcall(love.graphics.newImage, 'images/Truck.png')
  if success then
    self.image = imageOrError
  else
    print("Failed to load Truck image:", imageOrError)
    self.image = nil
  end

end

function TrashPile:new()
  local self = setmetatable({}, TrashPile)
  return self

end

function TrashPile:load()
  self.width = 100
  self.height = 100

  self.x =  math.random(0, 500)
  self.y = -100

  self.speed = 300

end

function Obstacle:update(dt)
  self.obstacle:move(dt)

end

function Car:move(dt)
  self.y = self.y + self.speed * dt

end

function TrashPile:move(dt)
  self.y = self.y + self.speed * dt

end

function Truck:move(dt)
  self.y = self.y + self.speed * dt

end

function Obstacle:draw()
  self.obstacle:draw()

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

function TrashPile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end


function Truck:draw()
  if self.image then
    local scaleX = self.width / self.image:getWidth()
    local scaleY = self.height / self.image:getHeight()
    love.graphics.draw(self.image, self.x, self.y, 0, scaleX, scaleY)
  else
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
end

return Obstacle
