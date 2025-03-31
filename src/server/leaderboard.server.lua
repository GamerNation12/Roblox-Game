game.Players.PlayerAdded:Connect(function(player)
    -- Create a folder named "leaderstats" in the player
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- Add a stat named "Points" to the leaderboard
    local points = Instance.new("IntValue")
    points.Name = "Points"
    points.Value = 0 -- Initial value
    points.Parent = leaderstats
end)
