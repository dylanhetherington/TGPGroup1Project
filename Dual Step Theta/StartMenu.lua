require 'SongMenu'
StartMenu = {}
function StartMenu.Init()
  --Draw Background
  --Draw logo
  gameState = "Start"
end

function StartMenu.Update()
  --update background animation
  --check for playerInput
  --StartMenu.PlayerStart()
  if (love.keyboard.isDown('1')) then
    StartMenu.PlayerStart()
  end
end

function StartMenu.Draw()
  --Draw Logo and Background
end

function StartMenu.PlayerStart()
  gameState = "SongMenu"
  songMenu = SongMenu.Init()
end