--createGui() -- creates the cmd gui
--addHistory(text) -- adds an item to the scrollframe menu using the text given
--addCmd(text, function) -- adds a cmd to the cmd table, and runs the function given when cmd called
--start() -- starts all functions(run at end)
-- example
local module = require(9383615849)
module.createGui()
module.addHistory("gui launched!")
module.addCmd(";yes", function()
	warn("Yesn't!")
  module.addHistory("Yesn't!")
end)
wait(0.1)
module.start()
