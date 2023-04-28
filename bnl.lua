_G.farming = true

game:GetService("ReplicatedStorage"):WaitForChild("BagulhoRemote"):WaitForChild("Trabalho"):FireServer("Lixeiro")
local lp = game.Players.LocalPlayer
local savepos = lp.Character.HumanoidRootPart.Position
local ws = game:GetService("Workspace")
local pos = Vector3.new(0,-5,0)
local lixos = {}
local function fire(Obj)
    Obj:InputHoldBegin()
    Obj:InputHoldEnd()
end

function breakvelocity()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0,0)    
end


for _,v in pairs(ws:GetDescendants()) do
    if v.Name == 'SacoDeLixo' and v:FindFirstChild('ProximityPrompt') then
        table.insert(lixos,v)
        v.ProximityPrompt.HoldDuration = 0
    end
end

while wait() do
    if _G.farming then
        for _,v in next, lixos do
            for i=1,50 do
                if _G.farming then
                    breakvelocity()
                    lp.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position+pos)
                    fire(v.ProximityPrompt)
                    task.wait()
                    else break
                end
            end
        end
        else 
            for i=1,50 do
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(savepos)
                wait()
            end
        break
    end
end
