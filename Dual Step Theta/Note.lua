Note = {rail = 0, 
  startTime = 0, 
  noteType = 0, 
  endTime = 0,
  yPosition = 0,
  active = false}

function Note.New()
  note = setmetatable({}, Note)
  note.rail = 0
  note.startTime = 0
  note.noteType = 0
  note.endTime = 0
  note.yPosition = -100
  note.active = false
  return note
end

function Note.StoreData(self, i, song)
  self.rail, self.startTime, self.noteType, self.endTime = noteDataStore[i+1]:match  '(%S+)%s+(%S+)%s+(%S+)%s+(%S+)'
  self.rail = tonumber(self.rail)
  --print(self.startTime)
  self.startTime = tonumber(self.startTime + 1300 + song.delay) --possibly times song delay by 1000 depending on how its stored
  self.noteType = tonumber(self.noteType)
  self.endTime = tonumber(self.endTime)
  if (self.endTime == 0) then
    self.endTime = self.startTime
  end
end