Player = { combo,
          health,
          modifier,
          damage,
          }
local healthBar = love.graphics.newImage('Assets/health bar.png')
function Player.New()
  player = setmetatable({}, Player)
  player.health = 100
  player.combo = 0
  player.modifier = 1
  player.damage = 0
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

function Player.SetModifier(self, adjustment)
  self.modifier = adjustment
end

function Player.ResetModifier(self)
  self.modifier = 1
end

function Player.SetDamage(self, adjustment)
  self.damage = adjustment
end

function Player.AdjustDamage(self, adjustment)
  self.damage = self.damage + adjustment
end

function Player.Draw(self)
  love.graphics.print("x"..self.modifier, 440, 260)
  if (self.combo ~= 0 ) then
    love.graphics.print(self.combo, 460, 340)
  end
  if (self.health > 0) then
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill",10,926,40,-self.health * 7) --height changes based on player health
    love.graphics.setColor(255,255,255,255)
  end
  love.graphics.draw(healthBar, 10, 200)
  --love.graphics.print("DAMAGE: "..self.damage, 460, 400)
end
