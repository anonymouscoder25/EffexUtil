local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player.PlayerGui

local camera = workspace.CurrentCamera

local main = {}

function main.refactor(absoluteSize,viewportSize)
    local x = absoluteSize.X/viewportSize.X
    local y = absoluteSize.Y/viewportSize.Y
    return UDim2.fromScale(x,y)
end

function main.scaleSize(guiObject)
    if guiObject.Parent then
        if guiObject.Parent:IsA("ScreenGui") then
            main.refactor(guiObject.absoluteSize,camera.ViewportSize)
        elseif guiObject.Parent:IsA("GuiObject") then
            main.refactor(guiObject.absoluteSize,guiObject.Parent.AbsoluteSize)
        end
    end
end

function main.scalePosition(guiObject)
    if guiObject.Parent then
        if guiObject.Parent:IsA("ScreenGui") then
            main.refactor(guiObject.absolutePosition,camera.ViewportSize)
        elseif guiObject.Parent:IsA("GuiObject") then
            main.refactor(guiObject.absolutePosition,guiObject.Parent.AbsoluteSize)
        end
    end
end


function main.constraintsToText(guiObject)
    local textConstraint = Instance.new("UITextSizeConstraint")
    textConstraint.MaxTextSize = guiObject.Text
    textConstraint.MinTextSize = 1
    textConstraint.Parent = guiObject
end

function main.aspectRatio(guiObject)
    local aspectRatio = Instance.new("UIAspectRatioConstraint")
    aspectRatio.AspectRatio = guiObject.AbsoluteSize.X/guiObject.AbsoluteSize.Y
    aspectRatio.Parent = guiObject
end

return function()
    for _,comp in ipairs(playerGui:GetDescendants()) do
        if comp:IsA("GuiObject") then

            if comp.Parent then
                if not comp.Parent:FindFirstChildWhichIsA("UIGridLayout") then
                    if comp.Size.X.Offset ~= 0 or comp.Size.Y.Offset ~= 0 then
                        main.scaleSize(comp)
                    end
        
                    if comp.Position.X.Offset ~= 0 or comp.Position.Y.Offset ~= 0 then
                        main.scalePosition(comp)
                    end
                end

                if comp.Parent:IsA("ScreenGui") then
                    main.aspectRatio(comp)
                end
            end
            if comp:IsA("TextLabel") or comp:IsA("TextButton") then
                main.constraintsToText(comp)
            end
        end
    end
end