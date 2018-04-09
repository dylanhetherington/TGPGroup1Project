require 'Note'

Song = {songName,
        artist,
        difficulty,
        rating,
        delay,
        noteChart,
        bestScore,
        previousScore,
        audioFile,
        audioPreview,
        artFile,
        notes,
        totalNotes}

function Song.New()
  song = setmetatable({}, Song)
  song.songName = ""
  song.artist = ""
  song.difficulty = ""
  song.rating = 0
  song.delay = 0
  song.noteChart = ""
  song.bestScore = 0
  song.previousScore = 0
  song.audioFile = ""
  song.audioPreview = ""
  song.artFile = ""
  song.notes = {}
  song.totalNotes = 0
  return song
end

function Song.StoreData(self, checkDifficulty)
  self.songName = songDataStore[1]
  self.artist = songDataStore[2]
  self.audioFile = songDataStore[3]
  self.audioPreview = songDataStore[4]
  self.artFile = songDataStore[5]
  self.delay = songDataStore[6]
  if (checkDifficulty == 0) then
    self.difficulty = songDataStore[8]
    self.rating = songDataStore[9]
    self.noteChart = songDataStore[10]
    self.bestScore = songDataStore[11]
    self.previousScore = songDataStore[12]
  end
  if (checkDifficulty == 1) then
    self.difficulty = songDataStore[14]
    self.rating = songDataStore[15]
    self.noteChart = songDataStore[16]
    self.bestScore = songDataStore[17]
    self.previousScore = songDataStore[18]
  end
  if (checkDifficulty == 2) then
    self.difficulty = songDataStore[20]
    self.rating = songDataStore[21]
    self.noteChart = songDataStore[22]
    self.bestScore = songDataStore[23]
    self.previousScore = songDataStore[24]
  end
end

function Song.LoadNotes(self)
  noteDataStore = {}
  for line in love.filesystem.lines("Songs/"..self.noteChart) do
    table.insert(noteDataStore, line)
  end
  for i = 0, TableCount(noteDataStore) -1, 1 do
    note = Note.New()
    Note.StoreData(note,i, self)
    self.notes[i] = note
    self.totalNotes = self.totalNotes + 1
  end
end

function Song.LoadAudio()
  
end