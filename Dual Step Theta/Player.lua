Player = { combo,
          health,
          modifier, 
          }
local healthBar = love.graphics.newImage('Assets/health bar.png')
function Player.New()
  player = setmetatable({}, Player)
  player.health = 100
  player.combo = 0
  player.modifier = 0
  return player
end

function Player.AdjustHealth(self, adjustment)
  self.health = self.health + adjustment
end

function Player.AdjustCombo(self, adjustment)
  self.combo = self.combo + adjustment
end

function Player.ResetCombo(self)
  self.combo = 0
end

function Player.ResetHealth(self)
  self.health = 100
end

function Player.AdjustModifier(self, adjustment)
  self.modifier = self.modifier + adjustment
end

function Player.ResetModifier(self)
  self.modifier = 0
end

function Player.Draw(self)
  if (self.health > 0) then
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill",10,926,40,-self.health * 7) --height changes based on player health
    love.graphics.setColor(255,255,255,255)
  end
  love.graphics.draw(healthBar, 10, 200)
end
