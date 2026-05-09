local Audio = {
  sources = nil,
  current = nil,
}

function Audio:load()
  self.sources = {
    menu = love.audio.newSource("music/menu_theme.mp3", "stream"),
    game = love.audio.newSource("music/game_theme.mp3", "stream"),
  }
  for _, source in pairs(self.sources) do
    source:setLooping(true)
  end
end

function Audio:play(name)
  if self.current == name then return end
  if self.current then
    self.sources[self.current]:stop()
  end
  self.current = name
  self.sources[name]:play()
end

function Audio:stop()
  if self.current then
    self.sources[self.current]:stop()
    self.current = nil
  end
end

return Audio
