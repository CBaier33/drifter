local Buttons = {
  BUTTON_HEIGHT = 48,
  BUTTON_WIDTH = 48,
  BUTTON_MARGIN = 16,
  buttons = nil,
  font = nil
}

local Manager = require('menus.manager')

function Buttons:load()
  self.font = love.graphics.newFont(16)
  self.buttons = {}

  table.insert(self.buttons, newButton(
    "Pause",
    function()
      print("Pause Game..")
      Manager:pause()
    end)
  )

end

function Buttons:update(dt)
  -- Not used yet
end

function Buttons:draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local total_width = (self.BUTTON_WIDTH + self.BUTTON_MARGIN) * #self.buttons
  local button_location = 0

  for i, button in ipairs(self.buttons) do
    button.last = button.now

    -- Position buttons from right to left at the top of the screen
    local bx = ww - total_width + button_location
    local by = self.BUTTON_MARGIN

    local color = {0.4, 0.4, 0.5, 1.0}

    local mx, my = love.mouse.getPosition()
    local selected = mx > bx and mx < bx + self.BUTTON_WIDTH and 
                     my > by and my < by + self.BUTTON_HEIGHT

    if selected then
      color = {0.8, 0.8, 0.9, 1.0}
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and selected then 
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, self.BUTTON_WIDTH, self.BUTTON_HEIGHT)

    love.graphics.setColor(0, 0, 0, 1)

    local textW = self.font:getWidth(button.text)
    local textH = self.font:getHeight(button.text)

    love.graphics.print(
      button.text,
      self.font,
      bx + (self.BUTTON_WIDTH - textW) * 0.5,
      by + (self.BUTTON_HEIGHT - textH) * 0.5
    )

    button_location = button_location + (self.BUTTON_WIDTH + self.BUTTON_MARGIN)
    love.graphics.setColor(1, 1, 1, 1) -- reset global draw color
  end
end

function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
end

return Buttons

