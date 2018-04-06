require 'Song'

SongMenu = {songList,
            songDisplay,
            selectedPosition
          }

function SongMenu.Init()
  songDirectory = {}
  songMenu = setmetatable({}, SongMenu) 
  songMenu.songList = {}
  songMenu.songDisplay = {} --list of 7 songs to be drawn
  songMenu.selectedPosition = 0
  baseSong = 0
  FileLoad()
  songArt = {}
  jump = 0
  canJump = true
  for i = 1, TableCount(songMenu.songList) do
    songArt[i] = love.graphics.newImage('Assets/'..songMenu.songList[i].artFile)
    print(i)
  end
  songSelect = love.graphics.newImage('Assets/wipsongselect.png')
  return songMenu
end

function SongMenu.SongSearch()
  --check player keyboard input against songMenu.songList.songName
  --triggerd when player hits enter
  --this is extra
end

function SongMenu.Draw()
  love.graphics.draw(songSelect,1075,375)
  --for i = 1,7 do
  --  love.graphics.draw(songArt[i],1100,150*i-1250-jump*150)
  --end
  for i = 1+baseSong,7+baseSong do
    love.graphics.draw(songArt[i],1100,150*i-200-jump*150)
  end
  --for i = 1,7 do
  --  love.graphics.draw(songArt[i],1100,150*i+850-jump*150)
  --end
  --love.graphics.print(songMenu.songDisplay[4+jump].songName,900,450)
  
  --Draw graphics of the 7 songs stored in the songDisplay array
  --draw box with song graphic (songMenu.songDisplay[number].artFile)
  --give each song border
  --make selected Song (song 3 in the 7 song display array) slightly bigger
  --draw name and other varaibles for the song that are relevant
end

function SongMenu.Update(dt)

        --print(songMenu.songList[1].songName.."\n"..songMenu.songList[1].artist.."\n"..songMenu.songList[1].audioFile.."\n"..songMenu.songList[1].audioPreview.."\n"..songMenu.songList[1].artFile.."\n"..songMenu.songList[1].difficulty.."\n"..songMenu.songList[1].rating.."\n"..songMenu.songList[1].noteChart.."\n"..songMenu.songList[1].bestScore.."\n"..songMenu.songList[1].previousScore) --lines for debugging, remove these
  --use self. when wanting to access class varaibles
  --check player input to scroll through the list (update selected position)
  --songs scroll in sets of 3 cause 3 slots used for difficulty settings
  --callScrollThroughMenu
  --play shortAudio for selectedSong
  for i = 1,7 do
    songMenu.songDisplay[i] = songMenu.songList[i+baseSong]
  end
  
  if (canJump and love.keyboard.isDown('down')) then
    jump = jump + 1
    canJump = false
    baseSong = baseSong + 1
  elseif (canJump and love.keyboard.isDown('up')) then
    jump = jump - 1
    canJump = false
    baseSong = baseSong - 1
  end
  
  if (not love.keyboard.isDown('down') and not love.keyboard.isDown('up')) then
    canJump = true
  end
  
  if (jump > 3) then
    jump = -3
  end
    
  if (jump < -3) then
    jump = 3
  end
  
  if (love.keyboard.isDown('9')) then --remove this is only here to allow for debugging and getting to the playfield
    SongMenu.SelectSong()
  end
end

function SongMenu.ScrollThroughMenu()
  --update songs loaded into array
end

function SongMenu.SelectSong()
  --create a playfield, send in song that is in position = to selectedPosition
  gameState = "Play"
  LoadPlayField(songMenu.songList[songMenu.selectedPosition])
end

function FileLoad()
  local fileCount = 1
  for line in love.filesystem.lines("Songs/Directory.txt") do
    table.insert(songDirectory, line)
  end
  for i = 1, TableCount(songDirectory),1  do
    songDataStore = {}
    for line in love.filesystem.lines("Songs/"..songDirectory[fileCount]) do
      table.insert(songDataStore, line)
    end
    songEasy = Song.New()
    --songMid = Song.New()
    --songHard = Song.New()
    Song.StoreData(songEasy, 0)
    --Song.StoreData(songMid, 1)
    --Song.StoreData(songHard, 2)
    songMenu.songList[i] = songEasy
    --songMenu.songList[i+1] = songMid
    --songMenu.songList[i+2] = songHard
    fileCount = fileCount + 1
  end
end 