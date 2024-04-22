# mouse demo
from psychopy import visual, core, event, monitors
# Set up the monitor parameters, so we can use 'deg' as the screen units
mon_mac15 = monitors.Monitor("mac15", distance=57.0, width=32.0)
mon_mac15.setSizePix([1280, 800])

# open a window
win = visual.Window([800,500],units= 'pix')

# create a mouse object
mou = event.Mouse(win = win)

# check the return value of a mouse click in a window
#while True:
_mouse = mou.getPressed() # _mouse = [0,0,0]\
count = 0
while True:
    if sum(_mouse)>0:
        print(_mouse)
        count +=1
    _mouse = mou.getPressed()
    if count == 3:
        break
    #if _mouse[0]:
    #    print('left')
    #elif _mouse[2]:
    #    print('right')
    #elif _mouse[1]:
    #    break
    #else:
    #    print('none')
core.wait(2)
win.close()