require 'Song'
require 'Rail'
require 'ScoreManager'
require 'Note'
--require 'Player'

local screen = require "shack"
screen:setDimensions(1920,1080)
--local graphics
local healthBar = love.graphics.newImage('Assets/health bar.png')
local background = love.graphics.newImage('Assets/voidBackground1080.png')
local UI = love.graphics.newImage('Assets/PlayFieldUI1080.png')
local hitBarrier = love.graphics.newImage('Assets/NoteHitBarrier1080.png')
local hitConfirm =  love.graphics.newImage('Assets/HitConfirm1080.png')
local missMessage = love.graphics.newImage('Assets/Miss.png')
local closeMessage = love.graphics.newImage('Assets/Close.png')
local hitMessage = love.graphics.newImage('Assets/Hit.png')
local perfectMessage = love.graphics.newImage('Assets/Perfect.png')
local hitMarkers = love.graphics.newImage('Assets/Hit Markers (2).png')
local earthEnemy = love.graphics.newImage('Assets/EarthEnemy.png')
local waterEnemy = love.graphics.newImage('Assets/WaterEnemy.png')
local fireEnemy = love.graphics.newImage('Assets/FireEnemy.png')
local neutralEnemy = love.graphics.newImage('Assets/NeutralEnemy.png')
local earthBuff = love.graphics.newImage('Assets/EarthBuff.png') -- 0
local waterBuff = love.graphics.newImage('Assets/WaterBuff.png') -- 1
local fireBuff = love.graphics.newImage('Assets/FireBuff.png') -- 2
local monster = waterEnemy

local songStart = false
local pause = false
local hitTimer1 = 2
local hitTimer2 = 2
local hitTimer3 = 2
local hitTimer4 = 2
local messageTimer = 2
local frameCounter0 = 7
local frameCounter1 = 7
local frameCounter2 = 7
local frameCounter3 = 7
local frameTimer0 = 0
local frameTimer1 = 0
local frameTimer2 = 0
local frameTimer3 = 0

PlayField = { timer,
              rails,
              scoreManager,
              user,
              song,
              songAudio,
              player,
              }

miss = false
hit = false
close = false
perfect = false
safe = false

rail0Hit = false
rail1Hit = false
rail2Hit = false
rail3Hit = false

function PlayField.New(song, playerInfo)
  playField = setmetatable({}, PlayField)
  playField.timer = 0.0
  songStart = false
  playField.rails = {}
  playField.player = playerInfo
  playField.song = song
  playField.scoreManager = ScoreManager.New(song.totalNotes, self)
  PlayField.CreateRails(playField)
  playField.songAudio = PlayField.LoadSongAudio(playField.song.audioFile)
  songArt = love.graphics.newImage('Songs/'..playField.song.artFile)
  endTimer = 0
  PlayField.SetUpAnimation()
  Player.ResetHealth(playField.player)
  playerElement = 0 --Earth
  monsterElement = 1
  monsterHealth = 100
  dead = false
  return playField
end

function PlayField.SetUpAnimation()
hitMarkerAnimation = {}
hitMarkerAnimation[0] = love.graphics.newQuad(0,0,292,334,hitMarkers:getDimensions()) --x / y / width/ height
hitMarkerAnimation[1] = love.graphics.newQuad(334,0,292,334,hitMarkers:getDimensions())
hitMarkerAnimation[2] = love.graphics.newQuad(668,0,292,334,hitMarkers:getDimensions())
hitMarkerAnimation[3] = love.graphics.newQuad(1002,0,292,334,hitMarkers:getDimensions())
hitMarkerAnimation[4] = love.graphics.newQuad(1336,0,292,334,hitMarkers:getDimensions())
hitMarkerAnimation[5] = love.graphics.newQuad(1670,0,292,334,hitMarkers:getDimensions())
hitMarkerAnimation[6] = love.graphics.newQuad(2004,0,292,334,hitMarkers:getDimensions())
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
screen:update(dt)
if (ScoreManager.CheckSongEnd(playField.scoreManager) == true or playField.player.health <= 0) then
  dead = true
  endTimer = endTimer + dt
  if (endTimer >= 5) then
    
    gameState = "SongMenu"
    songMenu = SongMenu.Init(playField.player)
    playField.songAudio:pause()
  end
