local AnimationsList = {}
local animations = { --//Possibly make nested tables an array to improve performance
    ["Slash"] = "1230183981"
}

for i,id in ipairs(animations) do
    animations[i] = "rbxassetid://"..id
end

function AnimationsList:Hook(char,animIndex)
    local animId = animations[animIndex]
    if not animId then return end

    local hum = char:FindFirstChild("Humanoid")
    local animator = hum.Animator

    animations[animIndex][2] = animator:LoadAnimation(animId)
end

function AnimationsList:Unhook()
    for i,v in ipairs(animations) do
        animations[i][2] = nil
    end
end

return AnimationsList