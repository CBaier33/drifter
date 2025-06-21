local TrashPile = {}
local Car = {}
local Obstacle = {}

Obstacle.__index = Obstacle
Car.__index = Car
TrashPile.__index = TrashPile


function Obstacle:new()
  local self = setmetatable({}, Obstacle)
  return self

end

function Obstacle:load()
  self.obstacleType = math.random(2)
  self.obstacle = nil

  if self.obstacleType == 1 then
    self.obstacle = Car:new()

  elseif self.obstacleType == 2 then
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
  self.height = 60

  self.x = math.random(0, 500)
  self.y = -50

  self.speed = 500

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

function Obstacle:draw()
  self.obstacle:draw()

end

function Car:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end

function TrashPile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end

return Obstacle
