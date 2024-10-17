local connections = {}

local FakeTool = {}

function FakeTool:Hook(char)
    local toolPivot = char["Right Arm"] or char["Right Hand"]
    if not toolPivot then warn("no toolPivot") return end
    connections[char.Name] = {}
    local c1 = char.ChildAdded:Connect(function(instance)
        if instance:IsA("Model") then
            local targetPart = instance.PrimaryPart or instance:FindFirstChild("BodyAttach")
            if not targetPart then warn("no targetPart") return end
            local m6d = Instance.new("Motor6D")
            m6d.Name = "FakeToolM6D"
            m6d.Part0 = toolPivot
            m6d.Part1 = targetPart
            m6d.Parent = toolPivot
        end
    end)

    local c2 = char.ChildRemoved:Connect(function(instance)
        if instance:IsA("Model") then
            local m6d = toolPivot:FindFirstChild("FakeToolM6D")
            m6d:Destroy()
        end
    end)

    table.insert(connections[char.Name],c1)
    table.insert(connections[char.Name],c2)
end

function FakeTool:Unhook(char)
    if connections[char.Name] then
        for _,comp in ipairs(connections[char.Name]) do
            comp:Disconnect()
        end
    end
end

return FakeTool
