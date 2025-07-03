local Buttons = {}

local BUTTON_HEIGHT = 64
local buttons = {}

local font = nil

function Buttons:load(startGameCallback)

  font = love.graphics.newFont(32)

  table.insert(buttons, newButton(
    "Start",
    function()
      print("Starting Game..")
      startGameCallback()
    end)
  )

  table.insert(buttons, newButton(
      "Options",
       function()
         print("Option Menu..")
       end)
  )

  table.insert(buttons, newButton(
      "Credits",
       function()
         print("Roll Credits..")
       end)
  )

end

function Buttons:update(dt)

end

function Buttons:draw()

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  -- TODO -> orient buttons in bottom-right quadrant of screen
  local button_width = ww * (1/3)
  local margin = 16
  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local button_location = 0

  for i, button in ipairs(buttons) do
    button.last = button.now

    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + button_location

    local color = {0.4, 0.4, 0.5, 1.0}

    local mx, my = love.mouse.getPosition()

    local selected = mx > bx and mx < bx + button_width and 
      my > by and my < by + BUTTON_HEIGHT

    if selected then
      color = {0.8, 0.8, 0.9, 1.0}
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and selected then 
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle(
      "fill",
      bx,
      by,
      button_width,
      BUTTON_HEIGHT
    )

    love.graphics.setColor(0, 0, 0, 1)

    local textW = font:getWidth(button.text)
    local textH = font:getHeight(button.text)

    love.graphics.print(
      button.text,
      font,
      (ww * 0.5) - textW * 0.5,
      by + textH * 0.5
    )

    button_location = button_location + (BUTTON_HEIGHT + margin)
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
