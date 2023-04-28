local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Teddy Menu", "DarkTheme")
local Tab = Window:NewTab("Ilha Bela Roleplay")
local Section = Tab:NewSection("Farm")
local ws = game:GetService("Workspace")
local lp = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local char = game.Players.LocalPlayer.Character
local pizza = ws.Construcoes.Pizzaria.ifoodplace.Pizza3
_G.speed1 = 40

function notify(titulo,texto,duracao)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    	Title = titulo, 
    	Text = texto,
    	Icon = 'rbxassetid://12166869331', 
    	Duration = duracao
    })
end


function breakvelocity()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
end

local function fire(Obj)
    Obj.HoldDuration = 0
    Obj:InputHoldBegin()
    wait()
    Obj:InputHoldEnd()
end

local Noclipping = nil
local function NoclipLoop()
    if game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                child.CanCollide = false
            end
        end
    end
end

function tweendistance(pos,vel,dist)
    local chao = Vector3.new(0,dist,0)
    local newpos = pos+chao
    local New_CFrame = CFrame.new(newpos)
    local char = lp.Character.HumanoidRootPart
    local mag = ((char.Position+chao)-newpos).Magnitude
    local ti = TweenInfo.new(mag/vel, Enum.EasingStyle.Linear)
    local tp = {CFrame = New_CFrame}
    local tween = ts:Create(char, ti, tp)
    tween:Play()
    return tween
 end

function entregar()
    for _,v in pairs(wsConstrucoes.Pizzaria.OrderCharSpawns:GetChildren()) do
        if v:FindFirstChild('OrderChar') then
            repeat wait()
                local tween = tweendistance(v.OrderChar.Position,_G.speed1,-8)
                tween.Completed:Wait()
                v:FindFirstChild('OrderChar') 
                fire(v.OrderChar.ProximityPrompt)
            until not v:FindFirstChild('OrderChar') or not _G.farminglixo
        end
    end
end


local function caminhaoMaisPerto()
    local caminhao, dist = nil, 9999999
    for _,v in pairs(ws.CarrosSpawnados:GetChildren()) do
        if v.Name == 'Lixeiro' then
            local m =(lp.Character.HumanoidRootPart.Position-v.Body.Proximitikk.Position).magnitude
            if(m<dist)then
                dist = m
                caminhao = v
            end
        end
    end
    return caminhao
end



local avisodado = true
Section:NewSlider("Tween Speed", "Velocidade até o destino", 500, 40, function(s) 
    if avisodado then
        notify('aviso','voce pode ser pego pelo anticheat se for mt alto',10)
        avisodado = false
    end
    _G.speed1 = s
end)

Section:NewToggle("Farm Lixeiro", "ToggleInfo", function(state)
    _G.farminglixo = state
    if state then
        if lp.Emprego.Value == 'Lixeiro' then
            game:GetService("ReplicatedStorage").DealershipEvents.SpawnCar:FireServer("Lixeiro","GaragemLIXEIRO")
            Noclipping = RunService.Stepped:Connect(NoclipLoop)
            while wait() do
                if _G.farminglixo then
                    for _,v in pairs(ws.Construcoes.SistemaGari.Lixos:GetChildren()) do
                        if v.Transparency == 0 and _G.farminglixo then
                            repeat wait()
                                lp.Character.Humanoid.Sit = false
                                if v.Transparency==1 then break end
                                local a = tweendistance(v.Position,_G.speed1,-4)
                                a.Completed:Wait()
                                fire(v.ProximityPrompt)
                            until lp.Character:FindFirstChild('Lixo') or not _G.farminglixo
                            
                            repeat wait()
                                lp.Character.Humanoid.Sit = false
                                local caminhao = caminhaoMaisPerto()
                                
                                if (lp.Character.HumanoidRootPart.Position-caminhao.Body.Proximitikk.Position).Magnitude < 6 then
                                    lp.Character.HumanoidRootPart.CFrame = caminhao.Body.Proximitikk.CFrame + caminhao.Body.Proximitikk.CFrame.LookVector * 3
                                    else
                                    tweendistance(caminhao.Body.Proximitikk.Position,_G.speed1,-4)
                                end
                                fire(caminhao.Body.Proximitikk.ProximityPrompt)
                            until not lp.Character:FindFirstChild('Lixo') or not _G.farminglixo
                            
                            lp.Character.HumanoidRootPart.CFrame = CFrame.new(lp.Character.HumanoidRootPart.Position+Vector3.new(0,-8,0))
                        end
                    end
                    else
                    local pos = lp.Character.HumanoidRootPart.Position+Vector3.new(0,12,0)
                    for i=1,50 do
                        wait()
                        lp.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                    end
                    if Noclipping then
                        Noclipping:Disconnect()
                    end
                    break
                end
            end
            else 
            notify('irmao','pega o trampo do lixeiro primeiro',8)
        end
    end
end)

Section:NewToggle("Farm Deliveryman", "ToggleInfo", function(state)
    _G.farmingdelivery = state
    if state then
        if lp.Emprego.Value == 'Entregador' then
            while wait() do
                if _G.farmingdelivery then
                    local a = tweendistance(pizza.Position,_G.speed1,-8)
                    a.Completed:Wait()
                    repeat wait()
                        lp.Character.HumanoidRootPart.CFrame = CFrame.new(pizza.Position+Vector3.new(0,-9,0))
                        fire(pizza:FindFirstChildOfClass('ProximityPrompt'))
                    until lp.Character.UpperTorso:FindFirstChild('PizzaTemplate') or not _G.farmingdelivery
                        entregar()
                    else
                    local pos = lp.Character.HumanoidRootPart.Position+Vector3.new(0,12,0)
                    for i=1,50 do
                        wait()
                        lp.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                    end
                    break 
                end
            end
        else
        notify('irmao','pega o trampo do deliveryman/entregador primeiro',8)
        end
    end
end)

Section:NewLabel("Ative enquanto estiver farmando")

Section:NewToggle("Break velocity", "impede de você cair no void", function(state)
    _G.breaking = state
    if state then
        while wait() do
            if _G.breaking then
                breakvelocity()
                else break
            end
        end
    end
end)







