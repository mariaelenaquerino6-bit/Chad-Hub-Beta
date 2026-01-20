--[[ 
 Lyra Hub Admin UI Engine
 Full functional core
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local LyraUI = {}
LyraUI.__index = LyraUI

-- THEME
local Theme = {
    BG = Color3.fromRGB(15,15,20),
    Panel = Color3.fromRGB(22,22,28),
    Stroke = Color3.fromRGB(45,45,60),
    Accent = Color3.fromRGB(140,120,255),
    Text = Color3.fromRGB(235,235,240),
    Sub = Color3.fromRGB(160,160,170),
    Transparency = 0.05
}

-- MAIN
function LyraUI.new()
    local self = setmetatable({}, LyraUI)

    local gui = Instance.new("ScreenGui")
    gui.Name = "LyraHub"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- BLUR
    local blur = Instance.new("BlurEffect")
    blur.Size = 18
    blur.Parent = game:GetService("Lighting")

    -- WINDOW
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.fromOffset(720,480)
    main.Position = UDim2.fromScale(0.5,0.5)
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.BackgroundColor3 = Theme.BG
    main.BackgroundTransparency = Theme.Transparency

    Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Theme.Stroke

    -- DRAG
    local dragging, dragStart, startPos
    main.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - dragStart
            main.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- TOPBAR
    local top = Instance.new("Frame", main)
    top.Size = UDim2.new(1,0,0,46)
    top.BackgroundTransparency = 1

    local title = Instance.new("TextLabel", top)
    title.Text = "LYRA HUB ADMIN"
    title.Font = Enum.Font.GothamSemibold
    title.TextSize = 15
    title.TextColor3 = Theme.Text
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(16,0)
    title.Size = UDim2.fromScale(1,1)
    title.TextXAlignment = Enum.TextXAlignment.Left

    -- SIDEBAR
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.fromOffset(210,434)
    sidebar.Position = UDim2.fromOffset(0,46)
    sidebar.BackgroundColor3 = Theme.Panel
    sidebar.BackgroundTransparency = Theme.Transparency
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,14)

    local list = Instance.new("UIListLayout", sidebar)
    list.Padding = UDim.new(0,6)

    -- CONTENT
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-220,1,-56)
    content.Position = UDim2.fromOffset(220,56)
    content.BackgroundTransparency = 1

    self.Gui = gui
    self.Main = main
    self.Sidebar = sidebar
    self.Content = content
    self.Tabs = {}

    return self
end

-- TAB
function LyraUI:CreateTab(name)
    local btn = Instance.new("TextButton", self.Sidebar)
    btn.Size = UDim2.new(1,-12,0,40)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Theme.Text
    btn.BackgroundColor3 = Theme.BG
    btn.BackgroundTransparency = 0.15
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local page = Instance.new("ScrollingFrame", self.Content)
    page.Size = UDim2.fromScale(1,1)
    page.CanvasSize = UDim2.fromOffset(0,0)
    page.ScrollBarImageTransparency = 1
    page.Visible = false

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Page.Visible = false
        end
        page.Visible = true
    end)

    table.insert(self.Tabs, {Button = btn, Page = page})
    if #self.Tabs == 1 then
        page.Visible = true
    end

    return page
end

-- COMMAND ITEM
function LyraUI:AddCommand(tab, text)
    local lbl = Instance.new("TextLabel", tab)
    lbl.Size = UDim2.new(1,-12,0,36)
    lbl.Text = text
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 13
    lbl.TextColor3 = Theme.Sub
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

return LyraUI
