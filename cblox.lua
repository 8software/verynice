-- box

local Player = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()

local function Dist(pointA, pointB) -- magnitude errors for some reason  : (
    return math.sqrt(math.pow(pointA.X - pointB.X, 2) + math.pow(pointA.Y - pointB.Y, 2))
end

local function GetClosest(points, dest)
    local min  = math.huge 
    local closest = nil
    for _,v in pairs(points) do
        local dist = Dist(v, dest)
        if dist < min then
            min = dist
            closest = v
        end
    end
    return closest
end

local function DrawESP(plr)
    local Box = Drawing.new("Quad")
    Box.Visible = false
    Box.PointA = Vector2.new(0, 0)
    Box.PointB = Vector2.new(0, 0)
    Box.PointC = Vector2.new(0, 0)
    Box.PointD = Vector2.new(0, 0)
    Box.Color = Color3.fromRGB(255, 255, 255)
    Box.Thickness = 2
    Box.Transparency = 1

    local function Update()
        local c
        c = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local pos, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if vis then 
                    local points = {}
                    local c = 0
                    for _,v in pairs(plr.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            c = c + 1
                            local p = Camera:WorldToViewportPoint(v.Position)
                            if v.Name == "HumanoidRootPart" then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                            elseif v.Name == "Head" then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                            elseif string.match(v.Name, "Left") then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                            elseif string.match(v.Name, "Right") then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                            end
                            points[c] = p
                        end
                    end
                    local Left = GetClosest(points, Vector2.new(0, pos.Y))
                    local Right = GetClosest(points, Vector2.new(Camera.ViewportSize.X, pos.Y))
                    local Top = GetClosest(points, Vector2.new(pos.X, 0))
                    local Bottom = GetClosest(points, Vector2.new(pos.X, Camera.ViewportSize.Y))

                    if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
                        Box.PointA = Vector2.new(Right.X, Top.Y)
                        Box.PointB = Vector2.new(Left.X, Top.Y)
                        Box.PointC = Vector2.new(Left.X, Bottom.Y)
                        Box.PointD = Vector2.new(Right.X, Bottom.Y)

                        Box.Visible = true
                    else 
                        Box.Visible = false
                    end
                else 
                    Box.Visible = false
                end
            else
                Box.Visible = false
                if game.Players:FindFirstChild(plr.Name) == nil then
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(game:GetService("Players"):GetChildren()) do
    if v.Name ~= Player.Name then 
        DrawESP(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    DrawESP(v)
end)

--- nameesp

local esp_settings = { ---- table for esp settings 
    textsize = 8,
    colour = 255,255,255
}

local gui = Instance.new("BillboardGui")
local esp = Instance.new("TextLabel",gui) ---- new instances to make the billboard gui and the textlabel



gui.Name = "Cracked esp"; ---- properties of the esp
gui.ResetOnSpawn = false
gui.AlwaysOnTop = true;
gui.LightInfluence = 0;
gui.Size = UDim2.new(1.75, 0, 1.75, 0);
esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
esp.Text = ""
esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
esp.BorderSizePixel = 4;
esp.BorderColor3 = Color3.new(esp_settings.colour)
esp.BorderSizePixel = 0
esp.Font = "GothamSemibold"
esp.TextSize = esp_settings.textsize
esp.TextColor3 = Color3.fromRGB(esp_settings.colour) -- text colour

game:GetService("RunService").RenderStepped:Connect(function() ---- loops faster than a while loop :)
    for i,v in pairs (game:GetService("Players"):GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer and v.Character.Head:FindFirstChild("Cracked esp")==nil and v.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor then -- craeting checks for team check, local player etc
            esp.Text = "{"..v.Name.."}"
            gui:Clone().Parent = v.Character.Head
    end
end
end)

-- skeleton

local plr = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

for i, v in pairs(game.Players:GetChildren()) do
    local SkeletonTorso = Drawing.new("Line")
    SkeletonTorso.Visible = false
    SkeletonTorso.From = Vector2.new(0, 0)
    SkeletonTorso.To = Vector2.new(200, 200)
    SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
    SkeletonTorso.Thickness = 2
    SkeletonTorso.Transparency = 1

    local SkeletonHead = Drawing.new("Line")
    SkeletonHead.Visible = false
    SkeletonHead.From = Vector2.new(0, 0)
    SkeletonHead.To = Vector2.new(200, 200)
    SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
    SkeletonHead.Thickness = 2
    SkeletonHead.Transparency = 1

    local SkeletonLeftLeg = Drawing.new("Line")
    SkeletonLeftLeg.Visible = false
    SkeletonLeftLeg.From = Vector2.new(0, 0)
    SkeletonLeftLeg.To = Vector2.new(200, 200)
    SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftLeg.Thickness = 2
    SkeletonLeftLeg.Transparency = 1

    local SkeletonRightLeg = Drawing.new("Line")
    SkeletonRightLeg.Visible = false
    SkeletonRightLeg.From = Vector2.new(0, 0)
    SkeletonRightLeg.To = Vector2.new(200, 200)
    SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightLeg.Thickness = 2
    SkeletonRightLeg.Transparency = 1

    local SkeletonLeftArm = Drawing.new("Line")
    SkeletonLeftArm.Visible = false
    SkeletonLeftArm.From = Vector2.new(0, 0)
    SkeletonLeftArm.To = Vector2.new(200, 200)
    SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftArm.Thickness = 2
    SkeletonLeftArm.Transparency = 1

    local SkeletonRightArm = Drawing.new("Line")
    SkeletonRightArm.Visible = false
    SkeletonRightArm.From = Vector2.new(0, 0)
    SkeletonRightArm.To = Vector2.new(200, 200)
    SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightArm.Thickness = 2
    SkeletonRightArm.Transparency = 1

    function ESP()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= plr.Name  and v.Character.Humanoid.Health > 0 then 
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local UpperTorso = camera:WorldToViewportPoint(v.Character.UpperTorso.Position)
                    local LowerTorso = camera:WorldToViewportPoint(v.Character.LowerTorso.Position)

                    local LeftLeg = camera:WorldToViewportPoint(v.Character.LeftFoot.Position)
                    local RightLeg = camera:WorldToViewportPoint(v.Character.RightFoot.Position)

                    local LeftArm = camera:WorldToViewportPoint(v.Character.LeftHand.Position)
                    local RightArm = camera:WorldToViewportPoint(v.Character.RightHand.Position)

                    local Head = camera:WorldToViewportPoint(v.Character.Head.Position)

                    SkeletonTorso.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonTorso.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonHead.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonHead.To = Vector2.new(Head.X, Head.Y)

                    SkeletonLeftLeg.From = Vector2.new(LeftLeg.X, LeftLeg.Y)
                    SkeletonLeftLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonRightLeg.From = Vector2.new(RightLeg.X, RightLeg.Y)
                    SkeletonRightLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonLeftArm.From = Vector2.new(LeftArm.X, LeftArm.Y)
                    SkeletonLeftArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    SkeletonRightArm.From = Vector2.new(RightArm.X, RightArm.Y)
                    SkeletonRightArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    if v.TeamColor == plr.TeamColor then
                        SkeletonTorso.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonHead.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(0, 255, 0)
                    else 
                        SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
                    end

                    SkeletonTorso.Visible = true
                    SkeletonHead.Visible = true
                    SkeletonLeftArm.Visible = true
                    SkeletonLeftLeg.Visible = true
                    SkeletonRightArm.Visible = true
                    SkeletonRightLeg.Visible = true
                else 
                    SkeletonTorso.Visible = false
                    SkeletonHead.Visible = false
                    SkeletonLeftArm.Visible = false
                    SkeletonLeftLeg.Visible = false
                    SkeletonRightArm.Visible = false
                    SkeletonRightLeg.Visible = false
                end
            else 
                SkeletonTorso.Visible = false
                SkeletonHead.Visible = false
                SkeletonLeftArm.Visible = false
                SkeletonLeftLeg.Visible = false
                SkeletonRightArm.Visible = false
                SkeletonRightLeg.Visible = false
                if game.Players:FindFirstChild(v.Name) then
                else
                    Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

game.Players.PlayerAdded:Connect(function(newplr) --Parameter gets the new player that has been added
    local SkeletonTorso = Drawing.new("Line")
    SkeletonTorso.Visible = false
    SkeletonTorso.From = Vector2.new(0, 0)
    SkeletonTorso.To = Vector2.new(200, 200)
    SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
    SkeletonTorso.Thickness = 2
    SkeletonTorso.Transparency = 1

    local SkeletonHead = Drawing.new("Line")
    SkeletonHead.Visible = false
    SkeletonHead.From = Vector2.new(0, 0)
    SkeletonHead.To = Vector2.new(200, 200)
    SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
    SkeletonHead.Thickness = 2
    SkeletonHead.Transparency = 1

    local SkeletonLeftLeg = Drawing.new("Line")
    SkeletonLeftLeg.Visible = false
    SkeletonLeftLeg.From = Vector2.new(0, 0)
    SkeletonLeftLeg.To = Vector2.new(200, 200)
    SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftLeg.Thickness = 2
    SkeletonLeftLeg.Transparency = 1

    local SkeletonRightLeg = Drawing.new("Line")
    SkeletonRightLeg.Visible = false
    SkeletonRightLeg.From = Vector2.new(0, 0)
    SkeletonRightLeg.To = Vector2.new(200, 200)
    SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightLeg.Thickness = 2
    SkeletonRightLeg.Transparency = 1

    local SkeletonLeftArm = Drawing.new("Line")
    SkeletonLeftArm.Visible = false
    SkeletonLeftArm.From = Vector2.new(0, 0)
    SkeletonLeftArm.To = Vector2.new(200, 200)
    SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftArm.Thickness = 2
    SkeletonLeftArm.Transparency = 1

    local SkeletonRightArm = Drawing.new("Line")
    SkeletonRightArm.Visible = false
    SkeletonRightArm.From = Vector2.new(0, 0)
    SkeletonRightArm.To = Vector2.new(200, 200)
    SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightArm.Thickness = 2
    SkeletonRightArm.Transparency = 1

    function ESP()
        game:GetService("RunService").RenderStepped:Connect(function()
            if newplr.Character ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= plr.Name  and newplr.Character.Humanoid.Health > 0 then
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local UpperTorso = camera:WorldToViewportPoint(newplr.Character.UpperTorso.Position)
                    local LowerTorso = camera:WorldToViewportPoint(newplr.Character.LowerTorso.Position)

                    local LeftLeg = camera:WorldToViewportPoint(newplr.Character.LeftFoot.Position)
                    local RightLeg = camera:WorldToViewportPoint(newplr.Character.RightFoot.Position)

                    local LeftArm = camera:WorldToViewportPoint(newplr.Character.LeftHand.Position)
                    local RightArm = camera:WorldToViewportPoint(newplr.Character.RightHand.Position)

                    local Head = camera:WorldToViewportPoint(newplr.Character.Head.Position)

                    SkeletonTorso.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonTorso.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonHead.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonHead.To = Vector2.new(Head.X, Head.Y)

                    SkeletonLeftLeg.From = Vector2.new(LeftLeg.X, LeftLeg.Y)
                    SkeletonLeftLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonRightLeg.From = Vector2.new(RightLeg.X, RightLeg.Y)
                    SkeletonRightLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonLeftArm.From = Vector2.new(LeftArm.X, LeftArm.Y)
                    SkeletonLeftArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    SkeletonRightArm.From = Vector2.new(RightArm.X, RightArm.Y)
                    SkeletonRightArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    if newplr.TeamColor == plr.TeamColor then
                        SkeletonTorso.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonHead.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(0, 255, 0)
                    else 
                        SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
                    end

                    SkeletonTorso.Visible = true
                    SkeletonHead.Visible = true
                    SkeletonLeftArm.Visible = true
                    SkeletonLeftLeg.Visible = true
                    SkeletonRightArm.Visible = true
                    SkeletonRightLeg.Visible = true
                else 
                    SkeletonTorso.Visible = false
                    SkeletonHead.Visible = false
                    SkeletonLeftArm.Visible = false
                    SkeletonLeftLeg.Visible = false
                    SkeletonRightArm.Visible = false
                    SkeletonRightLeg.Visible = false
                end
            else 
                SkeletonTorso.Visible = false
                SkeletonHead.Visible = false
                SkeletonLeftArm.Visible = false
                SkeletonLeftLeg.Visible = false
                SkeletonRightArm.Visible = false
                SkeletonRightLeg.Visible = false
                if game.Players:FindFirstChild(newplr.Name) then
                else
                    Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end)