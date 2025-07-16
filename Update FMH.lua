-- Front Man Hub UI Script for Roblox Mobile Executors
-- Designed for Ronix, Arceus X, Hydrogen, and other mobile executors
-- Created for educational purposes only. Use responsibly in private servers.

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- สร้าง UI Window สำหรับ Front Man Hub
local Window = Rayfield:CreateWindow({
    Name = "Front Man Hub",
    LoadingTitle = "Loading Front Man Hub",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "FrontManHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false -- ปิด KeySystem เพื่อความสะดวกในการทดสอบ
})

-- สร้าง Tab หลัก
local MainTab = Window:CreateTab("Main", nil)
local MainSection = MainTab:CreateSection("Main Menu")

-- การตั้งค่าสไตล์ UI (สีเรืองแสง)
local NeonColors = {
    Primary = Color3.fromRGB(0, 255, 255), -- สีฟ้าเรืองแสง (Cyan)
    Secondary = Color3.fromRGB(255, 0, 255), -- สีม่วงเรืองแสง (Magenta)
    Accent = Color3.fromRGB(255, 255, 0), -- สีเหลืองเรืองแสง (Yellow)
    Background = Color3.fromRGB(20, 20, 30), -- พื้นหลังสีเข้มเพื่อให้สีเรืองแสงเด่น
    Glow = Color3.fromRGB(0, 255, 255) -- สีสำหรับเอฟเฟกต์เรืองแสง
}

-- การแจ้งเตือนเมื่อ UI ถูกโหลด
Rayfield:Notify({
    Title = "Front Man Hub Loaded",
    Content = "Welcome to Front Man Hub! Ready to customize your experience.",
    Duration = 5,
    Image = nil,
    Actions = {
        Ignore = {
            Name = "OK",
            Callback = function()
                print("Front Man Hub UI Initialized!")
            end
        }
    }
})

-- ปุ่มตัวอย่างใน UI (ยังไม่มีฟังก์ชันในเกม)
local ExampleButton = MainTab:CreateButton({
    Name = "Test Button",
    Callback = function()
        Rayfield:Notify({
            Title = "Button Pressed",
            Content = "This is a test button for Front Man Hub!",
            Duration = 3,
            Image = nil
        })
    end
})

-- การตั้งค่า UI ให้เหมาะกับมือถือ
local function OptimizeForMobile()
    if UserInputService.TouchEnabled then
        -- ปรับขนาด UI สำหรับหน้าจอมือถือ
        Window:SetScale(Vector2.new(0.8, 0.8)) -- ลดขนาด UI สำหรับหน้าจอเล็ก
        MainTab:SetBackgroundColor(NeonColors.Background)
        MainSection:SetTextColor(NeonColors.Primary)
    end
end

-- เรียกใช้การปรับแต่งสำหรับมือถือ
OptimizeForMobile()

-- ฟังก์ชันเพิ่มเติมสำหรับการจัดการ UI
local function ApplyGlowEffect(element)
    -- จำลองเอฟเฟกต์เรืองแสง (Glow Effect) โดยใช้ UIStroke
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 2
    Stroke.Color = NeonColors.Glow
    Stroke.Transparency = 0.3
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = element
end

-- ใช้เอฟเฟกต์เรืองแสงกับทุกองค์ประกอบใน UI
for _, element in pairs(Window:GetDescendants()) do
    if element:IsA("GuiObject") then
        ApplyGlowEffect(element)
    end
end

-- การจัดการการอัปเดต UI
game:GetService("RunService").RenderStepped:Connect(function()
    -- ตัวอย่างการอัปเดต UI แบบเรียลไทม์ (ถ้าต้องการเพิ่มอนิเมชัน)
    -- เช่น การทำให้สีเรืองแสงเปลี่ยนแปลงเล็กน้อย
    local time = tick()
    local pulse = math.sin(time * 2) * 0.1 + 0.9 -- สร้างเอฟเฟกต์ pulse
    for _, stroke in pairs(Window:GetDescendants()) do
        if stroke:IsA("UIStroke") then
            stroke.Transparency = 0.3 * pulse
        end
    end
end)