end
  if (pause == false and dead == false) then
    if (songStart == false and playField.timer >= 1.3) then
      playField.songAudio:play()
      songStart = true
    end
    playField.timer = playField.timer + dt
    hitTimer1 = hitTimer1 + dt
    hitTimer2 = hitTimer2 + dt
    hitTimer3 = hitTimer3 + dt
    hitTimer4 = hitTimer4 + dt
    messageTimer = messageTimer + dt
    frameTimer0 = frameTimer0 + dt
    frameTimer1 = frameTimer1 + dt
    frameTimer2 = frameTimer2 + dt
    frameTimer3 = frameTimer3 + dt
    Rail.Update(playField.rails[0], dt, playField.timer)
    Rail.Update(playField.rails[1], dt, playField.timer)
    Rail.Update(playField.rails[2], dt, playField.timer)
    Rail.Update(playField.rails[3], dt, playField.timer)
    if (monsterHealth <= 0) then
      monsterElement = love.math.random(0, 3)
      if (monsterElement == 0) then
        monster = earthEnemy
      elseif (monsterElement == 1) then
        monster = waterEnemy
      elseif (monsterElement == 2) then
        monster = fireEnemy
      else
        monster = neutralEnemy
      end
      monsterHealth = 100
      Player.AdjustHealth(playField.player, 25)
      if (playField.player.health > 100) then
        Player.ResetHealth(playField.player)
      end
      ScoreManager.AdjustScore(playField.scoreManager, 1000 * playField.player.modifier)
    end
  if (frameTimer0 > 0.016)then
    frameTimer0 = 0
    frameCounter0 = frameCounter0 + 1
    if (frameCounter0 > 6) then
      rail0Hit = false
    end
  end
  if (frameTimer1 > 0.016)then
    frameTimer1 = 0
    frameCounter1 = frameCounter1 + 1
    if (frameCounter1 > 6) then
      rail1Hit = false
    end
  end
  if (frameTimer2 > 0.016)then
    frameTimer2 = 0
    frameCounter2 = frameCounter2 + 1
    if (frameCounter2 > 6) then
      rail2Hit = false
    end
  end
  if (frameTimer3 > 0.016)then
    frameTimer3 = 0
    frameCounter3 = frameCounter3 + 1
    if (frameCounter3 > 6) then
      rail3Hit = false
    end
  end
  end
end

