local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Teddy Farm", "DarkTheme")
local Tab = Window:NewTab("Florianópolis RP")
local Section = Tab:NewSection("Farm")
local lp = game.Players.LocalPlayer
local pegar = game:GetService("Workspace").Workspace.Jobs.GarbagemanJob.GetTrash.GetTrashPart
local entregar = game:GetService("Workspace").Workspace.Jobs.GarbagemanJob.DepositTrash.DepositTrashPart
pegar.Prompt.HoldDuration = 0
entregar.Prompt.HoldDuration = 0

_G.speed1 = 1
_G.power = 200

local function fire(prox)
    prox:InputHoldBegin()
    prox:InputHoldEnd()
end




Section:NewSlider("Seg. de espera", "SliderInfo", 30, 1, function(s)
    _G.speed1 = s
end)

Section:NewSlider("Quant. de caixas", "SliderInfo", 10000, 200, function(s) 
    _G.power = s
end)

Section:NewToggle("Farm Lixeiro", "ToggleInfo", function(state)
    _G.farming = state
    
    while wait() do
        if _G.farming then
            local caixas = _G.power
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(pegar.Position)
            wait(_G.speed1)
            for i=1,caixas do
                fire(pegar.Prompt)
            end
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(entregar.Position)
            wait(_G.speed1)
            for i=1,caixas do
                fire(entregar.Prompt)
            end
            wait(_G.speed1)
            else break
        end
    end
end)
