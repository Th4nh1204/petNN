local plp = game:GetService("Players").LocalPlayer.Character
local humanoidRootPart = plp:WaitForChild("HumanoidRootPart")
local OrbRemote = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect")
local LootbagRemote = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim")
local OrbFolder = workspace:WaitForChild("__THINGS"):WaitForChild("Orbs")
local LootbagFolder = workspace:WaitForChild("__THINGS"):WaitForChild("Lootbags")
local Library = require(game:GetService("ReplicatedStorage").Library)
local VirtualInputManager = game:GetService("VirtualInputManager")
local vu = game:GetService("VirtualUser")

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Title of the library", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
-------------Tab--------------
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab2 = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
-------------SPEED PET--------------
Library.PlayerPet.CalculateSpeedMultiplier = function()
    return 36
    end
-------------COLLECT ORB--------------
local toggleFunction = function(CollectOrbs)
    Orbs = CollectOrbs
    if CollectOrbs then
    OrbFolder.ChildAdded:Connect(function(Orb)
        task.wait()
        Orb:PivotTo(humanoidRootPart.CFrame)
        OrbRemote:FireServer({Orb.Name})
        task.wait()
        Orb:Destroy()
    end)
    end
end
local toggleFunction2 = function(CollectLootBags)
    Lootbags = CollectLootBags
    if CollectLootBags then
        LootbagFolder.ChildAdded:Connect(function(Lootbag)
            task.wait()
            Lootbag:PivotTo(humanoidRootPart.CFrame)
            LootbagRemote:FireServer({Lootbag.Name})
            task.wait()
            Lootbag:Destroy()
            end)
    end
end

Tab:AddToggle({
    Name = "Collect Orb",
    Default = Orbs,
    Callback = toggleFunction
})
Tab:AddToggle({
    Name = "Collect Lootbags/Items",
    Default = Lootbags,
    Callback = toggleFunction2
})
-------------HATCH EGG--------------
NameEggHatch = ""
Tab:AddSlider({
	Name = "Count HatchEgg",
	Min = 1,
	Max = 99,
	Default = CountEggHatch,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Egg",
	Callback = function(Value)
		CountEggHatch = Value
	end    
})
Tab:AddToggle({
	Name = "Hatch Egg",
	Default = false,
	Callback = function(HatchEgg)
    if HatchEgg then
        game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game["Egg Opening Frontend"]:Destroy()
task.wait(0.2)
        while HatchEgg do
                local argsHatch = {
                    [1] = NameEggHatch,
                    [2] = CountEggHatch
                }
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Eggs_RequestPurchase"):InvokeServer(unpack(argsHatch))
            end
        end
    end
})
-------------POSTION--------------
Tab:AddButton({
	Name = "Best Area Postion",
	Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
            CFrame.new()
  	end    
})
Tab:AddButton({
	Name = "Hatch Egg Postion",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
        CFrame.new()
  	end    
})
-------------CLAIM FREE REWARDS--------------
Tab:AddToggle({
	Name = "Claim Rewards",
	Default = false,
	Callback = function(claimRewards)
        if claimRewards then
        while claimRewards do
            for i = 1, 12 do
                local args = { [1] = i }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Redeem Free Gift"):InvokeServer(unpack(args))
            end
        task.wait(0.5)
        end
    end
end})
-------------WHITESCREEN--------------
Tab2:AddSection({
	Name = "Misc"
})
Tab2:AddToggle({
	Name = "Whitescreen",
	Default = false,
	Callback = function(whitescreen)
        if whitescreen == true then
             game:GetService("RunService"):Set3dRenderingEnabled(false)
          else
             game:GetService("RunService"):Set3dRenderingEnabled(true)
          end
        end   
})
-------------BOOST FPS-------------------
Tab2:AddToggle({
	Name = "Boost FPS",
	Default = false,
	Callback = function(BoostFps)
		if BoostFps then
            workspace.Map["1 | Spawn"]:Destroy()
            wait(1)
            workspace.Map["2 | Colorful Forest"]:Destroy()
            wait(1)
            workspace.__THINGS.Eggs:Destroy()
            wait(1)
            workspace.ALWAYS_RENDERING:Destroy()
            wait(1)
            game:GetService("Lighting").Sky:Destroy()
            wait(1)
            game:GetService("Lighting").Atmosphere:Destroy()
            wait(1)
            game:GetService("Lighting").Bloom:Destroy()
            wait(1)
            game:GetService("Lighting").ColorCorrection:Destroy()
          end
	end    
})
-------------ANTI AFK--------------
Tab2:AddToggle({
	Name = "AntiAFK Jump",
	Default = false,
	Callback = function(AntiAFKJump)
        if AntiAFKJump then
            while AntiAFKJump do
                VirtualInputManager:SendKeyEvent(true, "Space", false, game)
                task.wait(0.2)
                VirtualInputManager:SendKeyEvent(false, "Space", false, game)
                task.wait(100)
            end
        end
    end
})
Tab2:AddButton({
	Name = "AntiAFK",
	Callback = function(AntiAFK)
      	if AntiAFK then
        game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
  	end    
})
------------Teleport Players--------------
Tab2:AddSection({
	Name = "Teleport Players"
})
local Players = game:GetService("Players")
local PlayerNames = {}

for i, player in ipairs(Players:GetPlayers()) do
    table.insert(PlayerNames, player.Name)
end

Tab2:AddDropdown({
	Name = "Dropdown",
	Default = PlayerNames[1],
	Options = PlayerNames,
	Callback = function(Value)
		Username = Value
	end})
Tab2:AddToggle({
	Name = "Teleport",
	Default = false,
	Callback = function(Teleports)
		while Teleports do
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Username].Character.HumanoidRootPart.CFrame
			wait(10)
		end
	end    
})
----------------Craft------------------------
Tab2:AddSection({
	Name = "Craft Key"
})
CraftCrystalKey = false
CraftSecretKey = false
UseCrystalKey = false
Tab2:AddToggle({
	Name = "Craft CrystalKey",
	Default = false,
	Callback = function(CrystalKey)
		CraftCrystalKey = CrystalKey
            while CraftCrystalKey do
            task.wait(0.4)
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CrystalKey_Combine"):InvokeServer()
        end
end
})
Tab2:AddToggle({
	Name = "Craft SecretKey",
	Default = false,
	Callback = function(SecretKey)
		CraftSecretKey = SecretKey
            while CraftSecretKey do
            task.wait(0.4)
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("SecretKey_Combine"):InvokeServer()
        end
end
})
Tab2:AddToggle({
	Name = "Use CrystalKey",
	Default = false,
	Callback = function(CrystalKey2)
		UseCrystalKey = CrystalKey2
            while UseCrystalKey do
            wait(0.5)
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CrystalKey_Unlock"):InvokeServer()
        end
end
})
OrionLib:Init()
