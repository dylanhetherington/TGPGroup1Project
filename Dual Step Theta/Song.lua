require 'Note'

Song = {songName,
        artist,
        difficulty,
        rating,
        noteChart,
        bestScore,
        previousScore,
        audioFile,
        audioPreview,
        artFile,
        notes }
function Song.New()
  song = setmetatable({}, Song)
  song.songName = ""
  song.artist = ""
  song.difficulty = ""
  song.rating = 0
  song.noteChart = ""
  song.bestScore = 0
  song.previousScore = 0
  song.audioFile = ""
  song.audioPreview = ""
  song.artFile = ""
  song.notes = {}
  return song
end

function Song.StoreData(self, checkDifficulty)
  self.songName = songDataStore[1]
  self.artist = songDataStore[2]
  self.audioFile = songDataStore[3]
  self.audioPreview = songDataStore[4]
  self.artFile = songDataStore[5]
  if (checkDifficulty == 0) then
    self.difficulty = songDataStore[7]
    self.rating = songDataStore[8]
    self.noteChart = songDataStore[9]
    self.bestScore = songDataStore[10]
    self.previousScore = songDataStore[11]
  end
  if (checkDifficulty == 1) then
    self.difficulty = songDataStore[13]
    self.rating = songDataStore[14]
    self.noteChart = songDataStore[15]
    self.bestScore = songDataStore[16]
    self.previousScore = songDataStore[17]
  end
  if (checkDifficulty == 2) then
    self.difficulty = songDataStore[19]
    self.rating = songDataStore[20]
    self.noteChart = songDataStore[21]
    self.bestScore = songDataStore[22]
    self.previousScore = songDataStore[23]
  end
end
function Song.LoadNotes(self)
  noteDataStore = {}
  for line in love.filesystem.lines("Songs/TestSong/"..self.noteChart) do
    table.insert(noteDataStore, line)
  end
  for i = 0, TableCount(noteDataStore) -1, 1 do
    note = Note.New()
    Note.StoreData(note,i)
    self.notes[i] = note
  end
end
function Song.LoadAudio()
  
end