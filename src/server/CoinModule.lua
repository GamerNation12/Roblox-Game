local ServerStorage = game:GetService("ServerStorage")

local COIN_TEMPLATE_NAME = "CoinTemplate" -- Name of the coin template in ServerStorage

local CoinModule = {}

function CoinModule.createCoin(position)
    local coinTemplate = ServerStorage:FindFirstChild(COIN_TEMPLATE_NAME)
    if not coinTemplate then
        warn("Coin template not found in ServerStorage!")
        return nil
    end

    local newCoin = coinTemplate:Clone()
    newCoin.CFrame = CFrame.new(position) -- Use CFrame to set position

    -- Add texture to the coin
    local decal = Instance.new("Decal")
    decal.Texture = "rbxassetid://105850246782299" -- Updated texture ID
    decal.Face = Enum.NormalId.Top
    decal.Parent = newCoin

    return newCoin
end

return CoinModule
