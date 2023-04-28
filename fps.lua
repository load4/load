
local ws = game:GetService("Workspace")
local rs = game:GetService("RunService")
local lp = game.Players.localPlayer
local pos = Vector3.new(0,-9,0)
local entrega = ws.entregardinheiro2
entrega.Size = Vector3.new(2,2,2)
entrega.CanCollide = false



local Noclipping = nil
local function NoclipLoop()
    if game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end
Noclipping = rs.Stepped:Connect(NoclipLoop)


    
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,10,0)
    

local function fire(Obj)
    Obj.HoldDuration = 0
    Obj:InputHoldBegin()
    wait()
    Obj:InputHoldEnd()
end
    
function breakvelocity()
    lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    lp.Character.Torso.Velocity = Vector3.new(0,0,0)    
end

local function touch(Part, ToTouch)
    local oldpos = ToTouch.Position
    ToTouch.CFrame = CFrame.new(Part.Position)
    task.wait()
    ToTouch.CFrame = CFrame.new(oldpos)
end

function view(obj)
    ws.CurrentCamera.CameraSubject = obj
end


while wait() do
    if ws.Itau.porta.Transparency == 0 or ws.Itau.segundoportao.Transparency == 0 then
        repeat wait()
            breakvelocity()
            view(ws.Itau.porta)
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(ws.Itau.porta.Position+pos)
            fire(ws.Itau.porta:FindFirstChildOfClass('ProximityPrompt'))
        until ws.Itau.porta.Transparency == 1
        if ws.Itau.segundoportao.Transparency == 0 then
            repeat wait()
                breakvelocity()
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(ws.Itau.segundoportao.Position+pos)
                fire(ws.Itau.segundoportao.ProximityPrompt)
                view(ws.Itau.segundoportao)
            until ws.Itau.segundoportao.Transparency == 1
        end
        else

        breakvelocity()
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(ws.BancoDinheiro.SacoDeDinheiroPrincipal.Bag.Position+pos)
        fire(ws.BancoDinheiro.SacoDeDinheiroPrincipal.Bag.Proximit)
        touch(lp.Character.HumanoidRootPart, entrega)
        view(ws.BancoDinheiro.SacoDeDinheiroPrincipal.Bag)
    end
end





    
