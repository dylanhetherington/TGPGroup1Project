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
end