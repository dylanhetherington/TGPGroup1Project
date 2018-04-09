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
    songArt[i] = love.graphics.newImage('Songs/'..songMenu.songDisplay[i].artFile)
  end
  
  font = love.graphics.newFont(38)
  love.graphics.setFont(font)
  
  return songMenu
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
end

function SongMenu.Update(dt)
  for i = 1,7 do
    songMenu.songDisplay[i] = songMenu.songList[baseSong[i]]
  end
  
  for i = 1, 7 do
    songArt[i] = love.graphics.newImage('Songs/'..songMenu.songDisplay[i].artFile)
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
  local songCount = 0
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