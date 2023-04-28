local lp = game.Players.LocalPlayer
local pegar = game:GetService("Workspace")["Sistema de entregador"].ClickPart.ProximityPrompt
local entrega = game:GetService("Workspace")["Sistema de entregador"].TargetPart
_G.farming = true

game:GetService("RunService").Stepped:Connect(function()
    if game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end)


local antitp
antitp = hookmetamethod(game,"__namecall",function(...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "Raycast" then
        return
    end
    return antitp(...)
end)



workspace.CurrentCamera.CameraSubject = pegar.Parent

local function fire(Obj)
    Obj.HoldDuration = 0
    Obj:InputHoldBegin()
    Obj:InputHoldEnd()
end

task.spawn(function()
    while wait(8) and _G.farming do
        fire(pegar)
    end
end)

while wait() and _G.farming do
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(pegar.Parent.Position+Vector3.new(0,-10,0))
    lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    entrega.CFrame = CFrame.new(lp.Character.HumanoidRootPart.Position)
end
