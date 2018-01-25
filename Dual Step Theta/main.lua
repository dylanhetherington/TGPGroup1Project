function love.load()
  keyDown = false
  songName = ""
  artist = ""
  difficulty = ""
  rating = 0
  noteChart = ""
  bestScore = 0
  previousScore = 0
  audioFile = ""
  audioPreview = ""
  artFile = ""
  Note = {}
  Note.rail = 0
  Note.startTime = 0
  Note.type = 0
  Note.endTime = 0
  notes = {}
  fileLoad()
end
function fileLoad(checkDifficulty)
  songDataStore = {}
  for line in love.filesystem.lines("Songs/TestSong/testData.txt") do
    table.insert(songDataStore, line)
  end
  songName = songDataStore[1]
  artist = songDataStore[2]
  audioFile = songDataStore[3]
  audioPreview = songDataStore[4]
  artFile = songDataStore[5]
  if (checkDifficulty == 0) then
    difficulty = songDataStore[7]
    rating = songDataStore[8]
    noteChart = songDataStore[9]
    bestScore = songDataStore[10]
    previousScore = songDataStore[11]
  end
  if (checkDifficulty == 1) then
    difficulty = songDataStore[13]
    rating = songDataStore[14]
    noteChart = songDataStore[15]
    bestScore = songDataStore[16]
    previousScore = songDataStore[17]
  end
  if (checkDifficulty == 2) then
    difficulty = songDataStore[19]
    rating = songDataStore[20]
    noteChart = songDataStore[21]
    bestScore = songDataStore[22]
    previousScore = songDataStore[23]
  end
end 

function love.update(dt)
  if (love.keyboard.isDown('1') and keyDown == false) then
    fileLoad(0)
    loadNotes(" ")
    print(songName.."\n"..artist.."\n"..audioFile.."\n"..audioPreview.."\n"..artFile.."\n"..difficulty.."\n"..rating.."\n"..noteChart.."\n"..bestScore.."\n"..previousScore)
    for i, note in pairs(notes) do
    print(i.." | "..note.rail.."  "..note.startTime.." ")--..note.type.."  ")
    end
    keyDown = true
  end
  if (love.keyboard.isDown('2')and keyDown == false) then
    fileLoad(1)
    print(songName.."\n"..artist.."\n"..audioFile.."\n"..audioPreview.."\n"..artFile.."\n"..difficulty.."\n"..rating.."\n"..noteChart.."\n"..bestScore.."\n"..previousScore)
    keyDown = true
  end
  if (love.keyboard.isDown('3')and keyDown == false) then
    fileLoad(2)
    print(songName.."\n"..artist.."\n"..audioFile.."\n"..audioPreview.."\n"..artFile.."\n"..difficulty.."\n"..rating.."\n"..noteChart.."\n"..bestScore.."\n"..previousScore)
    keyDown = true
  end
end
function Note.storeData(self, i)
  self.rail = noteDataStore[i+1]:match'(%S+)'
  self.startTime = noteDataStore[i+1]:match'%s+(%S+)'
end
function loadNotes(pathName)
   noteDataStore = {}
  for line in love.filesystem.lines("Songs/TestSong/testChart.txt") do
    table.insert(noteDataStore, line)
  end
  for i=0, 10, 1 do
    note = Note
    Note.storeData(note,i)
    notes[i] = note
    print(notes[i].rail)
    --notes[i].type = noteDataStore[i+1]:match'%s+%s+(%S+)'
    --notes[i].endTime = noteDataStore[i+1]:match'%s+%s+(%S+)'
  end
  print(notes[1].rail)
end  
function love.draw()
  
end 