local lp = game.Players.LocalPlayer
local function getNearest()
    local nearest, dist = nil, 9999999
    for _,v in pairs(game:GetService("Workspace").Empregos.Lixos:GetChildren()) do
        if v:FindFirstChildOfClass("ProximityPrompt") and v.Name ~= 'Ocupado' then
            local m =(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.Position).magnitude
            if(m<dist)then
                dist = m
                nearest = v
            end
        end
    end
    return nearest
end


local function fire(Obj)
    Obj.HoldDuration = 0
    Obj:InputHoldBegin()
    Obj:InputHoldEnd()
end


if not lp.Backpack:FindFirstChild('Vassoura') and not lp.Character:FindFirstChild('Vassoura') then
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-1141.8599853515625, 146.1792449951172, -96.70348358154297)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "oi", 
        Text = 'pega a vassoura fazendo favor!',
        Icon = 'rbxassetid://1368839238', 
        Duration = 8
    })
end

repeat wait() until lp.Backpack:FindFirstChild('Vassoura') or lp.Character:FindFirstChild('Vassoura')
if lp.Backpack:FindFirstChild('Vassoura') then
    lp.Backpack.Vassoura.Parent = lp.Character
end

local nearest = getNearest()
lp.Character.HumanoidRootPart.CFrame = CFrame.new(nearest.Position)

wait(0.5)
for i=1,5000 do
    fire(nearest.PVarrer)
end
