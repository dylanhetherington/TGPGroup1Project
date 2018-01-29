Note = {rail = 0, 
  startTime = 0, 
  noteType = 0, 
  endTime = 0}

function Note.New()
  note = setmetatable({}, Note)
  note.rail = 0
  note.startTime = 0
  note.noteType = 0
  note.endTime = 0
  return note
end
function Note.StoreData(self, i)
  self.rail, self.startTime, self.noteType, self.endTime = noteDataStore[i+1]:match  '(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+'
  self.rail = tonumber(self.rail)
  self.startTime = tonumber(self.startTime)
  self.noteType = tonumber(self.noteType)
  self.endTime = tonumber(self.endTime)
  if (self.endTime == 0) then
    self.endTime = self.startTime
  end
end