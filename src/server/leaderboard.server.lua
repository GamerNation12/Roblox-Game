game.Players.PlayerAdded:Connect(function(player)
    local success, err = pcall(function()
        local leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player

        local points = Instance.new("IntValue")
        points.Name = "Points"
        points.Value = 0
        points.Parent = leaderstats
    end)

    if not success then
        warn("Failed to create leaderboard for player:", player.Name, "Error:", err)
    end
end)
