-- ✅ Loading Screen (อยู่จอนานขึ้น + ตัวอักษรใหญ่ขึ้น + Fade Out ช้าลง)
local LoadingGui = Instance.new("ScreenGui")
local LoadingText = Instance.new("TextLabel")

LoadingGui.Name = "FrontManLoading"
LoadingGui.Parent = game:GetService("CoreGui")
LoadingGui.IgnoreGuiInset = true
LoadingGui.ResetOnSpawn = false

LoadingText.Parent = LoadingGui
LoadingText.Size = UDim2.new(0, 400, 0, 120)
LoadingText.Position = UDim2.new(0.5, -200, 0.5, -60)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Front Man"
LoadingText.TextColor3 = Color3.fromRGB(0, 255, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = 60
LoadingText.TextStrokeTransparency = 0.3
LoadingText.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)

local TweenService = game:GetService("TweenService")

task.wait(3.5)

local FadeTween = TweenService:Create(LoadingText, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 1,
    TextStrokeTransparency = 1
})

FadeTween:Play()

FadeTween.Completed:Connect(function()
    LoadingGui:Destroy()

    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local Title = Instance.new("TextLabel")
    local Drag = Instance.new("TextButton")
    local SearchBox = Instance.new("TextBox")
    local SearchCorner = Instance.new("UICorner")
    local SearchStroke = Instance.new("UIStroke")
    local Scrolling = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local ToggleButton = Instance.new("TextButton")
    local ToggleCorner = Instance.new("UICorner")
    local ToggleStroke = Instance.new("UIStroke")

    ScreenGui.Name = "FrontManHub"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.Active = true
    MainFrame.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    UIStroke.Parent = MainFrame
    UIStroke.Color = Color3.fromRGB(0, 255, 255)
    UIStroke.Thickness = 4
    UIStroke.Transparency = 0.5

    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "Front Man Hub"
    Title.TextColor3 = Color3.fromRGB(0, 255, 255)
    Title.Font = Enum.Font.GothamSemibold
    Title.TextSize = 22

    Drag.Parent = MainFrame
    Drag.Size = UDim2.new(1, 0, 0, 40)
    Drag.BackgroundTransparency = 1
    Drag.Text = ""
    Drag.Active = true
    Drag.Draggable = true

    SearchBox.Parent = MainFrame
    SearchBox.Size = UDim2.new(0, 260, 0, 30)
    SearchBox.Position = UDim2.new(0, 20, 0, 45)
    SearchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SearchBox.PlaceholderText = "🔍 Search Script..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(0, 255, 255)
    SearchBox.Font = Enum.Font.GothamSemibold
    SearchBox.TextSize = 14

    SearchCorner.CornerRadius = UDim.new(0, 8)
    SearchCorner.Parent = SearchBox

    SearchStroke.Parent = SearchBox
    SearchStroke.Color = Color3.fromRGB(0, 255, 255)
    SearchStroke.Thickness = 2
    SearchStroke.Transparency = 0.3

    Scrolling.Parent = MainFrame
    Scrolling.Position = UDim2.new(0, 0, 0, 80)
    Scrolling.Size = UDim2.new(1, 0, 1, -80)
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scrolling.ScrollBarThickness = 6
    Scrolling.BackgroundTransparency = 1

    UIListLayout.Parent = Scrolling
    UIListLayout.Padding = UDim.new(0, 5)

    UIPadding.Parent = Scrolling
    UIPadding.PaddingLeft = UDim.new(0, 20)
    UIPadding.PaddingTop = UDim.new(0, 5)

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)

    ToggleButton.Parent = ScreenGui
    ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    ToggleButton.Position = UDim2.new(0, 20, 0, 100)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Text = "X"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 22
    ToggleButton.Active = true
    ToggleButton.Draggable = true

    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleButton

    ToggleStroke.Parent = ToggleButton
    ToggleStroke.Color = Color3.fromRGB(255, 0, 0)
    ToggleStroke.Thickness = 2
    ToggleStroke.Transparency = 0.3

    local isOpen = true
    ToggleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        MainFrame.Visible = isOpen
    end)

    local ButtonList = {}

    local function CreateButton(text, callback)
        local btn = Instance.new("TextButton")
        local corner = Instance.new("UICorner")
        local stroke = Instance.new("UIStroke")

        btn.Parent = Scrolling
        btn.Size = UDim2.new(0, 260, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(0, 255, 255)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 16

        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        stroke.Parent = btn
        stroke.Color = Color3.fromRGB(0, 255, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0.3

        btn.MouseButton1Click:Connect(callback)

        table.insert(ButtonList, {Button = btn, Name = text:lower()})
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = SearchBox.Text:lower()
        for _, data in pairs(ButtonList) do
            data.Button.Visible = searchText == "" or string.find(data.Name, searchText)
        end
    end)

    CreateButton("Load Infinite Yield", function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)

    CreateButton("Steal a Brianrot (Key Arbix Hub)", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/ArbixHubBEST.lua"))()
    end)

    CreateButton("Cloud Scripts", function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/laderite/scripts/main/Cloudscripts.lua'))()
    end)

    CreateButton("ESP (SpaceHub)", function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
    end)

end)
