require 'Note'
Rail = { notes,
        nextNoteIndex,
        totalNotes
      }
  
function Rail.New()
  rail = setmetatable({}, Rail)
  rail.notes = {}
  rail.nextNoteIndex = 0
  rail.totalNotes = 0
  return rail
end

function Rail.AddNote(self, note)
  self.notes[self.totalNotes] = note
  print(self.notes[self.totalNotes].startTime)
  self.totalNotes = self.totalNotes + 1
end

function Rail.CheckNextNote(self, timer)
  if (self.notes[self.nextNoteIndex].startTime <= timer) then
    self.notes[self.nextNoteIndex].active = true
    self.nextNoteIndex = self.nextNoteIndex + 1
    return true
  end
  return false
end

function Rail.DrawNote(self, dt, railX)
  for i, note in pairs(notes) do
    if (note.active == true) then
      love.graphics.rectangle(fill, railX, note.yPosition, 100, 20)
      note.yPosition = note.yPosition + dt
    end
  end
end
