local entrega = workspace["Mapa(Spot)"].Lixeiras.Lixeira.EntregaLixo
local lp = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local lixos = {}
local inventario = {}
_G.farming = true

local oldnames = {
    [1] = 'PingSync',
    [2] = 'Notify',
    [3] = 'SendData',
    [4] = 'RequestData',
    [5] = 'InventarioAdd',
    [6] = 'MensagemZAP',
    [7] = 'ExploitAction',
    [8] = 'Interact',
    [9] = 'CaixaEletronico',
    [10] = 'EmpregosHandler',
    [11] = 'InventarioAction',
    [12] = 'Tilt',
    [13] = 'ToolAction',
    [14] = 'buyClothing',
    [15] = 'Sangue',
    [16] = 'Moveis',
    [17] = 'BCA',
}

for i,v in next, game:GetService("ReplicatedStorage").Resources.Network:GetChildren() do
    v.Name = oldnames[i]
end

if _G.returningNameIndex == nil then 
    local RAWMETA = getrawmetatable(game)
    local INDX = RAWMETA.__newindex
    local INS_TBL = {
        ['RemoteFunction'] = true,
        ['RemoteEvent'] = true,
        ['Players'] = true,
        ['ReplicatedStorage'] = true,
    }
    setreadonly(RAWMETA, false)
    RAWMETA.__newindex = function(old, __type, new)
        if INS_TBL[old.ClassName] and __type == 'Name' then
            return
        end
        return INDX(old, __type, new)
    end
    _G.returningNameIndex = true
end

function notify(titulo,texto,duracao)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = titulo, 
        Text = texto,
        Icon = 'rbxassetid://4575171283', 
        Duration = duracao
    })
end

function inv(number) 
    if number == 1 then
        return "One"
    elseif number == 2 then
        return "Two"
    elseif number == 3 then
        return "Three"
    elseif number == 4 then
        return "Four"
    elseif number == 5 then
        return "Five"
    elseif number == 6 then
        return "Six" 
    end
end


for i, v in pairs(workspace["Mapa(Spot)"].Lixos:GetChildren()) do
    if v:IsA('MeshPart') then
        table.insert(lixos, v)
    end
end

for _,v in pairs(lp.PlayerGui.Main.HUD.Backpack:GetChildren()) do
    if tonumber(v.Name) ~= nil and v.icon.Image ~= 'rbxassetid://7005450026' then
        notify('opa','certifique-se de que seu inventario esta limpo, sem nenhum item',9)
        return
    end
        
    if v.Name == 'Livre' then
        table.insert(inventario,v)
    end
end

function checkinv()
    for i=1,#inventario do
        if tonumber(inventario[i].Name) then
            lp.PlayerScripts.Client.Signals.equip:Fire(inv(i))
            wait(.1)
            rs.Resources.Network.Interact:FireServer(entrega)
        end
    end
end
    

game:GetService("ReplicatedStorage").Resources.Network.EmpregosHandler:InvokeServer("Lixeiro", "Trabalhar")
while wait() do
    if _G.farming then
        for _,v in pairs(lixos) do
            if v.Transparency == 0 then
                wait(.1)
                rs.Resources.Network.Interact:FireServer(v)
                checkinv()
            end
            checkinv()
        end
        else break
    end
end
