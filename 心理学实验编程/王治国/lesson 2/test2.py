# load libraries
from psychopy import event, visual, core

# open a window 
win = visual.Window([1000,800],units= 'pix')

# draw the sti
sti_1 = visual.Circle(win,pos = (-300,250),size = 50,color = 'red')
sti_2 = visual.Circle(win,pos = (300,250),size = 50,color = 'green')

text_A = visual.TextStim(win,text = 'A',pos = (-300,250))
text_B = visual.TextStim(win,text = 'B',pos = (300,250))

sti_1.draw(win)
text_A.draw(win)
win.flip()
core.wait(2)
