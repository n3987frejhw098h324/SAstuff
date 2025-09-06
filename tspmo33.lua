repeat wait() until game:IsLoaded() and game:GetService("Players")

wait(3)
local l = game:GetService("Lighting")
l.Brightness = 2
l.FogEnd = 999999
l.FogStart = 0
l.GlobalShadows = false
l.ClockTime = 14

--[[local function clickIt(v)
    if v:IsA("ClickDetector") then
        task.defer(function()
            while v.Parent and v:IsDescendantOf(workspace) do
                fireclickdetector(v)
                task.wait(0.1)
            end
        end)
    end
end

for _, v in ipairs(workspace:GetDescendants()) do
    clickIt(v)
end

workspace.DescendantAdded:Connect(clickIt)]]


--[[task.spawn(function()
    while true do
        for _, itemName in ipairs({"Rainbow Orb", "DIO's Skull 2"}) do
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(itemName)
            or (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild(itemName)) then

                task.spawn(function()
                    while game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(itemName)
                    or (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild(itemName)) do

                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(itemName) then
                            game:GetService("Players").LocalPlayer.Backpack[itemName].Parent = game:GetService("Players").LocalPlayer.Character
                        end

                        task.wait(0.1)

                        for i = 1, 8 do
                            game:GetService("ReplicatedStorage"):WaitForChild("Bank"):FireServer("Slot" .. i, false, false)
                        end

                        task.wait(0.1)
                    end
                end)
            end
        end
        task.wait(0.1)
    end
end)]]
-- now that its fully auto it is kinda useless. ill keep it in case of anything.
local map = workspace:FindFirstChild("Map")
if map and map:FindFirstChild("Launching Orb") then
    map["Launching Orb"]:Destroy()
end


if hookfunction then
    local OWgg
    OWgg = hookfunction(wait, function(s)
        return OWgg(math.max(s or 0, 0.01))
    end)
else
    warn("your bitchass executor is ass")
end

game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("Client2"):Destroy()

local p = game:GetService("Players")
local lp = p.LocalPlayer
local c = lp.Character or lp.CharacterAdded:Wait()
local hrp = c:WaitForChild("HumanoidRootPart")
local h = c:WaitForChild("Humanoid")
local ok = true
local atk = game:GetService("Workspace").Dead
local o = game:GetService("Workspace").ObbyW
local ph = game:GetService("Workspace").BossPhase
local hp = game:GetService("Workspace").TrollHealth
local w = game:GetService("Workspace")

if w:FindFirstChild("Effects") then
    w.Effects:Destroy()
end
if w.Map:FindFirstChild("ThunderParts") then
    w.Map.ThunderParts:Destroy()
end

local function eq()
    local tool = c:FindFirstChild("KnightsSword")
    if tool and tool:FindFirstChild("Handle") then
        local box = Instance.new("SelectionBox")
        box.Name = "sb"
        box.Parent = tool.Handle
        box.Adornee = tool.Handle
        tool.Handle.Massless = true
        tool.GripPos = Vector3.new(0,0,0)
        c:FindFirstChildOfClass("Humanoid"):UnequipTools()
        tool.Parent = c
        tool.Handle.Size = Vector3.new(0.5, 0.5, 500)
    end
end

if lp.Backpack:FindFirstChild("KnightsSword") then
    lp.Backpack["KnightsSword"].Parent = c
    eq()
elseif c:FindFirstChild("KnightsSword") then
    eq()
end

task.spawn(function()
    while not atk.Value do task.wait()
        if o.Value then
            hrp.CFrame = CFrame.new(20.456, 113.245, 196.613)
        else
            if ph.Value == "None" then
                hrp.CFrame = CFrame.new(-5.47, -4.45, 248.21)
            else
                hrp.CFrame = CFrame.new(-19.89, -4.77, 142.49)
            end
        end
    end
end)

task.spawn(function()
    while not atk.Value do task.wait()
        if not o.Value then
            if c:FindFirstChild("KnightsSword") then
                c.KnightsSword:Activate()
            end
        end
    end
end)

local function pct(x, y)
    return (x / y)
end

hp:GetPropertyChangedSignal("Value"):Connect(function()
    if pct(hp.Value, hp.MaxHealth.Value) <= 0.003 and pct(hp.Value, hp.MaxHealth.Value) >= 0 then
        if ok then
            ok = false
            c:FindFirstChildOfClass("Humanoid"):UnequipTools()
            lp.Backpack["KnightsSword"].Parent = c
        end
    end
end)

spawn(function()
	for i = 1, 100 do
		local p = game.Players.LocalPlayer
		local c = p.Character or p.CharacterAdded:Wait()
		local hrp = c:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(90), 0)
		end
		task.wait(0.1)
	end
end)


local function onCharacterAdded(char)
    local hum = char:WaitForChild("Humanoid", 5)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    local animate = char:FindFirstChild("Animate")
    
    if animate then
        animate.Disabled = true
    end

    if hum then
        for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
            track:Stop()
        end

        hum.AnimationPlayed:Connect(function(track)
            track:Stop()
        end)
    end
end

if lp.Character then
    onCharacterAdded(plr.Character)
end

lp.CharacterAdded:Connect(onCharacterAdded)

task.spawn(function()
    task.wait(8)

    while true do
        task.wait(0.01)

        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        local prism = workspace:FindFirstChild("TrollPrism")
        if not hrp or not prism then 
            continue 
        end

        local pos = hrp.Position
        local dir = (prism.Position - pos).Unit

        local cos45, sin45 = math.cos(math.rad(45)), math.sin(math.rad(45))
        local rotated = Vector3.new(
            dir.X * cos45 - dir.Z * sin45,
            dir.Y,
            dir.X * sin45 + dir.Z * cos45
        )

        hrp.CFrame = CFrame.lookAt(pos, pos + rotated)
    end
end)
