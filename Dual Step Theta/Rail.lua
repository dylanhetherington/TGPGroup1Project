require 'Note'
Rail = { notes,
        nextNoteIndex,
        totalNotes,
        singleNoteGraphic,
        noteInPlay,
        }
  
function Rail.New(railNumber)
  rail = setmetatable({}, Rail)
  rail.notes = {}
  rail.nextNoteIndex = 0
  rail.totalNotes = 0
  rail.noteInPlay = 0
  rail.singleNoteGraphic = love.graphics.newImage('Assets/NoteGem1080.png')
  return rail
end

function Rail.AddNote(self, note)
  self.notes[self.totalNotes] = note
  --print(self.notes[self.totalNotes].startTime)
  self.totalNotes = self.totalNotes + 1
end

function Rail.CheckNextNote(self, timer)
  if (self.notes[self.nextNoteIndex] ~= nil) then
   -- print("note not nill")
    if (self.notes[self.nextNoteIndex].startTime ~= nil ) then
      --print("startTime not nill")
      if (self.notes[self.nextNoteIndex].startTime <= timer ) then
--print("note start   "..timer)
        self.notes[self.nextNoteIndex].active = true
        self.nextNoteIndex = self.nextNoteIndex + 1
        return true
      end
    else
      self.nextNoteIndex = self.nextNoteIndex + 1
    end
  end
  return false
end

function Rail.Update(self, dt, timer)
  Rail.CheckNextNote(self, timer *1000)
  for i, note in pairs(self.notes) do
    if (note.active == true) then
        note.yPosition = note.yPosition + dt * 1000
        if (note.yPosition >= 1080) then
          --print("note end   "..timer * 1000)
        note.active = false
        self.noteInPlay = self.noteInPlay + 1
        end
    end
  end
end

function Rail.DrawNote(self, railX)
  for i, note in pairs(self.notes) do
    if (note.active == true) then
      love.graphics.draw(self.singleNoteGraphic,railX, note.yPosition, 0)
    end
  end
end

function Rail.InteractWithNote(self, timer)
  checkNote = self.notes[self.noteInPlay] 
  accuracy = 100001
  if (checkNote ~= nil) then
    --print("note not nill")
    if (checkNote.active == true) then
      accuracy = ((timer * 1000) - checkNote.startTime) - 1066
      print("time   "..timer * 1000)
      print("noteTime   "..checkNote.startTime)
      print("accuracy   "..accuracy)
      if (accuracy <= 1000) then
        self.notes[self.noteInPlay].active = false
        self.noteInPlay = self.noteInPlay + 1
      end
    end
  end
  return accuracy
end