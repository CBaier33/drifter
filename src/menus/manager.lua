local Manager = {}

function Manager:load()
  self.paused = false
end

function Manager:pause()
  print('Manager Pausing')
  self.paused = true
end

function Manager:play()
  print('Manager Playing')
  self.paused = false
end

function Manager:isPaused()
  return self.paused
end

return Manager
