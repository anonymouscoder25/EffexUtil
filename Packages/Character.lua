local Players = game:GetService("Players")

local character_connections = {}
local Character = {}

function Character.init(died,spawned)
    Players.PlayerAdded:Connect(function(plr)
        self.new(plr,died,spawned)
    end)
end

function Character.new(plr,died,spawned)
    local c1
    c1 = plr.CharacterAdded:Connect(function(char)
        local hum = char:FindFirstChild("Humanoid")
        spawned(char)
        hum.Died:Connect(function()
            died(char)
        end)
    end)
    return {c1}
end

return Character