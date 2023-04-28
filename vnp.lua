local lp = game.Players.LocalPlayer
local pos = Vector3.new(0,-5,1.3)
local get = game:GetService("Workspace").IFOOD.Init
local savepos = lp.Character.HumanoidRootPart.Position
local vim = game:GetService'VirtualInputManager'
local removernick = true
_G.farm = true

function click(x)
    vim:SendMouseButtonEvent(x.AbsolutePosition.X+x.AbsoluteSize.X/2,x.AbsolutePosition.Y+50,0,true,x,1)
    wait(.1)
    vim:SendMouseButtonEvent(x.AbsolutePosition.X+x.AbsoluteSize.X/2,x.AbsolutePosition.Y+50,0,false,x,1)
end

game:GetService("RunService").Stepped:Connect(function()
    if lp.Character ~= nil then
        for _, child in pairs(lp.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true  then
                child.CanCollide = false
            end
        end
    end
end)

function breakvelocity()
    lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    lp.Character.Torso.Velocity = Vector3.new(0,0,0)
end


if removernick and lp.Character.Head:FindFirstChild('bill') then
    lp.Character.Head:FindFirstChild('bill'):Destroy()
end

task.spawn(function()
    lp:WaitForChild('PlayerGui'):WaitForChild('IFOOD'):WaitForChild('Ifood'):WaitForChild('FrameMenu'):WaitForChild('Descricao'):GetPropertyChangedSignal("Text"):Connect(function()
        wait(1.5)
        click(lp.PlayerGui.IFOOD.Ifood.FrameMenu.Botoes.Pegar)
    end)
end)


while wait() do
    if _G.farm then
        repeat wait()
            breakvelocity()
            fireproximityprompt(game:GetService("Workspace").IFOOD.Init.IFoodPrompt)
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(get.Position+pos)
        until lp.Character:FindFirstChild('Mochila') or not _G.farm
        for _,v in pairs(game:GetService("Workspace").IFOOD["Locais_Entrega"]:GetDescendants()) do
            if v:IsA('TouchTransmitter') and _G.farm then
                local hitbox = v.Parent
                workspace.CurrentCamera.CameraSubject = hitbox
                local dist = 13
                repeat wait()
                breakvelocity()
                dist=dist-0.1
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(hitbox.Position+Vector3.new(0,-dist,0))
                until not lp.Character:FindFirstChild('Mochila') or not _G.farm
            end
        end
        else
        for i=1,10 do
            wait()
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(savepos)
        end
        break
    end
end