function PlayField.Draw()
  screen:apply()
  love.graphics.draw(background,0, 0)
  love.graphics.draw(UI,0, 0)
  if (hitTimer1 < 0.2) then 
    love.graphics.draw(hitConfirm, 96, 350, 0, 0.75, 0.75)   
  end 
  if (hitTimer2 < 0.2) then 
    love.graphics.draw(hitConfirm, 288, 350, 0, 0.75, 0.75)   
  end 
  if (hitTimer3 < 0.2) then 
    love.graphics.draw(hitConfirm, 480, 350, 0, 0.75, 0.75)   
  end 
  if (hitTimer4 < 0.2) then 
    love.graphics.draw(hitConfirm, 672, 350, 0, 0.75, 0.75)
  end
  love.graphics.draw(hitBarrier,0, 0)
  love.graphics.setColor(0, 255, 0, 255)
  --love.graphics.print(playField.timer, 1000, 10)
  --love.graphics.print("FPS: "..tostring(love.timer.getFPS()),10,10)
  love.graphics.print("Score: "..playField.scoreManager.score, 1500, 0)
  love.graphics.setColor(255,255,255,255)
  if (messageTimer <= 0.2) then
      if (perfect == true) then
          love.graphics.draw(perfectMessage, 360, 300)
    elseif (hit == true) then
          love.graphics.draw(hitMessage, 405, 300)
    elseif (close == true) then
          love.graphics.draw(closeMessage, 430, 300)
    elseif (miss == true) then
          love.graphics.draw(missMessage, 420, 300)
    end
  end
  if (playerElement == 0) then
    love.graphics.draw(earthBuff)
  elseif (playerElement == 1) then
    love.graphics.draw(waterBuff)
  else
    love.graphics.draw(fireBuff)
  end
  Rail.DrawNote(playField.rails[0], 96)
  Rail.DrawNote(playField.rails[1], 288)
  Rail.DrawNote(playField.rails[2], 480)
  Rail.DrawNote(playField.rails[3], 672)
  if (rail0Hit == true) then
    love.graphics.draw(hitMarkers,hitMarkerAnimation[frameCounter0], 110, 840,0,0.5,0.5)
  end
  if (rail1Hit == true) then
    love.graphics.draw(hitMarkers,hitMarkerAnimation[frameCounter1], 302, 840,0,0.5,0.5)
  end
  if (rail2Hit == true) then
    love.graphics.draw(hitMarkers,hitMarkerAnimation[frameCounter2], 495, 840,0,0.5,0.5)
  end
  if (rail3Hit == true) then
   love.graphics.draw(hitMarkers,hitMarkerAnimation[frameCounter3], 687, 840,0,0.5,0.5)
  end
  if (songStart == false) then
    love.graphics.print(playField.song.songName,200, 500, 0,2)
    love.graphics.draw(songArt,250,600)
  end
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill",1800,926,40,-monsterHealth * 7)
    love.graphics.setColor(255,255,255,255)
    love.graphics.draw(healthBar, 1800, 200)
    love.graphics.draw(monster,0,0)
end

function love.keypressed(key, scancode, isrepeat)
  if (key == "d" and pause == false and dead == false and gameState == "Play") then
    hitTimer1 = 0
    accuracy = Rail.InteractWithNote(playField.rails[0], playField.timer, 144)
    PlayField.Accuracy(accuracy, 0)
  end
  if (key == "f" and pause == false and dead == false and gameState == "Play") then
    hitTimer2 = 0
    accuracy = Rail.InteractWithNote(playField.rails[1], playField.timer, 336)
    PlayField.Accuracy(accuracy, 1)
  end
  if (key == "j" and pause == false and dead == false and gameState == "Play") then
    hitTimer3 = 0
    accuracy = Rail.InteractWithNote(playField.rails[2], playField.timer, 528)
    PlayField.Accuracy(accuracy, 2)
  end
  if (key == "k" and pause == false and dead == false and gameState == "Play") then
    hitTimer4 = 0
    accuracy = Rail.InteractWithNote(playField.rails[3], playField.timer, 720)
    PlayField.Accuracy(accuracy, 3) 
  end
  if (key == "s" and pause == false and dead == false and gameState == "Play") then
    playerElement = playerElement - 1
    if (playerElement <= -1) then
      playerElement = 2
    end
  end
  if (key == "l" and pause == false and dead == false and gameState == "Play") then
    playerElement = playerElement + 1
    if (playerElement >= 3) then
      playerElement = 0
    end
  end
  if (key == "backspace" and gameState == "Play") then
    gameState = "SongMenu"
    songMenu = SongMenu.Init(playField.player)
    playField.songAudio:pause()
  elseif (key == "p" and gameState == "Play") then
    if (pause == false) then
      pause = true
      playField.songAudio:pause()
    else
      pause = false
      playField.songAudio:play()
    end
  elseif (key == "return" and gameState == "Start") then
    gameState = "SongMenu"
    SongMenu.Init(player)
  elseif (key == "return" and gameState == "SongMenu") then
    SongMenu.SelectSong()
  end
