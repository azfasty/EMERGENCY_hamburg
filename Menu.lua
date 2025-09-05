local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "EmergencyHamburgUI"

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50) -- Dark navy
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui
mainFrame.Active = true

-- Coins arrondis
local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 12)
uICorner.Parent = mainFrame

-- Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 100, 0, 100)
logo.Position = UDim2.new(0.5, -50, 0, 10)
logo.Image = "https://cdn.discordapp.com/attachments/1362349205041057857/1413627745673412679/PNG_CHEAT.png"
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

-- Toggle menu avec P
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.P then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Sidebar pour tabs
local sideHeading = Instance.new("Frame")
sideHeading.Size = UDim2.new(0, 120, 1, -20)
sideHeading.Position = UDim2.new(0, 10, 0, 10)
sideHeading.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
sideHeading.Parent = mainFrame

local sideUICorner = Instance.new("UICorner")
sideUICorner.CornerRadius = UDim.new(0, 8)
sideUICorner.Parent = sideHeading

local tabFrame = Instance.new("ScrollingFrame")
tabFrame.Size = UDim2.new(1, -10, 1, -10)
tabFrame.Position = UDim2.new(0, 5, 0, 5)
tabFrame.BackgroundTransparency = 1
tabFrame.ScrollBarThickness = 0
tabFrame.Parent = sideHeading

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = tabFrame

-- Conteneur pour pages
local pageFolder = Instance.new("Folder")
pageFolder.Parent = mainFrame

-- Fonction pour créer une tab
local function CreateTab(tabName)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 30)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    tabBtn.TextColor3 = Color3.fromRGB(153, 255, 238)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 14
    tabBtn.Text = tabName
    tabBtn.Parent = tabFrame

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -140, 1, -20)
    page.Position = UDim2.new(0, 130, 0, 10)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = pageFolder

    tabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(pageFolder:GetChildren()) do
            v.Visible = false
        end
        page.Visible = true
    end)

    return page
end

-- Exemple de tabs et sections
local vehiclesPage = CreateTab("Vehicles")
local adminPage = CreateTab("Admin")

-- Exemple de boutons dans la page Vehicles
local vehicleBtn = Instance.new("TextButton")
vehicleBtn.Size = UDim2.new(0, 200, 0, 30)
vehicleBtn.Position = UDim2.new(0, 10, 0, 10)
vehicleBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
vehicleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
vehicleBtn.Text = "Spawn Car"
vehicleBtn.Parent = vehiclesPage
vehicleBtn.MouseButton1Click:Connect(function()
    print("Spawn Car clicked")
end)
