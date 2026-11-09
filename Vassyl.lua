--[[
    Script Name: vassyl (Rockin' Stride)
    Target: Delta Executor Mobile & Roblox Evade
]]--

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Hapus GUI lama jika script dieksekusi ulang
local existingGui = player:WaitForChild("PlayerGui"):FindFirstChild("VassylEmoteGUI")
if existingGui then
    existingGui:Destroy()
end

-- Data Emote Tunggal
local EMOTE_DATA = {
    AnimId = "rbxassetid://12686575749",
    IsLooped = true
}

local currentTrack = nil

local function stopEmote()
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
end

local function playEmote()
    local char = player.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
    
    if not animator then 
        warn("Animator tidak ditemukan!")
        return 
    end

    stopEmote()

    local anim = Instance.new("Animation")
    anim.AnimationId = EMOTE_DATA.AnimId
    
    local success, track = pcall(function()
        return animator:LoadAnimation(anim)
    end)

    if success and track then
        currentTrack = track
        track.Priority = Enum.AnimationPriority.Action4
        track.Looped = EMOTE_DATA.IsLooped
        track:Play()

        track.Stopped:Connect(function()
            if currentTrack == track then
                currentTrack = nil
            end
        end)
    else
        warn("Gagal memuat animasi Rockin' Stride")
    end
end

-- ==========================================
-- STRUKTUR GUI MINIMALIS (MOBILE FRIENDLY)
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VassylEmoteGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 160, 0, 115)
mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "vassyl"
title.TextSize = 12
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

local function createButton(name, posY, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 26)
    btn.Position = UDim2.new(0, 6, 0, posY)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSans
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- Tombol Play Rockin' Stride
createButton("rockin' stride", 35, Color3.fromRGB(35, 35, 35), function()
    playEmote()
end)

-- Tombol Stop Emote
createButton("stop emote", 72, Color3.fromRGB(180, 40, 40), function()
    stopEmote()
end)

print("vassyl: loaded successfully.")
