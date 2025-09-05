local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "EmergencyHamburgUI"

-- Création du Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50) -- Dark blue/navy proche du gris
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Coins arrondis
local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 12)
uICorner.Parent = mainFrame

-- Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 100, 0, 100)
logo.Position = UDim2.new(0.5, -50, 0, 10)
logo.Image = "https://cdn.discordapp.com/attachments/1362349205041057857/1413627745673412679/PNG_CHEAT.png?ex=68bc9eee&is=68bb4d6e&hm=4a6aec43daf5737ff1cfa2315e969ee0925f5a1b35d9c962c8ad20d283664876&" -- remplace par ton CDN
logo.BackgroundTransparency = 1
logo.Parent = mainFrame

-- Bouton fermer
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundTransparency = 0.7
closeButton.Parent = mainFrame
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Bouton réduire
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundTransparency = 0.7
minimizeButton.Parent = mainFrame
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, v in pairs(mainFrame:GetChildren()) do
        if v ~= minimizeButton and v ~= closeButton and v ~= logo then
            v.Visible = not minimized
        end
    end
end)


local TopBar = sideHeading
local Draggable, DragMousePosition, FramePosition = false, nil, nil

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Draggable = true
        DragMousePosition = Vector2.new(input.Position.X, input.Position.Y)
        FramePosition = Vector2.new(shadow.Position.X.Scale, shadow.Position.Y.Scale)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Draggable then
        local NewPosition = FramePosition + ((Vector2.new(input.Position.X, input.Position.Y) - DragMousePosition) / workspace.CurrentCamera.ViewportSize)
        shadow.Position = UDim2.new(NewPosition.X, 0, NewPosition.Y, 0)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Draggable = false
    end
end)

-- Toggle menu avec P
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.P then
        mainFrame.Visible = not mainFrame.Visible
    end
end)
