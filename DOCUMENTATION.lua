--createGui() -- creates the cmd gui
--addHistory(text) -- adds an item to the scrollframe menu using the text given
--addCmd(text, function) -- adds a cmd to the cmd table, and runs the function given when cmd called
--start() -- starts all functions(run at end)
--killUI() -- removes ui
-- example
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/Peppermintsaregood/CMD-MODULE/main/source.lua"))() -- call the module
module.createGui()
module.addHistory("gui launched!")
module.addCmd(";yes", function()
	warn("Yesn't!")
  module.addHistory("Yesn't!")
end)
wait(0.1)
module.start()
wait(5)
module.killUI()
