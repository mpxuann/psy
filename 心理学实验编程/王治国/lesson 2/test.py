# load libraries
from psychopy import visual, core, event

# open a window 
win = visual.Window(units= 'pix')

sti = visual.GratingStim(win, size = 64, tex = 'sin', mask = 'gauss', sf = 0.1)

for i in range(3):
    sti.ori = 0
    while True:
        # show the stimulation
        event.clearEvents()
        sti.ori+=0.2
        sti.draw()
        
        win.flip()
        sti_onset = core.getTime()
        
        # wait for key presses 
        #_key = event.getKeys(keyList = ['k'],timeStamped = 1) # _key = [['j',2.2316546546]]
        _key = event.getKeys(timeStamped = 1) # _key = [['j',2.2316546546]]
       
       
        if len(_key)>0:
            key_name, key_time = _key[0]
            print(sti_onset, key_name, key_time,sti_onset-key_time)
            break
        # clear the screen
    win.color = (0,0,0)
    win.flip()
    core.wait(1)

core.wait(1)

win.close()