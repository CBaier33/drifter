local TrashPile = {}
TrashPile.__index = TrashPile

function TrashPile:new()
  local self = setmetatable({}, TrashPile)

  self.width = 100
  self.height = 100

  self.speed = 500
  self.mobile = false

  return self

end

function TrashPile:load(xCoord)
  self.x = xCoord
  self.y = -100

end

function TrashPile:move(dt)
  self.y = self.y + self.speed * dt

end

function TrashPile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return TrashPile
