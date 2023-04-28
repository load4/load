_G.farming = true
local TempoDeEspera = 200
local pos = Vector3.new(0,-7,0)
local lp = game.Players.LocalPlayer
local savepos = lp.Character.HumanoidRootPart.Position
local pegar = game:GetService("Workspace").Caixas.Pegar
local entregar = game:GetService("Workspace").Caixas.Entregar
local n=0

function view(obj)
workspace.CurrentCamera.CameraSubject = obj
end


task.spawn(function()
    local rs = game:GetService("RunService")
    while true do
        local t0 = tick()
        rs.Heartbeat:Wait()
        lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        if not _G.farming then break end
        repeat until (t0 + 1/60) < tick()
    end
end)

local Noclipping = nil
Noclipping = game:GetService("RunService").Stepped:Connect(function()
    if game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end)


local function fire(prox)
    prox.HoldDuration = 0
    prox:InputHoldBegin()
    prox:InputHoldEnd()
end


while wait() do
    if _G.farming then 
        view(pegar)
        repeat wait()
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(pegar.Position+pos)
            fire(pegar.ProximityPrompt)
        until lp.Character:FindFirstChild('Caixa') or not _G.farming;
        repeat wait()
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(pegar.Position+pos+Vector3.new(0,-20,0))
            n=n+1
        until n>=TempoDeEspera or not _G.farming;n=0
        view(entregar)
        if _G.farming then
            repeat wait()
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(entregar.Position+Vector3.new(0,-7,0))
                fire(entregar.ProximityPrompt)
            until not lp.Character:FindFirstChild('Caixa') or not _G.farming
        end
        else
            for i=1,50 do
                if not _G.farming then
                    wait()
                    lp.Character.HumanoidRootPart.CFrame = CFrame.new(savepos)
                end
                if Noclipping then
                    Noclipping:Disconnect()
                end
            end
        break
    end
end
