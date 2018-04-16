require 'Note'

Song = {path,
        songName,
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
  song.path = ""
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
  self.path = songDataStore[1]
  self.songName = songDataStore[2]
  self.artist = songDataStore[3]
  self.audioFile = songDataStore[4]
  self.audioPreview = songDataStore[5]
  self.artFile = songDataStore[6]
  self.delay = songDataStore[7]
  if (checkDifficulty == 0) then
    self.difficulty = songDataStore[9]
    self.rating = songDataStore[10]
    self.noteChart = songDataStore[11]
    self.bestScore = songDataStore[12]
    self.previousScore = songDataStore[13]
  end
  if (checkDifficulty == 1) then
    self.difficulty = songDataStore[15]
    self.rating = songDataStore[16]
    self.noteChart = songDataStore[17]
    self.bestScore = songDataStore[18]
    self.previousScore = songDataStore[19]
  end
  if (checkDifficulty == 2) then
    self.difficulty = songDataStore[21]
    self.rating = songDataStore[22]
    self.noteChart = songDataStore[23]
    self.bestScore = songDataStore[24]
    self.previousScore = songDataStore[25]
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