local TrashPile = {}
TrashPile.__index = TrashPile

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

function TrashPile:move(dt)
  self.y = self.y + self.speed * dt

end

function TrashPile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return TrashPile
