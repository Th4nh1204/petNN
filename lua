
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
    return 100
    end
-------------COLLECT ORB--------------
local toggleFunction = function(CollectOrbs)
    Orbs = CollectOrbs
    if getgenv().config.CollectOrbs then
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
    if getgenv().config.CollectLootBags then
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
    Default = getgenv().config.CollectOrbs,
    Callback = toggleFunction
})
Tab:AddToggle({
    Name = "Collect Lootbags/Items",
    Default = getgenv().config.CollectLootBags,
    Callback = toggleFunction2
})
-------------HATCH EGG--------------
Tab:AddSlider({
	Name = "Count HatchEgg",
	Min = 1,
	Max = 99,
	Default = getgenv().config.CountEggHatch,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Egg",
	Callback = function(CountEggs)
		getgenv().config.CountEggHatch = CountEggs
	end    
})
Tab:AddToggle({
	Name = "Hatch Egg",
	Default = getgenv().config.HatchEgg,
	Callback = function(HatchEggs)
        getgenv().config.HatchEgg = HatchEggs
    if getgenv().config.HatchEgg then
        game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game["Egg Opening Frontend"]:Destroy()
task.wait(0.2)
        while getgenv().config.HatchEgg do
                local argsHatch = {
                    [1] = "Tech Ciruit Egg",
                    [2] = getgenv().config.CountEggHatch
                }
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Eggs_RequestPurchase"):InvokeServer(unpack(argsHatch))
                end
        end
    end
})
-------------CLAIM FREE REWARDS--------------
Tab:AddToggle({
	Name = "Claim Rewards",
	Default = false,
	Callback = function(claimrewards)
        if claimrewards then
        while claimrewards do
            for i = 1, 12 do
                local args = { [1] = i }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Redeem Free Gift"):InvokeServer(unpack(args))
                task.wait(0.5)
            end
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
        if whitescreen then
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
            workspace.__THINGS.Eggs:Destroy()
            task.wait(1)
            workspace.ALWAYS_RENDERING:Destroy()
            task.wait(1)
            game:GetService("Lighting").Sky:Destroy()
            task.wait(1)
            game:GetService("Lighting").Atmosphere:Destroy()
            task.wait(1)
            game:GetService("Lighting").Bloom:Destroy()
            task.wait(1)
            game:GetService("Lighting").ColorCorrection:Destroy()
          end
	end    
})
-------------ANTI AFK--------------
Tab2:AddToggle({
	Name = "AntiAFK Jump",
	Default = getgenv().config.AntiKick,
	Callback = function(AntiAFKJump)
        getgenv().config.AntiKick = AntiAFKJump
        if getgenv().config.AntiKick then
            while getgenv().config.AntiKick do
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
        task.wait(1)
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
----------------Craft KEY------------------------
Tab2:AddSection({
	Name = "Craft Key"
})
Tab2:AddToggle({
	Name = "Craft CrystalKey",
	Default = false,
	Callback = function(crystalkey)
		if crystalkey then
            while crystalkey do
            task.wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CrystalKey_Combine"):InvokeServer()
        end
    end
end
})
Tab2:AddToggle({
	Name = "Craft SecretKey",
	Default = false,
	Callback = function(secretkey)
		if secretkey then
            while secretkey do
            task.wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("SecretKey_Combine"):InvokeServer()
        end
    end
end
})
Tab2:AddToggle({
	Name = "Craft TechKey",
	Default = false,
	Callback = function(techkey)
		if techkey then
            while techkey do
            task.wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("TechKey_Combine"):InvokeServer()
        end
    end
end
})--------------USE KEY----------------------
Tab2:AddSection({
	Name = "Use Key"
})
Tab2:AddToggle({
	Name = "Use CrystalKey",
	Default = false,
	Callback = function(crystalkey2)
		if crystalkey2 then
            while crystalkey2 do
            wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CrystalKey_Unlock"):InvokeServer()
        end
    end
end
})
Tab2:AddToggle({
	Name = "Use TechKey",
	Default = false,
	Callback = function(techkey2)
		if techkey2 then
            while techkey2 do
            wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("TechKey_Unlock"):InvokeServer()
        end
    end
end
})
--------------SPINNY TICKET----------------------
Tab2:AddSection({
	Name = "Spinny Ticket"
})
Tab2:AddToggle({
	Name = "Spin StarterTicket",
	Default = false,
	Callback = function(starterticket)
		if starterticket then
            while starterticket do
            wait(0.5)
            local args = { [1] = "StarterWheel" }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Spinny Wheel: Request Spin"):InvokeServer(unpack(args))            
        end
    end
end
})
Tab2:AddToggle({
	Name = "Spin TechTicket",
	Default = false,
	Callback = function(techticket)
		if techticket then
            while techticket do
            wait(0.5)
            local args = { [1] = "TechWheel" }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Spinny Wheel: Request Spin"):InvokeServer(unpack(args))
        end
    end
end
})
--------------OPEN GIFT----------------------
Tab2:AddSection({
	Name = "Open Gift"
})
Tab2:AddToggle({
	Name = "Open CharmStone",
	Default = false,
	Callback = function(CharmStone)
		if CharmStone then
            while CharmStone do
            wait(0.5)
            local args = { [1] = "Charm Stone" }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("GiftBag_Open"):InvokeServer(unpack(args))            
        end
    end
end
})
Tab2:AddToggle({
	Name = "Open Large GiftBag",
	Default = false,
	Callback = function(LargeBag)
		if LargeBag then
            while LargeBag do
            wait(0.5)
            local args = { [1] = "Large Gift Bag" }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("GiftBag_Open"):InvokeServer(unpack(args))            
        end
    end
end
})
Tab2:AddToggle({
	Name = "Open GiftBag",
	Default = false,
	Callback = function(GiftBag)
		if GiftBag then
            while GiftBag do
            wait(0.5)
            local args = { [1] = "Gift Bag" }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("GiftBag_Open"):InvokeServer(unpack(args))            
        end
    end
end
})
OrionLib:Init()
