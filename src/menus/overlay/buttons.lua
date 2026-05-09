local Buttons = {}
Buttons.__index = Buttons

Buttons.BUTTON_HEIGHT = 48
Buttons.BUTTON_WIDTH = 48
Buttons.BUTTON_MARGIN = 16

local function newButton(text, image_path, fn)
  print("Loading image:", image_path)
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
    menuManager = nil,
  }, Buttons)
end

function Buttons:load(menuManager)
  self.menuManager = menuManager
  self.font = love.graphics.newFont(16)
  self.buttons = {}
  table.insert(self.buttons, newButton(
    "Pause",
    "menus/images/pause_button.png",
    function()
      print("Pause Game..")
      self.menuManager:pause()
    end)
  )
end

function Buttons:update(dt)
end

function Buttons:draw()
  local ww = love.graphics.getWidth()
  local total_width = (self.BUTTON_WIDTH + self.BUTTON_MARGIN) * #self.buttons
  local button_location = 0
  for i, button in ipairs(self.buttons) do
    button.last = button.now
    local bx = ww - total_width + button_location
    local by = self.BUTTON_MARGIN
    local mx, my = love.mouse.getPosition()
    local selected = mx > bx and mx < bx + self.BUTTON_WIDTH and
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
    -- Draw image at uniform scale to fit within button bounds
    local img = button.image
    local scale = math.min(
      self.BUTTON_WIDTH / img:getWidth(),
      self.BUTTON_HEIGHT / img:getHeight()
    )
    local drawW = img:getWidth() * scale
    local drawH = img:getHeight() * scale
    local offsetX = (self.BUTTON_WIDTH - drawW) * 0.5
    local offsetY = (self.BUTTON_HEIGHT - drawH) * 0.5
    love.graphics.draw(img, bx + offsetX, by + offsetY, 0, scale, scale)
    button_location = button_location + (self.BUTTON_WIDTH + self.BUTTON_MARGIN)
    love.graphics.setColor(1, 1, 1, 1)
  end
end

return Buttons
