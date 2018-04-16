require 'Note'
Rail = { notes,
        nextNoteIndex,
        totalNotes,
        singleNoteGraphic,
        noteInPlay,
        railNumber,
        }

  
function Rail.New(railNumber)
  rail = setmetatable({}, Rail)
  rail.notes = {}
  rail.nextNoteIndex = 0
  rail.totalNotes = 0
  rail.noteInPlay = 0
  rail.singleNoteGraphic = love.graphics.newImage('Assets/NoteGem1080.png')
  rail.railNumber = railNumber
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
        if (note.yPosition >= 920) then
        --print("note end   "..timer * 1000)
        note.active = false
        self.noteInPlay = self.noteInPlay + 1
        ScoreManager.IncrementNotesMissed(playField.scoreManager)
        PlayField.Accuracy(-500, self.railNumber)
        end
    end
  end
end

function Rail.DrawNote(self, railX)
  for i, note in pairs(self.notes) do
    if (note.active == true) then
      love.graphics.draw(self.singleNoteGraphic,railX, note.yPosition, 0,0.5,0.5) 
    end
  end
end

function Rail.InteractWithNote(self, timer, railX)
  checkNote = self.notes[self.noteInPlay] 
  accuracy = 100001
  if (checkNote ~= nil) then
    --print("note not nill")
    if (checkNote.active == true) then
      accuracy = (timer * 1000) - (checkNote.startTime + 1834) --917 time for note to drop to hit bar
        --print("time   "..timer * 1000)
        --print("noteTime   "..checkNote.startTime)
        --print("accuracy   "..accuracy)
      if (accuracy >= -300 and accuracy < 10) then
        self.notes[self.noteInPlay].active = false
        self.noteInPlay = self.noteInPlay + 1
       
      end
      --if (accuracy < 10 and acuracy >= -500) then
    end
  end
  return accuracy
end