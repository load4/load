
_G.pneu = nil


local lp = game.Players.LocalPlayer


local function fire(prox)
    prox.HoldDuration = 0
    prox:InputHoldBegin()
    prox:InputHoldEnd()
end




function notify(title,text,timee)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = title, 
        Text = text,
        Icon = 'rbxassetid://8852106291', 
        Duration = timee
    })
end

for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v.Name == 'PegarRoda' and v:FindFirstChild('ReceberRoda') then
        local model = v:FindFirstAncestorOfClass("Model")
        _G.pneu = model.Roda
        break
    end
end


function getwheel(peneu)
    if peneu == 'FL' then
        return 'Sensor1'
    end
    if peneu == 'FR' then
        return 'Sensor3'
    end
    if peneu == 'RL' then
        return 'Sensor2'
    end
    if peneu == 'RR' then
        return 'Sensor4'
    end
end

if lp.PlayerGui:FindFirstChild('TrabalhoMecanicoGui') then
    while wait() do 
        for _, carro in pairs(workspace:GetChildren()) do
            if carro:FindFirstChild('ConsertarScript') then
                for _,peneu in pairs(carro.Wheels:GetChildren()) do
                    if peneu.Part.Transparency == 1 and _G.farming then
                        local sensor = getwheel(peneu.Name)
                        repeat wait()
                            lp.Character.HumanoidRootPart.CFrame = CFrame.new(_G.pneu.Position)
                            fire(_G.pneu.PegarRoda)
                        until lp.Backpack:FindFirstChild('Roda') or not _G.farming
                        lp.Backpack.Roda.Parent = lp.Character
                        repeat wait()
                            lp.Character.HumanoidRootPart.CFrame = CFrame.new(carro[sensor].Position)
                            if lp.Backpack:FindFirstChild('Roda') then
                                lp.Backpack.Roda.Parent = lp.Character
                            end
                            fire(carro[sensor]:FindFirstChildOfClass('ProximityPrompt'))
                        until peneu.Part.Transparency == 0 or not _G.farming
                    end
                end
            end
        end
    end
    else
    notify('o seu anta','pega o cargo do mecanico primeiro',5)
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-263.8981018066406, 43.59515380859375, 511.15777587890625)
end
