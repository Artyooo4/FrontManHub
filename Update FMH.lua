--// FrontMan Universal Fly (For Lonic) //--
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local flying = false
local speed = 5
local control = {f = 0, b = 0, l = 0, r = 0}

local bg = Instance.new("BodyGyro", hrp)
local bv = Instance.new("BodyVelocity", hrp)
bg.P = 9e4
bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
bg.CFrame = hrp.CFrame
bv.Velocity = Vector3.zero
bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

function fly()
	flying = true
	bv.Velocity = Vector3.zero
	spawn(function()
		while flying do
			game:GetService("RunService").Heartbeat:Wait()
			bv.Velocity = ((workspace.CurrentCamera.CFrame.LookVector * (control.f - control.b)) +
				((workspace.CurrentCamera.CFrame * CFrame.new(control.l + -control.r, 0, 0)).Position - workspace.CurrentCamera.CFrame.Position)) * speed
			bg.CFrame = workspace.CurrentCamera.CFrame
		end
	end)
end

function stopFly()
	flying = false
	bv.Velocity = Vector3.zero
end

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		if flying then
			stopFly()
		else
			fly()
		end
	elseif input.KeyCode == Enum.KeyCode.W then
		control.f = 1
	elseif input.KeyCode == Enum.KeyCode.S then
		control.b = 1
	elseif input.KeyCode == Enum.KeyCode.A then
		control.l = 1
	elseif input.KeyCode == Enum.KeyCode.D then
		control.r = 1
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		speed = 10
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then
		control.f = 0
	elseif input.KeyCode == Enum.KeyCode.S then
		control.b = 0
	elseif input.KeyCode == Enum.KeyCode.A then
		control.l = 0
	elseif input.KeyCode == Enum.KeyCode.D then
		control.r = 0
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		speed = 5
	end
end)
