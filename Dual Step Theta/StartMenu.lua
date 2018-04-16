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
end

function StartMenu.Draw()
  love.graphics.draw(backgroundVideo,0,0)
  love.graphics.draw(logo,100,100)
end