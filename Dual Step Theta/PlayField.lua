require 'Song'
require 'Rail'
require 'ScoreManager'
require 'Note'


PlayField = { timer,
              rails,
              scoreManager,
              user,
              song }

function PlayField.New(song)
  playField = setmetatable({}, PlayField)
  playField.timer = 0.0
  playField.rails = {}
  --playField.scoreManager = ScoreManager.New()
  --playField.user = User.New()
  playField.song = song
  PlayField.CreateRails(playField)
  return playField
end

function PlayField.CreateRails(self)
  railOne = Rail.New(0);  railTwo = Rail.New(1); railThree = Rail.New(2); railFour = Rail.New(3)
  self.rails[0] = railOne; self.rails[1] = railTwo; self.rails[2] = railThree; self.rails[3] = railFour
  for i, note in pairs(self.song.notes) do
    if (note.rail == 0) then
      Rail.AddNote(self.rails[0], note)
    elseif (note.rail == 1) then
      Rail.AddNote(self.rails[1], note)
    elseif (note.rail == 2) then
      Rail.AddNote(self.rails[2], note)
    else
      Rail.AddNote(self.rails[3], note)
      end
    end
end

function PlayField.Update(dt)
  playField.timer = playField.timer + dt
  Rail.Update(playField.rails[0], dt, playField.timer)
  Rail.Update(playField.rails[1], dt, playField.timer)
  Rail.Update(playField.rails[2], dt, playField.timer)
  Rail.Update(playField.rails[3], dt, playField.timer)
    --for i, note in pairs(playField.rails[0]) do
    --print(i.." | "  ..note.startTime.."  "..note.noteType.."  "..note.endTime)
    --end
end

function PlayField.Draw()
  love.graphics.print(playField.timer, 600, 10)
  Rail.DrawNote(playField.rails[0], 100)
  Rail.DrawNote(playField.rails[1], 200)
  Rail.DrawNote(playField.rails[2], 300)
  Rail.DrawNote(playField.rails[3], 400)
end

function PlayField.DrawNote()
  
end