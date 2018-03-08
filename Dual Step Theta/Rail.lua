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
  if (railNumber == 0) then
    rail.singleNoteGraphic = love.graphics.newImage('Assets/noteleft.png')
  elseif (railNumber == 1) then
    rail.singleNoteGraphic = love.graphics.newImage('Assets/notedown.png')
  elseif (railNumber == 2) then
    rail.singleNoteGraphic = love.graphics.newImage('Assets/noteup.png')
  else
    rail.singleNoteGraphic = love.graphics.newImage('Assets/noteright.png')
  end
  return rail
end

function Rail.AddNote(self, note)
  self.notes[self.totalNotes] = note
  --print(self.notes[self.totalNotes].startTime)
  self.totalNotes = self.totalNotes + 1
end

function Rail.CheckNextNote(self, timer)
  if (self.notes[self.nextNoteIndex] ~= nil) then
    if (self.notes[self.nextNoteIndex].startTime ~= nil ) then
      if (self.notes[self.nextNoteIndex].startTime <= timer ) then
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
        if (note.yPosition >= 900) then
        note.active = false
        self.noteInPlay = self.noteInPlay + 1
        end
    end
  end
end

function Rail.DrawNote(self, railX)
  for i, note in pairs(self.notes) do
    if (note.active == true) then
      love.graphics.draw(self.singleNoteGraphic,railX, note.yPosition, 0, 0.07, 0.07)
    end
  end
end

function Rail.InteractWithNote(self, timer)
  self.notes[self.NoteInPlay] = checkNote
  accuracy = 10000
  if (checkNote.active == true) then
    accuracy = (timer * 1000) - checkNote.startTime
    self.notes[self.NoteInPlay].active = false
    self.NoteInPlay = self.NoteInPlay + 1
  end
  return accuracy
end