end
function PlayField.Accuracy(value, railNumber)
  local spawnHit = false
  if (messageTimer >= 0.2) then
    messageTimer = 0
    perfect = false;
    hit = false;
    miss = false;
    close = false;
  end
  if (value < -300 and value >= -800 or value > 10 and value < 100) then
   --if (railNumber == 0) then
    screen:setShake(10)
     miss = true 
    --end
    Player.AdjustHealth(playField.player, -2)
    Player.ResetCombo(playField.player)
    Player.SetModifier(playField.player, 1)
  elseif (value < -200 and value >= -300 )then
    --if (railNumber == 0) then
    close = true
    --end
    spawnHit = true
    Player.AdjustCombo(playField.player, 1)
    Player.SetModifier(playField.player, (playField.player.combo * 0.2) + 1)
    ScoreManager.IncrementNotesHit(playField.scoreManager)
    if (PlayField.CheckMonsterWeakness == true) then
      Player.setDamage(playField.player, (0.5 * playField.player.modifier) * 1.5)
    elseif (PlayField.CheckPlayerWeakness == true) then
      Player.setDamage(playField.player, (0.5 * playField.player.modifier) * 0.5)
    else
      Player.SetDamage(playField.player, 0.5 * playField.player.modifier)
    end
    monsterHealth = monsterHealth - playField.player.damage
  elseif (value < -100 and value >= -200 ) then
    --if (railNumber == 0) then
    hit = true
    --end
    spawnHit = true
    Player.AdjustCombo(playField.player, 1)
    Player.SetModifier(playField.player, (playField.player.combo * 0.2) + 1)
    ScoreManager.IncrementNotesHit(playField.scoreManager)

    if (PlayField.CheckMonsterWeakness == true) then
      Player.setDamage(playField.player, (1 * playField.player.modifier) * 1.5)
    elseif (PlayField.CheckPlayerWeakness == true) then
      Player.setDamage(playField.player, (1 * playField.player.modifier) * 0.5)
    else
      Player.SetDamage(playField.player, 1 * playField.player.modifier)
    end
    monsterHealth = monsterHealth - playField.player.damage
  elseif (value < 10 and value >= -100) then
    --if (railNumber == 0) then
    perfect = true 
    --end
    spawnHit = true
    Player.AdjustCombo(playField.player, 1)
    Player.SetModifier(playField.player, (playField.player.combo * 0.2) + 1)
    ScoreManager.IncrementNotesHit(playField.scoreManager)
    if (PlayField.CheckMonsterWeakness == true) then
      Player.setDamage(playField.player, (2 * playField.player.modifier) * 1.5)
    elseif (PlayField.CheckPlayerWeakness == true) then
      Player.setDamage(playField.player, (2 * playField.player.modifier) * 0.5)
    else
      Player.SetDamage(playField.player, 2 * playField.player.modifier)
    end
    monsterHealth = monsterHealth - playField.player.damage
  end
  if (spawnHit == true) then
    if (railNumber == 0) then
      rail0Hit = true
      frameCounter0 = 0
    elseif (railNumber == 1) then
      rail1Hit = true
      frameCounter1 = 0
    elseif (railNumber == 2) then
      rail2Hit = true
      frameCounter2 = 0
    elseif (railNumber == 3) then
      rail3Hit = true
      frameCounter3 = 0
    end
  end
end
function PlayField.CheckPlayerWeakness()
  if (playerElement == 1 and monsterElement == 0) then
    return true
  elseif (playerElement == 2 and monsterElement == 1) then
    return true
  elseif (playerElement == 0 and monsterElement == 2) then
    return true
  end
  return false
end
function PlayField.CheckMonsterWeakness()
  if (playerElement == 0 and monsterElement == 1) then
    return true
  elseif (playerElement == 1 and monsterElement == 2) then
    return true
  elseif (playerElement == 2 and monsterElement == 0) then
    return true
  end
  return false
end