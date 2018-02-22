require 'SongMenu'
StartMenu = {}

function StartMenu.Init()
  logo = love.graphics.newImage("Assets/wiplogo.png")
  bg1 = love.graphics.newImage("Assets/wipbg1.png")
  bg2 = love.graphics.newImage("Assets/wipbg2.png")
  bg3 = love.graphics.newImage("Assets/wipbg3.png")
  bg4 = love.graphics.newImage("Assets/wipbg4.png")
  bg5 = love.graphics.newImage("Assets/wipbg5.png")
  bg6 = love.graphics.newImage("Assets/wipbg6.png")
  bg = bg1
  timer = 0
  gameState = "Start"
end

function StartMenu.Update(dt)
  timer = timer + dt
  maxTimer = 2
  if(bg == bg1 and timer >= maxTimer)then
    bg = bg2
    timer = 0
  elseif(bg == bg2 and timer >= maxTimer)then
    bg = bg3
    timer = 0
  elseif(bg == bg3 and timer >= maxTimer)then
    bg = bg4
    timer = 0
  elseif(bg == bg4 and timer >= maxTimer)then
    bg = bg5
    timer = 0
  elseif(bg == bg5 and timer >= maxTimer)then
    bg = bg6
    timer = 0
  elseif(bg == bg6 and timer >= maxTimer)then
    bg = bg1
    timer = 0
  end
  if (love.keyboard.isDown('1')) then
    StartMenu.PlayerStart()
  end
end

function StartMenu.Draw()
  love.graphics.draw(bg,0,0)
  love.graphics.draw(logo,100,100)
end

function StartMenu.PlayerStart()
  gameState = "SongMenu"
  songMenu = SongMenu.Init()
end