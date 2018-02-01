require 'Song'
require 'Rail'
require 'ScoreManager'


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
  PlayField.CreateRails()
  return playField
end

function PlayField.CreateRails()
  railOne = Rail.New();  railTwo = Rail.New(); railThree = Rail.New(); railFour = Rail.New()
  playField.rails[0] = railOne; playField.rails[1] = railTwo; playField.rails[2] = railThree; playField.rails[3] = railFour
  for i, note in pairs(playField.song.notes) do
    if (note.rail == 0) then
      Rail.AddNote(playField.rails[0], note)
    elseif (note.rail == 1) then
      Rail.AddNote(playField.rails[1], note)
    elseif (note.rail == 2) then
      Rail.AddNote(playField.rails[2], note)
    else
      Rail.AddNote(playField.rails[3], note)
      end
    end
end
function PlayField.Update(dt)
      print(playField.song.songName.."\n"..playField.song.artist.."\n"..playField.song.audioFile.."\n"..  playField.song..audioPreview.."\n"..playField.song.artFile.."\n"..playField.song.difficulty.."\n"..playField.song.rating.."\n"..playField.song.noteChart.."\n"..playField.song.bestScore.."\n"..playField.song.previousScore)
    for i, note in pairs(activeSong.notes) do
    print(i.." | "..note.rail.."  "..note.startTime.."  "..note.noteType.."  "..note.endTime)
    end
end