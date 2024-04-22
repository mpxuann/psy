from psychopy import visual, core, event,gui

clk  = core.Clock()
       
res = event.getKeys(keyList = ['return'],timeStamped = clk) 
print(res)