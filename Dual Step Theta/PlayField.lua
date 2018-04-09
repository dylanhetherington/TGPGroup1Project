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

local hitTimer1 = 2
local hitTimer2 = 2
local hitTimer3 = 2
local hitTimer4 = 2

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
  songStart = false
  playField.rails = {}
  --playField.user = User.New()
  playField.song = song
  playField.scoreManager = ScoreManager.New(song.totalNotes, self)
  PlayField.CreateRails(playField)
  playField.songAudio = PlayField.LoadSongAudio(playField.song.audioFile)
  songArt = love.graphics.newImage('Songs/'..playField.song.artFile)
  endTimer = 0
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
    hitTimer1 = hitTimer1 + dt
    hitTimer2 = hitTimer2 + dt
    hitTimer3 = hitTimer3 + dt
    hitTimer4 = hitTimer4 + dt
    Rail.Update(playField.rails[0], dt/2, playField.timer)
    Rail.Update(playField.rails[1], dt/2, playField.timer)
    Rail.Update(playField.rails[2], dt/2, playField.timer)
    Rail.Update(playField.rails[3], dt/2, playField.timer)
    if (ScoreManager.CheckSongEnd(playField.scoreManager) == true) then
      endTimer = endTimer + dt
      if (endTimer >= 5) then
        gameState = "SongMenu"
        songMenu = SongMenu.Init()
        playField.songAudio:pause()
      end
    end
  end 
end
function PlayField.Draw()
  love.graphics.draw(background,0, 0)
  love.graphics.draw(UI,0, 0)
  love.graphics.draw(hitBarrier,0, 0)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print(playField.timer, 1000, 10)
  love.graphics.print(playField.scoreManager.score, 1600, 10)
  love.graphics.print(playField.scoreManager.combo, 1600, 50)
  love.graphics.print(playField.scoreManager.notesMissed, 1600, 100)
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
  end
  love.graphics.setColor(255,255,255,255)
  Rail.DrawNote(playField.rails[0], 144)
  Rail.DrawNote(playField.rails[1], 336)
  Rail.DrawNote(playField.rails[2], 528)
  Rail.DrawNote(playField.rails[3], 720)
  if (hitTimer1 < 0.2) then
    love.graphics.draw(hitConfirm, 96, 700, 0, 0.75, 0.75)  
  end
  if (hitTimer2 < 0.2) then
    love.graphics.draw(hitConfirm, 288, 700, 0, 0.75, 0.75)  
  end
  if (hitTimer3 < 0.2) then
    love.graphics.draw(hitConfirm, 480, 700, 0, 0.75, 0.75)  
  end
  if (hitTimer4 < 0.2) then
    love.graphics.draw(hitConfirm, 672, 700, 0, 0.75, 0.75)  
  end
  perfect = false;
  hit = false;
  miss = false;
  close = false;
   if (songStart == false) then
    love.graphics.print(playField.song.songName,200, 500, 0,2)
    love.graphics.draw(songArt,250,600)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if (key == "d" and pause == false) then
    accuracy = Rail.InteractWithNote(playField.rails[0], playField.timer, 144)
    PlayField.Accuracy(accuracy, 1)
  end
  if (key == "f" and pause == false) then
    accuracy = Rail.InteractWithNote(playField.rails[1], playField.timer, 336)
    PlayField.Accuracy(accuracy, 2)
  end
  if (key == "k" and pause == false) then
    accuracy = Rail.InteractWithNote(playField.rails[2], playField.timer, 528)
    PlayField.Accuracy(accuracy, 3)
  end
  if (key == "l" and pause == false) then
    accuracy = Rail.InteractWithNote(playField.rails[3], playField.timer, 720)
    PlayField.Accuracy(accuracy, 4) 
  end
  if (key == "escape") then
    gameState = "SongMenu"
    songMenu = SongMenu.Init()
    playField.songAudio:pause()
  end
  if (key == "p") then
    if (pause == false) then
      pause = true
      playField.songAudio:pause()
    else
      pause = false
      playField.songAudio:play()
    end  
  end
end

function PlayField.Accuracy(value, railNumber)
  local spawnHit = false
  if (value < -300 and value >= -800 or value > 10 and value < 100) then
    miss = true 
    ScoreManager.ResetCombo(playField.scoreManager)
  elseif (value < -200 and value >= -300 )then
    close = true
    spawnHit = true
    ScoreManager.IncrementCombo(playField.scoreManager)
    ScoreManager.IncrementNotesHit(playField.scoreManager)
  elseif (value < -100 and value >= -200 ) then
    hit = true
    spawnHit = true
    ScoreManager.IncrementCombo(playField.scoreManager)
    ScoreManager.IncrementNotesHit(playField.scoreManager)
  elseif (value < 10 and value >= -100) then
    perfect = true 
    spawnHit = true
    ScoreManager.IncrementCombo(playField.scoreManager)
    ScoreManager.IncrementNotesHit(playField.scoreManager)
  end
  if (spawnHit == true) then
    if (railNumber == 1) then
      hitTimer1 = 0
    elseif (railNumber == 2) then
      hitTimer2 = 0 
    elseif (railNumber == 3) then
      hitTimer3 = 0      
    else 
      hitTimer4 = 0  
    end
  end
end