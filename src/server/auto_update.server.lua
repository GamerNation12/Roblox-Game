local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")

local UPDATE_CHECK_INTERVAL = 60 -- Check for updates every 60 seconds
local UPDATE_URL = "https://your-update-server.com/check" -- Replace with your update server URL

local function checkForUpdates()
    local success, response = pcall(function()
        return HttpService:GetAsync(UPDATE_URL)
    end)

    if success then
        local updateInfo = HttpService:JSONDecode(response)
        if updateInfo and updateInfo.updateAvailable then
            print("Update available. Reloading scripts...")
            reloadScripts()
        end
    else
        warn("Failed to check for updates:", response)
    end
end

local function reloadScripts()
    for _, script in ipairs(ServerScriptService:GetDescendants()) do
        if script:IsA("Script") or script:IsA("ModuleScript") then
            script.Disabled = true
            script.Disabled = false
        end
    end
    print("Scripts reloaded successfully.")
end

while true do
    checkForUpdates()
    wait(UPDATE_CHECK_INTERVAL)
end
