local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local Players = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")
local RunService = game:GetService("RunService")

-- Debugging for ModuleLoader
local ModuleLoader = ReplicatedStorage:FindFirstChild("ModuleLoader")
if not ModuleLoader thenng in Studio environment.")
    error("[DEBUG] ModuleLoader is missing from ReplicatedStorage! Please ensure it is correctly placed.")
elseprint("[DEBUG] Running in Live environment.")
    print("[DEBUG] ModuleLoader found in ReplicatedStorage.")
    ModuleLoader = require(ModuleLoader)
endDebugging for ModuleLoader
local ModuleLoader = ReplicatedStorage:FindFirstChild("ModuleLoader")
-- Debugging for CoinModule
local CoinModule = ServerStorage:FindFirstChild("CoinModule")rage! Please ensure it is correctly placed.")
else
    print("[DEBUG] ModuleLoader found in ReplicatedStorage.")
    ModuleLoader = require(ModuleLoader)
end

-- Debugging for CoinModule
local CoinModule = ServerStorage:FindFirstChild("CoinModule")
if not CoinModule then
    warn("[DEBUG] CoinModule is missing from ServerStorage! Please ensure it is correctly placed.")
else
    print("[DEBUG] CoinModule found in ServerStorage.")
end

-- Debugging for GrassPlate
local GrassPlate = workspace:FindFirstChild("GrassPlate")
if not GrassPlate then
    warn("[DEBUG] GrassPlate is missing from Workspace! Please ensure it is correctly placed.")
else
    print("[DEBUG] GrassPlate found in Workspace.")
end

local BADGE_ID = 4169582939766568 -- Replace with your actual badge ID

local function enableVoiceChatForPlayer(player)
    if RunService:IsStudio() then
        print("[DEBUG] Voice chat check skipped in Studio for player:", player.Name)
        return
    end

    local success, isEnabled = pcall(function()
        return VoiceChatService:IsVoiceEnabledForUserIdAsync(player.UserId)
    end)

    if success then
        if isEnabled then
            print("[DEBUG] Voice chat enabled for player:", player.Name)
        else
            warn("[DEBUG] Player does not meet the requirements for voice chat:", player.Name)
        end
    else
        warn("[DEBUG] Failed to check voice chat eligibility for player:", player.Name)
    end
end

local function awardBadge(player)
    if RunService:IsStudio() then
        print("[DEBUG] Badge awarding skipped in Studio for player:", player.Name)
        return
    end

    print("[DEBUG] Attempting to award badge with ID:", BADGE_ID, "to player:", player.Name)

    local success, alreadyHasBadge = pcall(function()
        return BadgeService:UserHasBadgeAsync(player.UserId, BADGE_ID)
    end)

    if success then
        if alreadyHasBadge then
            print("[DEBUG] Player already owns the badge:", player.Name)
            return
        end
    else
        warn("[DEBUG] Failed to check if player owns the badge:", player.Name)
        return
    end

    local awardSuccess, result = pcall(function()
        return BadgeService:AwardBadge(player.UserId, BADGE_ID)
    end)

    if awardSuccess then
        if result then
            print("[DEBUG] Badge successfully awarded to player:", player.Name)
        else
            warn("[DEBUG] Badge could not be awarded to player:", player.Name)
        end
    else
        warn("[DEBUG] Failed to award badge to player:", player.Name, "Error:", result)
    end
end

Players.PlayerAdded:Connect(function(player)
    enableVoiceChatForPlayer(player)
    awardBadge(player)
end)

if ModuleLoader then
    ModuleLoader()
end
