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
    SongMenu.Update(dt)
  elseif (gameState == "Play") then
    PlayField.Update(dt)
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
        print(_playField.song.songName.."\n".._playField.song.artist.."\n".._playField.song.audioFile.."\n".._playField.song.audioPreview.."\n".._playField.song.artFile.."\n".._playField.song.difficulty.."\n".._playField.song.rating.."\n".._playField.song.noteChart.."\n".._playField.song.bestScore.."\n".._playField.song.previousScore)
end

function TableCount(table)
  count = 0
  for i in pairs(table) do
    count = count + 1
  end
  return count
end