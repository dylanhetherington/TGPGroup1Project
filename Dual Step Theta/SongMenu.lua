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
  songMenu.selectedPosition = 0;
  FileLoad()
  return songMenu
end
function SongMenu.SongSearch()
  --check player keyboard input against songMenu.songList.songName
  --triggerd when player hits enter
  --this is extra
end

function SongMenu.Draw()
  --Draw graphics of the 7 songs stored in the songDisplay array
  --draw box with song graphic (songMenu.songDisplay[number].artFile)
  --give each song border
  --make selected Song (song 3 in the 7 song display array) slightly bigger
  --draw name and other varaibles for the song that are relevant
end

function SongMenu.Update(dt)
  --use self. when wanting to access class varaibles
  --check player input to scroll through the list (update selected position)
  --songs scroll in sets of 3 cause 3 slots used for difficulty settings
  --callScrollThroughMenu
  --play shortAudio for selectedSong
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
  local songCount = 0
  for line in love.filesystem.lines("Songs/Directory.txt") do
    table.insert(songDirectory, line)
  end
    for i = 0, TableCount(songDirectory) -1, 1 do
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
      songMenu.songList[songCount] = songEasy
      songMenu.songList[songCount+1] = songMid
      songMenu.songList[songCount+2] = songHard
      songCount = songCount + 3
      fileCount = fileCount + 1
    end
end 