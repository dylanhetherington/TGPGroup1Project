--require 'PlayField'
ScoreManager = {totalNotes,
                notesHit,
                combo,
                score,
                health,
                percentageNotesHit,
                notesMissed,
                playField,}

function ScoreManager.New(totalNotesSong, PlayField)
  scoreManager = setmetatable({}, ScoreManager)
  scoreManager.totalNotes = totalNotesSong
  scoreManager.notesHit = 0
  scoreManager.combo = 0
  scoreManager.score = 0
  scoreManager.health = 0
  scoreManager.percentageNotesHit = 0
  scoreManager.notesMissed = 0
  scoreManager.playField = PlayField
  return scoreManager
end
  
function ScoreManager.IncrementNotesHit(self)
  self.notesHit = self.notesHit + 1
  self.score = self.score + 1
end

function ScoreManager.GetNotesHit(self)
  return self.notesHit
end

function ScoreManager.IncrementCombo(self)
  self.combo = self.combo + 1
end

function ScoreManager.ResetCombo(self)
  self.combo = 0
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

function ScoreManager.CheckSongEnd(self)
  if self.notesHit + self.notesMissed >= self.totalNotes then
    return true
  else
    return false
  end
end

function ScoreManager.Accuracy(self, value)
  if (value >= 1000 and value <= 10000) then
    --loseHealth
  elseif (value >= 500 and value <  1000 )then
    --hit
  elseif (value >=100 and value < 500 ) then
    --good hit
  elseif (value < 100) then

    --perfect
  else
    --nothing happens note was not active.
  end
end

function ScoreManager.CheckGameOver()
  
end

function ScoreManager.DecrementHealth(self)
  self.health = self.health - 1
end
