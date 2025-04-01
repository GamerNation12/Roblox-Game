local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local CoinModule = require(ServerStorage:WaitForChild("CoinModule")) -- Require the new module
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

local function enhanceGrassAppearance()
    local grassPlate = Workspace:FindFirstChild("GrassPlate")
    if not grassPlate then
        warn("GrassPlate not found in Workspace!")
        return
    end

    -- Add SurfaceAppearance for better visuals
    local surfaceAppearance = Instance.new("SurfaceAppearance")
    surfaceAppearance.ColorMap = "rbxassetid://12345678" -- Replace with actual asset ID for grass texture
    surfaceAppearance.NormalMap = "rbxassetid://87654321" -- Replace with actual asset ID for normal map
    surfaceAppearance.RoughnessMap = "rbxassetid://23456789" -- Replace with actual asset ID for roughness map
    surfaceAppearance.Parent = grassPlate

    -- Modify material properties
    grassPlate.Material = Enum.Material.Grass
    grassPlate.Color = Color3.new(0.3, 0.8, 0.3) -- Lush green color

    -- Add a texture for more detail
    local texture = Instance.new("Texture")
    texture.Texture = "rbxassetid://34567890" -- Replace with actual asset ID for grass texture
    texture.StudsPerTileU = 10 -- Adjust tiling for realism
    texture.StudsPerTileV = 10
    texture.Parent = grassPlate
end

-- Call the function to enhance grass appearance
enhanceGrassAppearance()

local function spawnCoin()
    if #activeCoins >= MAX_COINS then
        return
    end

    local position = getRandomPosition()
    if not position then
        warn("Failed to get a valid spawn position!")
        return
    end

    local newCoin = CoinModule.createCoin(position) -- Use the module to create a coin
    if not newCoin then
        warn("Failed to create a coin!")
        return
    end

    -- Ensure the coin is visible and properly configured
    newCoin.Material = Enum.Material.Neon
    newCoin.Color = Color3.new(1, 0.85, 0) -- Gold color
    newCoin.Transparency = 0 -- Ensure the coin is not invisible

    local sparkles = Instance.new("Sparkles")
    sparkles.SparkleColor = Color3.new(1, 1, 0.5) -- Bright yellow sparkles
    sparkles.Parent = newCoin

    local light = Instance.new("PointLight")
    light.Color = Color3.new(1, 0.85, 0) -- Gold light
    light.Brightness = 5 -- Increased brightness for better visibility
    light.Range = 15 -- Extended range for a glowing effect
    light.Shadows = true -- Enable shadows for a more realistic effect
    light.Parent = newCoin

    -- Add a glow effect using SurfaceLight
    local glow = Instance.new("SurfaceLight")
    glow.Color = Color3.new(1, 0.85, 0) -- Gold glow
    glow.Brightness = 2
    glow.Angle = 120
    glow.Face = Enum.NormalId.Top
    glow.Parent = newCoin

    newCoin.Parent = Workspace
    table.insert(activeCoins, newCoin)

    newCoin.Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            -- Add coin collection logic here (e.g., increase player's score)
            print(player.Name .. " collected a coin!")
            newCoin:Destroy()
            table.remove(activeCoins, table.find(activeCoins, newCoin))
        elseif hit:IsA("BasePart") and hit.CFrame then -- Ensure the object has a CFrame property
            print("Touched by a BasePart with CFrame")
        else
            warn("Touched by an object without a CFrame property")
        end
    end)
end

while RunService.Heartbeat:Wait() do
    spawnCoin()
    wait(SPAWN_INTERVAL)
end
