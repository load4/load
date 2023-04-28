local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Vida Br", "DarkTheme")
local Tab = Window:NewTab("TabName")
local Section = Tab:NewSection("Farm")
local ws = game:GetService("Workspace")
local lp = game.Players.LocalPlayer

function notify(titulo,texto,duracao)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    	Title = titulo, 
    	Text = texto,
    	Icon = 'rbxassetid://4575171283', 
    	Duration = duracao
    })
end


Section:NewButton("Farm dirigir", "ButtonInfo", function()
    if ws:FindFirstChild(lp.Name..'sCar') then
        notify('oi','tira o seu carro do mapa fazendo favor',13)
        for i=1,13 do
            if not ws:FindFirstChild(lp.Name..'sCar') then
                break
            elseif i==13 and ws:FindFirstChild(lp.Name..'sCar') then
                notify('meh','vc n fez nd ent o farm foi cancelado',13)
                return
            end
            wait(1)
        end
    end
    notify('oi','bota o seu carro no mapa fazendo favor',13)
    for i=1,13 do
        if ws:FindFirstChild(lp.Name..'sCar') then
            break
        elseif i==13 then
            notify('meh','vc n fez nd ent o farm foi cancelado',13)
            return
        end
        wait(1)
    end
    notify('oi','entre no carro e comece a dirigir pfv',13)
    local carro = ws:FindFirstChild(lp.Name..'sCar')
    for i=1,13 do
        if carro.DriveSeat.Occupant == lp.Character.Humanoid then
            break
        elseif i==13 then
            notify('meh','vc n fez nd ent o farm foi cancelado',13)
            return
        end
        wait(1)
    end
    notify('isso','boa mlk',13)
    for i=1,13 do
        if lp.PlayerGui:FindFirstChild("A-Chassis Interface") then
            if lp.PlayerGui["A-Chassis Interface"].IsOn.Value then
                break
            end
        elseif i==13 then
            notify('meh','vc n fez nd ent o farm foi cancelado',13)
            return
        end
        wait(1)
    end
    notify('ok','farming...',8)
    local BV = Instance.new('BodyVelocity')
    local char = lp.Character.HumanoidRootPart
    BV.Parent = char
    BV.velocity = Vector3.new(0, 20000, 0)
    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    for i=1,10 do
        wait(1)
        BV.velocity = Vector3.new(0, 20000, 0)
    end
    BV:Destroy()
    for i, x in pairs(lp.Character:GetDescendants()) do
		if x:IsA("BasePart") and not x.Anchored then
			x.Anchored = true
		end
	end
    notify('aviso','se quiser parar só dar reset',13)
        
end)



Section:NewToggle("Pegar caixas", "ToggleInfo", function(state)
    _G.caixa = state
    if state then
        if lp.Team.Name == 'Lanchonete' then
            ws["Delivery Quest"].ClickPart.CanCollide = false
            if state then
                _G.caixas = 0
                for _,v in pairs(lp.Character.HumanoidRootPart:GetChildren()) do
                    if v.Name == "GetBox" then
                        _G.caixas = _G.caixas+1
                    end
                end
                local added = nil
                added = lp.Character.HumanoidRootPart.ChildAdded:Connect(function(ins)
                    if ins.Name == 'GetBox' then
                        _G.caixas=_G.caixas+1
                        notify('CAIXA FARM','juntando caixas...\nganhos até a venda: '..tostring(_G.caixas*30),3)
                    end
                end)
            while wait() do
                if _G.caixa then
                    repeat wait()
                        ws["Delivery Quest"].ClickPart.CFrame = CFrame.new(lp.Character.Head.Position)
                        fireclickdetector(workspace["Delivery Quest"].ClickPart.ClickDetector)
                    until ws["Delivery Quest"].Taken.Value == 'false' or not _G.caixa
                    else 
                        if added then
                            _G.caixas=0
                            added:Disconnect()
                        end
                        break
                    end
                end
            end
            else
            notify('opa bother','pega o trampo da lanchonete primeiro 👍',10)
        end   
    end
end)

Section:NewButton("Vender caixas", "ButtonInfo", function()
    _G.caixas=0
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(ws["Delivery Quest"]["Delivery Point"].Give.Position)
end)














