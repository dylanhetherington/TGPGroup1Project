Scoremanager = {totalNotes,
                notesHit,
                combo,
                score,
                health,
                percentageNotesHit,
                notesMissed,}

function ScoreManager(totalNotesSong)
  scoreManager = setmetatable({}, ScoreManager)
  scoreManager.totalNotes = totalNotesSong
  scoreManager.notesHit = 0
  scoreManager.combo = 0
  scoreManager.score = 0
  scoreManager.health = 0
  scoreManager.percentageNotesHit = 0
  scoreManager.notesMissed = 0
  return scoreManager
end
  
function IncrementNotesHit(self)
  self.notesHit = self.notesHit + 1
end

function GetNotesHit(self)
  return self.notesHit
end

function IncrementCombo(self)
  self.combo = self.combo + 1
end

function ResetCombo(self)
  self.combo = 0
end

function GetScore(self)
  return self.score
end

function GetPercentage(self)
  return self.percentageNotesHit
end

function IncrementNotesMissed(self)
  self.notesMissed = self.notesMissed + 1
end

function CheckSongEnd(self)
  if self.notesHit + self.notesMissed >= self.totalNotes then
    return true
  else
    return false
  end
end

function Accuracy(self)
  
end

function CheckGameOver
  
end

function DecrementHealth(self)
  self.health
end
