local StateManager = {current = nil}

function StateManager:switch(newState, manager)
  if self.current and self.current.exit then
    self.current:exit()
  end
  self.current = newState
  if self.current.load then
    self.current:load(manager)
  end
end

function StateManager:update(dt)
  if self.current and self.current.update then
    self.current:update(dt)
  end
end

function StateManager:draw()
  if self.current and self.current.draw then
    self.current:draw()
  end
end

return StateManager
