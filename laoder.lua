

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Get current game's PlaceId
local currentGameId = game.PlaceId

-- Game IDs and their corresponding script URLs
local gameScripts = {
    -- Special games
    [17298589168] = "https://raw.githubusercontent.com/GeceUstasi/auracraftinfmoney/refs/heads/main/infmoney.lua", -- AuraCraft Infinite Money
    [128120317905952] = "https://raw.githubusercontent.com/GeceUstasi/clicktoaurafarm/refs/heads/main/load.lua", -- Build Mode
    [126884695634066] = "https://raw.githubusercontent.com/GeceUstasi/growagarden/refs/heads/main/laod.lua", -- Grow a Garden
    [118771036645714] = "https://raw.githubusercontent.com/GeceUstasi/trolltower/refs/heads/main/load.lua"
}



-- Notification function
local function notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

-- Copy Discord to clipboard function
local function copyDiscord()
    local discordLink = "https://discord.gg/9CeE77Bs4U" -- Change this to your Discord invite
    
    local success = pcall(function()
        setclipboard(discordLink)
    end)
    
    if success then
        notify("Discord Copied!", "Discord invite copied to clipboard!", 3)
        print("Discord copied: " .. discordLink)
    else
        notify("Discord Link", "Manual copy: " .. discordLink, 5)
        print("Discord (manual copy): " .. discordLink)
    end
end

-- Script loading function
local function loadScript(url, gameName)
    local success, result = pcall(function()
        local scriptCode = game:HttpGet(url)
        return scriptCode
    end)
    
    if success then
        notify("Script Loaded", gameName and ("Script loaded for: " .. gameName) or "Universal script loaded", 3)
        
        local executeSuccess, executeError = pcall(function()
            loadstring(result)()
        end)
        
        if not executeSuccess then
            notify("Error", "Error executing script: " .. tostring(executeError), 5)
        end
    else
        notify("Connection Error", "Failed to download script. Check your internet connection.", 5)
    end
end

-- Main function
local function main()
    notify("VoidX Loader", "Checking GameID...", 2)
    
    wait(1)
    
    -- Check if there's a custom script for current game
    if gameScripts[currentGameId] then
        -- Try to get game name
        local gameName = "Unknown Game"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(currentGameId).Name
        end)
        
        notify("Game Detected", "Game: " .. gameName .. "\nID: " .. currentGameId, 3)
        wait(2)
        notify("Made By GeceUsta", "Have Fun!", 3)
        copyDiscord()
        wait(2)
        loadScript(gameScripts[currentGameId], gameName)
    else
        -- No script found for this game
        notify("No Script Found", "This game is not supported by VoidX Loader.\nGameID: " .. currentGameId, 5)
        notify("Made By GeceUsta", "Add this game to get a custom script!", 4)
        copyDiscord()
        
        -- Debug info for unsupported game
        print("=== UNSUPPORTED GAME ===")
        print("GameID: " .. currentGameId)
        print("Please contact GeceUsta to add this game")
        print("========================")
    end
end

-- Start the script
main()


print("=== VOIDX SCRIPT LOADER DEBUG ===")
print("Current Game ID: " .. currentGameId)
print("Player: " .. Players.LocalPlayer.Name)
print("Made by GeceUsta")
print("===================================")
