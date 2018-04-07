require 'Song'
require 'Rail'
require 'ScoreManager'
require 'Note'

--local graphics
local background = love.graphics.newImage('Assets/voidBackground1080.png')
local UI = love.graphics.newImage('Assets/PlayFieldUI1080.png')
local hitBarrier = love.graphics.newImage('Assets/NoteHitBarrier1080.png')
local hitConfirm =  love.graphics.newImage('Assets/HitConfirm1080.png')

local songStart = false
local pause = false
local hitRail = nil
local hitTimer = 0
PlayField = { timer,
              rails,
              scoreManager,
              user,
              song,
              songAudio,}

miss = false
hit = false
close = false
perfect = false
safe = false

function PlayField.New(song)
  playField = setmetatable({}, PlayField)
  playField.timer = 0.0
  playField.rails = {}
  --playField.user = User.New()
  playField.song = song
  playField.scoreManager = ScoreManager.New(song.totalNotes, self)
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
      --playField.timer = 0
    end
    playField.timer = playField.timer + dt / 2
    hitTimer = hitTimer + dt
      Rail.Update(playField.rails[0], dt/2, playField.timer)
      Rail.Update(playField.rails[1], dt/2, playField.timer)
      Rail.Update(playField.rails[2], dt/2, playField.timer)
      Rail.Update(playField.rails[3], dt/2, playField.timer)
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
  love.graphics.draw(background,0, 0)
  love.graphics.draw(UI,0, 0)
  love.graphics.draw(hitBarrier,0, 0)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print(playField.timer, 600, 10)
  love.graphics.print(playField.scoreManager.score, 900, 10)
  --love.graphics.draw(hitConfirm, 144 - 48, 700, 0, 0.75, 0.75)  
    if (perfect == true) then
        love.graphics.print("PERFECT", 800, 300,0,4,4)

        print("Perfect")
  elseif (hit == true) then
        love.graphics.print("HIT", 800, 300,0,4,4)
        print("hit")
  elseif (close == true) then
        love.graphics.print("CLOSE", 800, 300,0,4,4)
        print("close")
  elseif (miss == true) then
        love.graphics.print("MISS", 800, 300,0,4,4)
        print("Miss")
  --elseif (safe == true) then
    --love.graphics.print("SAFE", 800, 300, 0, 4,4)
    --print("safe")
  end
  love.graphics.setColor(255,255,255,255)
  Rail.DrawNote(playField.rails[0], 144)
  Rail.DrawNote(playField.rails[1], 336)
  Rail.DrawNote(playField.rails[2], 528)
  Rail.DrawNote(playField.rails[3], 720)
  if (hitRail ~= nil and hitTimer < 1) then
    drawNumber = hitRail
    love.graphics.draw(hitConfirm, drawNumber * 144, 700, 0, 0.75, 0.75)  
  end
  perfect = false;
  hit = false;
  miss = false;
  close = false;
 -- safe = false;
end

function love.keypressed(key, scancode, isrepeat)
  if (key == "d") then
    accuracy = Rail.InteractWithNote(playField.rails[0], playField.timer, 144)
    PlayField.Accuracy(accuracy, 1)
  end
  if (key == "f") then
    accuracy = Rail.InteractWithNote(playField.rails[1], playField.timer, 336)
    PlayField.Accuracy(accuracy, 2)
  end
  if (key == "k") then
    accuracy = Rail.InteractWithNote(playField.rails[2], playField.timer, 528)
    PlayField.Accuracy(accuracy, 3)
  end
  if (key == "l") then
    accuracy = Rail.InteractWithNote(playField.rails[3], playField.timer, 720)
    PlayField.Accuracy(accuracy, 4) 
  end
end

function PlayField.Accuracy(value, railNumber)
  if (value < -300 and value >= -800 or value > 10 and value < 100) then
    miss = true 
  elseif (value < -200 and value >= -300 )then
    close = true
    hitTimer = 0
    hitRail = railNumber
  elseif (value < -100 and value >= -200 ) then
    hit = true
    hitTimer = 0
    hitRail = railnumber
  elseif (value < 10 and value >= -100) then
    perfect = true 
    hitTimer = 0
    hitRail = railNumber
 -- else
    --nothing happens note was not active.
    --safe = true
  end
  ScoreManager.Accuracy(playField.scoreManager, accuracy)
end