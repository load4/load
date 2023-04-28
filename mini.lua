local lp = game.Players.LocalPlayer
local pos = Vector3.new(0,-4,0)
_G.currentpos = lp.Character.HumanoidRootPart.Position
local Noclipping = nil
local function NoclipLoop()
    if lp.Character ~= nil then
        for _, child in pairs(lp.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true  then
                child.CanCollide = false
            end
        end
    end
end
Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)

task.spawn(function()
    while wait() do
        lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        lp.Character.Torso.Velocity = Vector3.new(0,0,0)
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(_G.currentpos)
    end
end)

function try()
    if lp.PlayerGui.Prompts.ProximityPrompts:FindFirstChild("Prompt") then
        if lp.PlayerGui.Prompts.ProximityPrompts.Prompt.Frame.InputFrame.Frame:FindFirstChild("CircularProgressBar") then
            lp.PlayerGui.Prompts.ProximityPrompts.Prompt.Frame.InputFrame.Frame.CircularProgressBar.Progress.Value = 1
        end
    end
end


local function fire(Obj)
    Obj.HoldDuration = 3
    Obj:InputHoldBegin()
    wait(3.4)
    Obj:InputHoldEnd()
end

for i, v in pairs(lp.Character:GetDescendants()) do
    if v:IsA('BillboardGui') then
        v:Destroy()
    end
end


while wait() do
    for _,v in pairs(game:GetService("Workspace").MapaGeral.Gari.Lixos:GetChildren()) do
        if v.Transparency == 0 then
            repeat wait()
            workspace.CurrentCamera.CameraSubject = v
            lp.Character.HumanoidRootPart.Anchored = false
            _G.currentpos = v.Position+pos

            local i=0
            if v.Transparency == 1 then break end
            repeat wait() i=i+1 until i>30 or lp.PlayerGui.Prompts.ProximityPrompts:FindFirstChild("Prompt") or v.Transparency == 1
            if v.Transparency == 1 then break end
            wait(.2)
            try()
            lp.Character.HumanoidRootPart.Anchored = true
            fire(v.ProximityPrompt)
            lp.Character.HumanoidRootPart.Anchored = false
            until v.Transparency == 1
            local n=0
            for _,x in pairs(lp.equipados:GetChildren()) do
                if x.Name == 'Saco de Lixo' then
                    n=n+1
                end
            end
            if n>=10 then
                game:GetService("ReplicatedStorage").RemoteNovos.trabalhos:FireServer("GARIZADA")
            end
        end
    end
end






