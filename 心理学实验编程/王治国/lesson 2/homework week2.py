# load libraries
from psychopy import event, visual, core

# open a window 
win = visual.Window([1000,800],units= 'pix')

# set instruction
text = visual.TextStim(win,text = '10 trials, press space to continue, press q to quit ',pos = (0,0))
text.draw(win)
win.flip()

# draw the sti
sti_1 = visual.Circle(win,pos = (-300,250),size = 50,color = 'red')
sti_2 = visual.Circle(win,pos = (300,250),size = 50,color = 'green')

# draw the text
text_A = visual.TextStim(win,text = 'A',pos = (-300,250))
text_B = visual.TextStim(win,text = 'B',pos = (300,250))

# class mouse 
mou = event.Mouse()

# 10 trials
for i in range(10):
   
    # detect whether to continue or quit
    _key = event.waitKeys(timeStamped = 1) # _key = [['j',2.2316546546]]
    key_name, key_time = _key[0]
    if key_name == 'q':
        text = visual.TextStim(win,text = 'quiting... ',pos = (0,0))
        text.draw()
        win.flip()
        core.wait(1)
        break
    elif key_name == 'return':
        continue
    
    # setPos
    mou.setPos()
    pos = [mou.getPos()]
    
    while True:
        
        sti_1.draw()
        sti_2.draw()
        text_A.draw()
        text_B.draw()
        
        # draw the script of mouse 
        _mov = mou.mouseMoved(distance = 1)
        if _mov:
            _pos = mou.getPos()
            pos.append(_pos)
        if len(pos)>2:
            shape = visual.ShapeStim(win,vertices = pos, fillColor = 'black',closeShape = False)
            shape.draw()
        win.flip()
        
        # detect the click motion of mouse
        if mou.isPressedIn(sti_1,buttons = [0]):
            print('A')
            break
        if mou.isPressedIn(sti_2,buttons = [0]):
            print('B')
            break
    
    # refresh the window
    win.flip()     
        
    
# close the window
core.wait(1)
win.close()