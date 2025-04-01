local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local COIN_TEMPLATE_NAME = "CoinTemplate" -- Name of the coin template in ServerStorage
local SPAWN_INTERVAL = 10 -- Time in seconds between spawns
local MAX_COINS = 20 -- Maximum number of coins allowed in the game at once
local SPAWN_AREA = { -- Define the spawn area boundaries
    min = Vector3.new(-100, 0, -100),
    max = Vector3.new(100, 0, 100)
}

local activeCoins = {}

local function getRandomPosition()
    local grassPlate = Workspace:FindFirstChild("GrassPlate")
    if not grassPlate then
        warn("GrassPlate not found in Workspace!")
        return SPAWN_AREA.min -- Default to a safe position if GrassPlate is missing
    end

    local size = grassPlate.Size
    local position = grassPlate.Position

    local x = math.random(position.X - size.X / 2, position.X + size.X / 2)
    local z = math.random(position.Z - size.Z / 2, position.Z + size.Z / 2)
    local y = position.Y + size.Y / 2 -- Ensure the coin spawns on top of the GrassPlate

    return Vector3.new(x, y, z)
end

local function spawnCoin()
    if #activeCoins >= MAX_COINS then
        return
    end

    local coinTemplate = ServerStorage:FindFirstChild(COIN_TEMPLATE_NAME)
    if not coinTemplate then
        warn("Coin template not found in ServerStorage!")
        return
    end

    local newCoin = coinTemplate:Clone()
    newCoin.CFrame = CFrame.new(getRandomPosition()) -- Use CFrame to set position

    -- Add texture to the coin
    local decal = Instance.new("Decal")
    decal.Texture = "rbxassetid://105850246782299" -- Updated texture ID
    decal.Face = Enum.NormalId.Top
    decal.Parent = newCoin

    newCoin.Parent = Workspace
    table.insert(activeCoins, newCoin)

    newCoin.Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            -- Add coin collection logic here (e.g., increase player's score)
            print(player.Name .. " collected a coin!")
            newCoin:Destroy()
            table.remove(activeCoins, table.find(activeCoins, newCoin))
        end
    end)
end

while RunService.Heartbeat:Wait() do
    spawnCoin()
    wait(SPAWN_INTERVAL)
end
