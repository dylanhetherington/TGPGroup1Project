require 'SongMenu'
StartMenu = {}

function StartMenu.Init()
  backgroundVideo = love.graphics.newVideo("Assets/StartMenuBackground.ogv",nil)
  backgroundVideo:play()
  logo = love.graphics.newImage("Assets/LogoMenu.png")
  gameState = "Start"
end

function StartMenu.Update(dt)
  if (backgroundVideo:isPlaying() == false) then
    backgroundVideo:rewind()
  end
  if (love.keyboard.isDown('1')) then
    StartMenu.PlayerStart()
  end
end

function StartMenu.Draw()
  love.graphics.draw(backgroundVideo,0,0)
  love.graphics.draw(logo,100,100)
end

function StartMenu.PlayerStart()
  gameState = "SongMenu"
  SongMenu.Init()
end