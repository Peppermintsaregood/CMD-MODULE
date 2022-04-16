local cmdBarV = nil
local autoBarV = nil
local template = nil
local scrollFrame = nil
local existing = false
local cmds = {}
local m = {
	createGui = function()
		if existing == false then
			existing = true
			local robloxxser = Instance.new("ScreenGui")
			local Frame = Instance.new("Frame")
			local cmdBar = Instance.new("Frame")
			local cmdBar_2 = Instance.new("TextBox")
			local auto = Instance.new("TextBox")
			local cmdHistory = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local cmd = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")

			robloxxser.Name = "robloxxser"
			robloxxser.Parent = game.CoreGui
			robloxxser.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

			Frame.Parent = robloxxser
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Frame.BackgroundTransparency = 0.100
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0, 0, 0.650746286, 0)
			Frame.Size = UDim2.new(0.1579272, 0, 0.349253744, 0)
			Frame.ZIndex = 100

			cmdBar.Name = "cmdBar"
			cmdBar.Parent = Frame
			cmdBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			cmdBar.BorderSizePixel = 0
			cmdBar.Position = UDim2.new(0, 0, -0.0854700878, 0)
			cmdBar.Size = UDim2.new(1, 0, 0.102564104, 0)
			cmdBar.ZIndex = 100

			cmdBar_2.Name = "cmdBar"
			cmdBar_2.Parent = cmdBar
			cmdBar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			cmdBar_2.BackgroundTransparency = 1.000
			cmdBar_2.Size = UDim2.new(1, 0, 1, 0)
			cmdBar_2.ZIndex = 2000
			cmdBar_2.Font = Enum.Font.Roboto

			cmdBar_2.Text = ""
			cmdBar_2.TextColor3 = Color3.fromRGB(179, 179, 179)
			cmdBar_2.TextScaled = true
			cmdBar_2.TextSize = 14.000
			cmdBar_2.TextWrapped = true
			cmdBar_2.TextXAlignment = Enum.TextXAlignment.Left

			auto.Name = "auto"
			auto.Parent = cmdBar
			auto.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			auto.BackgroundTransparency = 1.000
			auto.Size = UDim2.new(1, 0, 1, 0)
			auto.ZIndex = 1999
			auto.Font = Enum.Font.Roboto
			auto.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
			auto.Text = ""
			auto.TextColor3 = Color3.fromRGB(99, 99, 99)
			auto.TextScaled = true
			auto.TextSize = 14.000
			auto.TextWrapped = true
			auto.TextXAlignment = Enum.TextXAlignment.Left

			cmdHistory.Name = "cmdHistory"
			cmdHistory.Parent = Frame
			cmdHistory.Active = true
			cmdHistory.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			cmdHistory.BackgroundTransparency = 1.000
			cmdHistory.Size = UDim2.new(1, 0, 1, 0)
			cmdHistory.ScrollBarThickness = 0
			cmdHistory.AutomaticCanvasSize = Enum.AutomaticSize.Y

			UIListLayout.Parent = cmdHistory
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 6)

			cmd.Name = "cmd"
			cmd.Parent = Frame
			cmd.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			cmd.BorderSizePixel = 0
			cmd.Size = UDim2.new(1, 0, 0.128205121, 0)
			cmd.Visible = false

			TextLabel.Parent = cmd
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.Font = Enum.Font.Roboto
			TextLabel.TextColor3 = Color3.fromRGB(0, 171, 0)
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
						cmdBarV = cmdBar_2
			autoBarV = auto
			template = cmd
			scrollFrame = cmdHistory
		else
			warn("UI Already exists! - Peppermints CMD module maker")
		end

	end,
	addHistory = function(text : string)
		if existing == true then

			local clone = template:Clone()
			clone.Parent = scrollFrame
			clone:FindFirstChild("TextLabel").Text = text
			clone.Visible = true
		else
			warn("UI dosen't exist, cannot create history token! - Peppermints CMD module maker")
		end
	end,
	addCmd = function(text : string, functionv)
		cmds[text] = function(testing, args)
			if testing == false or testing == nil then
				functionv(args)
			else
				return (text) -- cmd name
			end
		end
	end,
	start = function()
		if existing == true then
		    spawn(function()
			cmdBarV:GetPropertyChangedSignal("Text"):Connect(function() -- autocomplete
				local text = string.lower(cmdBarV.Text)
				local found = false
				for v, i in pairs(cmds) do
					local returned = string.lower(i(true))
					if string.find(returned, text) then
						-- found the cmd so autocomplete
						autoBarV.Text = returned
						found = true
					end
				end
				if cmdBarV.Text == "" then
				     autoBarV.Text = ""
				end
				if found == false then
				    autoBarV.Text = ""
				end
			end)
			end)
			game:GetService("UserInputService").InputBegan:Connect(function(input)
				if input.KeyCode == Enum.KeyCode.Semicolon then
					cmdBarV:CaptureFocus()
				elseif input.KeyCode == Enum.KeyCode.Return then
				     autoBarV.Text = ""
				     
				     print("enter")
					for v, i in pairs(cmds) do
						local returned = string.lower(i(true))
						print(returned, cmdBarV.Text)
						if returned == cmdBarV.Text then
						    print("foundededed")
							i(false)
						end
					end
					wait(0.05)
					cmdBarV.Text = ""
					cmdBarV:ReleaseFocus()
				end
			end)
		end
	end,
}
return m
