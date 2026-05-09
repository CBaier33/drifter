local Buttons = {}
Buttons.__index = Buttons
Buttons.BUTTON_HEIGHT = 64

local function newButton(text, image_path, fn)
  local ok, result = pcall(function()
    return love.graphics.newImage(image_path)
  end)
  if not ok then
    error("FAILED to load image: " .. tostring(image_path) .. "\nReason: " .. tostring(result))
  end
  return {
    text = text,
    fn = fn,
    image = result,
    now = false,
    last = false
  }
end

function Buttons.new()
  return setmetatable({
    buttons = {},
    font = nil,
    stateManager = nil,
  }, Buttons)
end

function Buttons:load(stateManager)
  self.stateManager = stateManager
  self.buttons = {}
  self.font = love.graphics.newFont(32)
  table.insert(self.buttons, newButton(
    "Start",
    "menus/images/start_button.png",
    function()
      self.stateManager:switch("game", self.stateManager)
    end)
  )
  table.insert(self.buttons, newButton(
    "Options",
    "menus/images/pause_button.png",
    function()
      print("Option Menu..")
    end)
  )
  table.insert(self.buttons, newButton(
    "Credits",
    "menus/images/home_button.png",
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
  local button_width = ww * (1/3)
  local margin = 16
  local total_height = (self.BUTTON_HEIGHT + margin) * #self.buttons
  local button_location = 0
  for i, button in ipairs(self.buttons) do
    button.last = button.now
    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + button_location
    local mx, my = love.mouse.getPosition()
    local selected = mx > bx and mx < bx + button_width and
                     my > by and my < by + self.BUTTON_HEIGHT
    -- Hover brightness
    if selected then
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.setColor(0.8, 0.8, 0.8, 1)
    end
    button.now = love.mouse.isDown(1)
    if button.now and not button.last and selected then
      button.fn()
    end
    -- Draw image at uniform scale centered within button bounds
    local img = button.image
    local scale = math.min(
      button_width / img:getWidth(),
      self.BUTTON_HEIGHT / img:getHeight()
    )
    local drawW = img:getWidth() * scale
    local drawH = img:getHeight() * scale
    local offsetX = (button_width - drawW) * 0.5
    local offsetY = (self.BUTTON_HEIGHT - drawH) * 0.5
    love.graphics.draw(img, bx + offsetX, by + offsetY, 0, scale, scale)
    button_location = button_location + (self.BUTTON_HEIGHT + margin)
    love.graphics.setColor(1, 1, 1, 1)
  end
end

return Buttons
