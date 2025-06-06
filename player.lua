local Player = {}

function Player:load()
  self.x = 50
  self.y = 50
  self.width = 50
  self.height = 50
  self.speed = 500

end

function Player:update(dt)
  Player:move(dt)

end

-- player movement methods

-- TODO: add rotation to "drift" player and have it return to center when no item is pressed.
function Player:move(dt)
  if love.keyboard.isDown("a") and self.x < love.graphics.getWidth()/3  then
    self.x = self.x + self.speed * dt
  elseif love.keyboard.isDown("d") and self.x - self.width > -(love.graphics.getWidth() / 3) then
    self.x = self.x - self.speed * dt
  end
end

function Player:draw()
  -- temporary player sprite
  love.graphics.rectangle("fill", (love.graphics.getWidth() / 2) - self.x / 2, love.graphics.getHeight() - 200, self.width, self.height)
end

return Player
