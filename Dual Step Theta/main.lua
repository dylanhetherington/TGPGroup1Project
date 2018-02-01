require "Song"
require 'PlayField'
function love.load()
  keyDown = false
  songs = {}
  songDirectory = {}
  songCount = 3
  FileLoad()
end
function FileLoad()
  local fileCount = 1
  for line in love.filesystem.lines("Songs/Directory.txt") do
    table.insert(songDirectory, line)
    for i = 0, TableCount(songDirectory) -1, 3 do
      songDataStore = {}
      for line in love.filesystem.lines("Songs/"..songDirectory[fileCount]) do
        table.insert(songDataStore, line)
      end
      songEasy = Song.New()
      songMid = Song.New()
      songHard = Song.New()
      Song.StoreData(songEasy, 0)
      Song.StoreData(songMid, 1)
      Song.StoreData(songHard, 2)
      songs[i] = songEasy
      songs[i+1] = songMid
      songs[i+2] = songHard
      fileCount = fileCount + 1
    end
  end
end 
function love.update(dt)
  if (love.keyboard.isDown('1') and keyDown == false) then
    local activeSong = songs[0]
    Song.LoadNotes(activeSong)
    keyDown = true
    playField = PlayField.New(activeSong)
  end
  if (love.keyboard.isDown('2')and keyDown == false) then
    local activeSong = songs[1]
    Song.LoadNotes(activeSong)
    print(activeSong.songName.."\n"..activeSong.artist.."\n"..activeSong.audioFile.."\n"..  activeSong.audioPreview.."\n"..activeSong.artFile.."\n"..activeSong.difficulty.."\n"..activeSong.rating.."\n"..activeSong.noteChart.."\n"..activeSong.bestScore.."\n"..activeSong.previousScore)
    for i, note in pairs(activeSong.notes) do
    print(i.." | "..note.rail.."  "..note.startTime.."  "..note.noteType.."  "..note.endTime)
    end
    keyDown = true
  end
  if (love.keyboard.isDown('3')and keyDown == false) then
    local activeSong = songs[2]
    Song.LoadNotes(activeSong)
    print(activeSong.songName.."\n"..activeSong.artist.."\n"..activeSong.audioFile.."\n"..  activeSong.audioPreview.."\n"..activeSong.artFile.."\n"..activeSong.difficulty.."\n"..activeSong.rating.."\n"..activeSong.noteChart.."\n"..activeSong.bestScore.."\n"..activeSong.previousScore)
    for i, note in pairs(activeSong.notes) do
    print(i.." | "..note.rail.."  "..note.startTime.."  "..note.noteType.."  "..note.endTime)
    end
    keyDown = true
  end
  if (keyDown == true) then
    playField.Update(dt)
  end
end
function love.draw()
  
end 
function TableCount(table)
  count = 0
  for i in pairs(table) do
    count = count + 1
  end
  return count
end