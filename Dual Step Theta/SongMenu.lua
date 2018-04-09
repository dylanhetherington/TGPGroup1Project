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
  baseSong = {}
  FileLoad()
  songArt = {}
  canJump = true
  songSelect = love.graphics.newImage('Assets/wipsongselect.png')
  for i = 1,7 do
    baseSong[i] = i
  end
  for i = 1,7 do
    songMenu.songDisplay[i] = songMenu.songList[baseSong[i]]
  end
  
  for i = 1, TableCount(songMenu.songDisplay) do
    songArt[i] = love.graphics.newImage('Assets/'..songMenu.songDisplay[i].artFile)
  end
  
  font = love.graphics.newFont(38)
  love.graphics.setFont(font)
  
  return songMenu
end

function SongMenu.SongSearch()
  --check player keyboard input against songMenu.songList.songName
  --triggerd when player hits enter
  --this is extra
end

function SongMenu.Draw()
  love.graphics.draw(songSelect,1075,375)
  for i = 1,7 do
    love.graphics.draw(songArt[i],1100,150*i-200)
  end
  if TableCount(songMenu.songDisplay) > 0 then
    love.graphics.print('Name: '..songMenu.songDisplay[4].songName,150,250)
    love.graphics.print('Difficulty: '..songMenu.songDisplay[4].difficulty,150,350)
    love.graphics.print('Rating: '..songMenu.songDisplay[4].rating,150,450)
    love.graphics.print('Best Score: '..songMenu.songDisplay[4].bestScore,150,550)
    love.graphics.print('Previous Score: '..songMenu.songDisplay[4].previousScore,150,650)
  end
  
  love.graphics.print('Current Combo: '..'like 5',75,75)
  
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
    songMenu.songDisplay[i] = songMenu.songList[baseSong[i]]
  end
  
  for i = 1, 7 do
    songArt[i] = love.graphics.newImage('Assets/'..songMenu.songDisplay[i].artFile)
  end
  
  if (canJump and love.keyboard.isDown('down')) then
    canJump = false
    for i = 1,7 do
      baseSong[i] = baseSong[i] + 1
    end
  elseif (canJump and love.keyboard.isDown('up')) then
    canJump = false
        for i = 1,7 do
      baseSong[i] = baseSong[i] - 1
    end
  end
  
  if (not love.keyboard.isDown('down') and not love.keyboard.isDown('up')) then
    canJump = true
  end
  
  for i = 1,7 do
    if (baseSong[i] > TableCount(songMenu.songList)) then
      baseSong[i] = 1
    end
    if (baseSong[i] < 1) then
      baseSong[i] = TableCount(songMenu.songList)
    end
  end
  
  if (love.keyboard.isDown('9')) then --remove this is only here to allow for debugging and getting to the playfield
    SongMenu.SelectSong()
  end
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
  for i = 1, TableCount(songDirectory)*3,3 do
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
    songMenu.songList[i] = songEasy
    songMenu.songList[i+1] = songMid
    songMenu.songList[i+2] = songHard
    fileCount = fileCount + 1
  end
end 

function love.wheelmoved(x,y)
  if(y<0)then
    for i = 1,7 do
      baseSong[i] = baseSong[i] + 1
    end
  elseif(y>0)then
    for i = 1,7 do
      baseSong[i] = baseSong[i] - 1
    end
  end
  
  for i = 1,7 do
    if (baseSong[i] > TableCount(songMenu.songList)) then
      baseSong[i] = 1
    end
    if (baseSong[i] < 1) then
      baseSong[i] = TableCount(songMenu.songList)
    end
  end
end