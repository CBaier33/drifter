local Truck = {}
Truck.__index = Truck

function Truck:new()
  local self = setmetatable({}, Truck)

  self.width = 50
  self.height = 95

  self.speed = 500
  self.mobile = true

  self.crash = false

  return self

end

function Truck:load(xCoord)
  self.x = xCoord
  self.y = -95

  local success, imageOrError = pcall(love.graphics.newImage, 'game/images/Truck.png')
  if success then
    self.image = imageOrError
  else
    print("Failed to load Truck image:", imageOrError)
    self.image = nil
  end

end

function Truck:update(dt)
  if self.mobile then
    self:move(dt)
  end
end

function Truck:move(dt)
  self.y = self.y + self.speed * dt

end

function Truck:setCrash()
  self.speed = self.speed * (-1)
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

function Truck:randomSpawnX()
  local spawn = math.random(1, 5)
  local locMap = {}
  locMap[1] = (love.graphics.getWidth() * 0.5 - 200) + 20
  locMap[2] = (love.graphics.getWidth() * 0.5 - 200) + 100
  locMap[3] = (love.graphics.getWidth() * 0.5 - 200) + 173
  locMap[4] = (love.graphics.getWidth() * 0.5 - 200) + 252
  locMap[5] = (love.graphics.getWidth() * 0.5 - 200) + 323

  return locMap[spawn]

end

return Truck
