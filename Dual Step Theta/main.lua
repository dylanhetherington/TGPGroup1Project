require 'Song'
require 'PlayField'
require 'StartMenu'
require 'SongMenu'

gameState = ""
function love.load()
  keyDown = false
  StartMenu.Init()
end
function love.update(dt)
  if (gameState == "Start") then
    StartMenu.Update(dt)
  elseif (gameState == "SongMenu") then
      print(gameState)
      SongMenu.Update(dt)
  elseif (gameState == "Play") then

  end
end

function love.draw()
    if (gameState == "Start") then
    StartMenu.Draw(dt)
    elseif (gameState == "SongMenu") then
    SongMenu.Draw()
    end
end 

function LoadPlayField(activeSong)
  _playField = PlayField.New(activeSong)
  
end

function TableCount(table)
  count = 0
  for i in pairs(table) do
    count = count + 1
  end
  return count
end