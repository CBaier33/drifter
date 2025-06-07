local BarrierLeft = {}
local BarrierRight = {}
local Barrier = {}

Barrier.__index = Barrier
BarrierLeft.__index = BarrierLeft
BarrierRight.__index = BarrierRight


function Barrier:new()
  local self = setmetatable({}, Barrier)
  return self

end

function Barrier:load()
  self.left = BarrierLeft:new()
  self.right = BarrierRight:new()

  self.left:load()
  self.right:load(self.left)

end

function BarrierLeft:new()
  local self = setmetatable({}, BarrierLeft)
  return self

end

function BarrierLeft:load()
  self.width = math.random(50, 250)
  self.height = 50

  self.x = 0
  self.y = -50

  self.speed = 500

end

function BarrierRight:new()
  local self = setmetatable({}, BarrierRight)
  return self

end

function BarrierRight:load(left)
  self.width = (love.graphics.getWidth() - left.width) - 100
  self.height = 50

  self.x = left.width + 100
  self.y = -50

  self.speed = 500

end

function Barrier:update(dt)
  self.left:move(dt)
  self.right:move(dt)

end

function BarrierLeft:move(dt)
  self.y = self.y + self.speed * dt

end

function BarrierRight:move(dt)
  self.y = self.y + self.speed * dt

end

function Barrier:draw()
  self.left:draw()
  self.right:draw()

end

function BarrierLeft:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end

function BarrierRight:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end

return Barrier
