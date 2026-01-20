
--[[
 LyraUI Core Engine
 Full rewrite – Dark / Glass / Admin Panel
 Author: Generated for user
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local LyraUI = {}
LyraUI.__index = LyraUI

-- THEME
LyraUI.Theme = {
    Background = Color3.fromRGB(12,12,16),
    Panel = Color3.fromRGB(18,18,24),
    Stroke = Color3.fromRGB(45,45,60),
    Accent = Color3.fromRGB(120,95,255),
    Text = Color3.fromRGB(235,235,240),
    SubText = Color3.fromRGB(170,170,180),
    Transparency = 0.08,
    Blur = true,
}

-- CREATE ROOT GUI
function LyraUI:Create()
    local gui = Instance.new("ScreenGui")
    gui.Name = "LyraUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    if self.Theme.Blur then
        local blur = Instance.new("BlurEffect")
        blur.Size = 18
        blur.Parent = game:GetService("Lighting")
    end

    self.Gui = gui
    return self
end

-- WINDOW
function LyraUI:Window(title)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(720,480)
    frame.Position = UDim2.fromScale(0.5,0.5)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = self.Theme.Background
    frame.BackgroundTransparency = self.Theme.Transparency
    frame.Parent = self.Gui
    frame.Name = "MainWindow"

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,16)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = self.Theme.Stroke
    stroke.Thickness = 1

    -- TOPBAR
    local top = Instance.new("Frame", frame)
    top.Size = UDim2.new(1,0,0,46)
    top.BackgroundTransparency = 1

    local titleLabel = Instance.new("TextLabel", top)
    titleLabel.Text = title or "Lyra Hub Admin"
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.fromOffset(16,0)
    titleLabel.Size = UDim2.fromScale(1,1)
    titleLabel.TextXAlignment = Left

    self.WindowFrame = frame
    return frame
end

-- SIDEBAR
function LyraUI:Sidebar()
    local bar = Instance.new("Frame", self.WindowFrame)
    bar.Size = UDim2.fromOffset(220,434)
    bar.Position = UDim2.fromOffset(0,46)
    bar.BackgroundColor3 = self.Theme.Panel
    bar.BackgroundTransparency = self.Theme.Transparency

    local corner = Instance.new("UICorner", bar)
    corner.CornerRadius = UDim.new(0,14)

    self.SidebarFrame = bar
    return bar
end

-- TAB BUTTON
function LyraUI:Tab(name)
    local btn = Instance.new("TextButton", self.SidebarFrame)
    btn.Size = UDim2.new(1,-20,0,42)
    btn.Position = UDim2.fromOffset(10,10 + (#self.SidebarFrame:GetChildren()*46))
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = self.Theme.Text
    btn.BackgroundColor3 = self.Theme.Background
    btn.BackgroundTransparency = 0.2

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,10)

    return btn
end

-- COMMAND LIST ITEM
function LyraUI:Command(text)
    local lbl = Instance.new("TextLabel", self.WindowFrame)
    lbl.Size = UDim2.new(1,-260,0,32)
    lbl.Position = UDim2.fromOffset(240,60 + math.random(0,300))
    lbl.Text = text
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 13
    lbl.TextColor3 = self.Theme.SubText
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Left
    return lbl
end

return LyraUI
