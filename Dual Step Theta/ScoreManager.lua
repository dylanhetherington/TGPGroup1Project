--require 'PlayField'
ScoreManager = {totalNotes,
                notesHit,
                score,
                percentageNotesHit,
                notesMissed,
                playField,}

function ScoreManager.New(totalNotesSong, PlayField)
  scoreManager = setmetatable({}, ScoreManager)
  scoreManager.totalNotes = totalNotesSong
  scoreManager.notesHit = 0
  scoreManager.score = 0
  scoreManager.percentageNotesHit = 0
  scoreManager.notesMissed = 0
  scoreManager.playField = PlayField
  return scoreManager
end
  
function ScoreManager.IncrementNotesHit(self)
  self.notesHit = self.notesHit + 1
end

function ScoreManager.GetNotesHit(self)
  return self.notesHit
end

function ScoreManager.GetScore(self)
  return self.score
end

function ScoreManager.GetPercentage(self)
  return self.percentageNotesHit
end

function ScoreManager.IncrementNotesMissed(self)
  self.notesMissed = self.notesMissed + 1
end

function ScoreManager.AdjustScore(self, adjustment)
  self.score = self.score + adjustment
end
function ScoreManager.CheckSongEnd(self)
  if (self.notesHit + self.notesMissed >= self.totalNotes) then
    return true
  else
    return false
  end
end
