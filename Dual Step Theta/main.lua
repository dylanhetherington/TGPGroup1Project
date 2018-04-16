require 'Song'
require 'PlayField'
require 'StartMenu'
require 'SongMenu'
require 'Player'
gameState = ""
player = Player.New()

function love.load()
  keyDown = false
  StartMenu.Init()
end

function love.update(dt)
  if (gameState == "Start") then
    StartMenu.Update(dt)
  elseif (gameState == "SongMenu") then
    SongMenu.Update(dt)
  elseif (gameState == "Play") then
    collectgarbage("stop")
    PlayField.Update(dt)
  end
end

function love.draw()
  if (gameState == "Start") then
    StartMenu.Draw()
  elseif (gameState == "SongMenu") then
    collectgarbage("collect")
    SongMenu.Draw()
  elseif(gameState == "Play") then
    love.graphics.setBackgroundColor(0,0,0)
    PlayField.Draw()
    Player.Draw(player)
  end
end 

function LoadPlayField(activeSong)
  Song.LoadNotes(activeSong)
  playField = PlayField.New(activeSong, player)
end

function TableCount(table)
  count = 0
  for i in pairs(table) do
    count = count + 1
  end
  return count
end