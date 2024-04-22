
from psychopy import visual, core, event,gui
import random as rd
import numpy as np

def _quit():
    text = visual.TextStim(win,text = 'quiting...',pos = (0,0))
    text.draw()
    text.size+=(0.5,0.5)
    win.flip()
    core.wait(1)
    core.quit()

# Create dlg
dlg = gui.Dlg(title="My experiment", pos=(200, 400))
# Add each field manually
dlg.addText('Subject Info', color='Blue')
dlg.addField('No.:')
dlg.addField('Name:', tip='or subject code')
dlg.addField('trials:', 100)
'''
dlg.addText('Experiment blocks', color='Blue')
dlg.addField('', 45)
'''
# Call show() to show the dlg and wait for it to close (this was automatic with DlgFromDict
thisInfo = dlg.show()

if dlg.OK: # This will be True if user hit OK...
    print(thisInfo)
    num, name, trials = thisInfo
    fileName = f'{num}_{name}_{trials}.csv'
else:
    print('User cancelled') # ...or False, if they hit Cancel
    core.quit()

mou = event.Mouse()
mou.setVisible(0)
# open a window
win = visual.Window(fullscr = True,units = 'pix')

event.Mouse(visible = False)
# show the instruction

ins = visual.TextStim(win,text = 'if you are ready, press \'space\' to start',pos = (0,0)) 
ins.size += (10.50)
ins.draw()
win.flip()
res = event.waitKeys(keyList = ['space','q'],timeStamped = 1)
key , offtime = res[0]
win.flip()
if key == 'q':
    _quit()

# draw the texture
sti = visual.GratingStim(win, tex = None, mask = 'circle',
                        size = 100)
      
# creating a clock for timing
clk = core.Clock()

# open a data file
data = open(fileName,'w')
data.write(f'trial\tname\tkeyPressed\tresponseTime\tcolor\tresponse\n')

unit = np.array([['red'],
                 ['green']])
paramatrix = unit


for j in range(int(trials/2)-1):
    paramatrix = np.concatenate((paramatrix,unit),axis = 0)
np.random.shuffle(paramatrix)

for j in range(trials):
    # event in a single trial
    # show the target disk
    sti_color = paramatrix[j,0]
    sti.color = sti_color
    x = 2460*rd.random()-1230
    y = 1500*rd.random()-750
    sti.pos = [x,y]
    
    core.wait(1+2*rd.random())
    # get the start time 
    #onset = core.getAbsTime()
    event.clearEvents()
    clk.reset()
    
    # get the key response
    for i in range(120):
        sti.draw()
        win.flip()
        res = event.getKeys(keyList = ['space'],timeStamped = clk)
        if len(res)>0:
            key,restime = res[0]
            break
        
  
    
    # record the response information
    if sti_color == 'red':
        if len(res)==0:
            response = 'miss'
        else:
            response = 'hit'
    else:
        if len(res)>0:
            response = 'false alarm'
        else:
            response = '(green no response)'
    
    if len(res)==0:
        key = 'nan'
        restime = 'nan'
    # save data to datafile
    _d = f'{j+1}\t{name}\t{key}\t{restime}\t{sti_color}\t{response}\n'
    data.write(_d)

    # clear the window, wait for the next trial
    win.color = [0,0,0]
    win.flip()
    

core.wait(1)
# close the window 
win.close()
data.close()