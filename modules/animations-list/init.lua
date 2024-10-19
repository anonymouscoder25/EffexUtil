local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages

local trove = require(packages.Trove).new() --//MUST HAVE TROVE IN GAME LOL

local AnimationsList = {}
AnimationsList.animations = { --index1 = id, index2 = animationTrack
    ["Slash"] = "1230183981"
}

local function createAnimation(animId)
    local animation = trove:Add(Instance.new("Animation"))
    animation.AnimationId = animId
    return animation
end

for i,id in ipairs(AnimationsList.animations) do
    AnimationsList.animations[i] = {"rbxassetid://"..id}
end

function AnimationsList:Play(char,animIndex)
    local animId = AnimationsList.animations[animIndex]
    if not animId or animId[2] then return end
    local hum = char:FindFirstChild("Humanoid")
    local animator = hum.Animator

    AnimationsList.animations[animIndex][2] = animator:LoadAnimation(animId)
end


function AnimationsList.new(char)
    trove:Destroy()
    local folder = trove:Add(Instance.new("Folder"))
    folder.Name = "Animations"
    folder.Parent = ReplicatedStorage

    local hum = char:FindFirstChild("Humanoid")
    local animator = hum.Animator
    for name,info in ipairs(AnimationsList.animations) do
        local anim = createAnimation(info[1])
        anim.Parent = folder
        AnimationsList.animations[name] = {info[1],animator:LoadAnimation(anim)}

        AnimationsList.Play(AnimationsList,char,name)
    end
end

return AnimationsList