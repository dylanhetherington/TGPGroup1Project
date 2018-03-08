require 'Song'
require 'Rail'
require 'ScoreManager'
require 'Note'

local songStart = false
local pause = false
PlayField = { timer,
              rails,
              scoreManager,
              user,
              song,
              songAudio,}

function PlayField.New(song)
  playField = setmetatable({}, PlayField)
  playField.timer = 0.0
  playField.rails = {}
  --playField.user = User.New()
  playField.song = song
  playField.scoreManager = ScoreManager.New(song.totalNotes)
  PlayField.CreateRails(playField)
  playField.songAudio = PlayField.LoadSongAudio(playField.song.audioFile)
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

function PlayField.LoadSongAudio(filepath)
  audio = love.audio.newSource("Songs/"..filepath, "static")
  return audio
end

function PlayField.Update(dt)
  if (pause == false) then
    if (songStart == false and playField.timer >= 1.3) then
      playField.songAudio:play()
      songStart = true
    end
    playField.timer = playField.timer + dt
    Rail.Update(playField.rails[0], dt, playField.timer)
    Rail.Update(playField.rails[1], dt, playField.timer)
    Rail.Update(playField.rails[2], dt, playField.timer)
    Rail.Update(playField.rails[3], dt, playField.timer)
    if (love.keyboard.isDown('8')) then
      pause = true
    end
  end
  if (pause == true) then
    playField.songAudio:pause()
    if (love.keyboard.isDown('7')) then
      pause = false
      playField.songAudio:play()
    end
  end
end

function PlayField.Draw()
  love.graphics.print(playField.timer, 600, 10)
  Rail.DrawNote(playField.rails[0], 100)
  Rail.DrawNote(playField.rails[1], 300)
  Rail.DrawNote(playField.rails[2], 500)
  Rail.DrawNote(playField.rails[3], 700)
end

function PlayField.DrawNote()
  
end

function RailsPressed()
  
end

function love.keypressed("d")
  accuracy = Rail.InteractWithNote(playField.rails[0], playField.timer)
  ScoreManager.Accuracy(playField.scoreManager, accuracy)
end

function love.keypressed("f")
  accuracy = Rail.InteractWithNote(playField.rails[1], playField.timer)
  ScoreManager.Accuracy(playField.scoreManager, accuracy)
end

function(love.keypressed("k")
  accuracy = Rail.InteractWithNote(playField.rails[2], playField.timer)
  ScoreManager.Accuracy(playField.scoreManager, accuracy)
end

function(love.keypressed("l")
  accuracy = Rail.InteractWithNote(playField.rails[3], playField.timer)
  ScoreManager.Accuracy(playField.scoreManager, accuracy)
end
