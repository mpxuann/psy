
from psychopy import visual, core, event,gui
import random as rd
import numpy as np

def run_trial(parameter,j):
    
    # draw the texture
    sti = visual.GratingStim(win, tex = None, mask = 'circle', size = 100)

    #draw the fixation
    fix = visual.GratingStim(win, tex = None, mask = 'circle', size = 10,color = [-0.8,-0.8,-0.8]) 
    
    # creating a clock for timing
    clk = core.Clock()
    
    # event in a single trial
    sti_color = parameter[0]
    sti_pos= parameter[1]
    
    sti.color = sti_color
    if sti_pos == 'left':
        sti.pos = [-200,0]
    else:
        sti.pos = [200,0]
    
    # detect whether to continue or quit
    _key = event.waitKeys(keyList = ['space','q'],timeStamped = 1) # _key = [['j',2.2316546546]]
    key_name,key_time = _key[0]
    if key_name == 'q':
        core.quit()
     
    # draw the fixation, duration = 500ms
    for i in range(60):
        fix.draw()
        win.flip()
    
    event.clearEvents()
    clk.reset()
    res = []
    # get the key response
    for i in range(120):
        sti.draw()
        fix.color = [-0.2,-0.2,-0.2]
        fix.draw()
        win.flip()
        res = event.getKeys(keyList = ['a','k'],timeStamped = clk)
        if len(res)>0:
            win.color = [0,0,0]
            win.flip()
            break
    fix.draw()
    win.flip()
    if len(res)==0:
        res = event.waitKeys(keyList = ['a','k'],timeStamped = clk)
    key,restime = res[0]
    # record the response information
    if sti_color == 'red':
        if key =='a':
            response = 'right'
        else:
            response = 'false'
    else:
        if key == 'k':
            response = 'right'
        else:
            response = 'false'
    
    trial = j+1
    # save data to datafile
    _d = f'{trial}\t{sti_color}\t{sti_pos}\t{parameter[2]}\t{key}\t{parameter[3]}\t{restime}\t{response}\n'
    data.write(_d)
    
    # clear the window, wait for the next trial
    win.color = [0,0,0]
    win.flip()


# Create dlg
dlg = gui.Dlg(title="My experiment", pos=(200, 400))
# Add each field manually
dlg.addField('No.:',tip = 'number')
dlg.addField('Name(abbreviation):')
'''
dlg.addText('Experiment blocks', color='Blue')
dlg.addField('', 45)
'''
# Call show() to show the dlg and wait for it to close (this was automatic with DlgFromDict
thisInfo = dlg.show()

if dlg.OK: # This will be True if user hit OK...
    print(thisInfo)
    num,name = thisInfo
    fileName = f'{num}_{name}.txt'
else:
    print('User cancelled') # ...or False, if they hit Cancel
    core.quit()

# open a window
win = visual.Window([1000,800],units = 'pix')

# set instruction
text = visual.TextStim(win,text = '24 trials, press space to continue, press q to quit ',pos = (0,0))
text.draw(win)
win.flip()


# creat the simplest unit
unit = np.array([['green','left','k','inc'],
                ['green','right','k','con'], 
                ['red','left','a','con'], 
                ['red','right','a','inc']])


# join the units
paramatrix = np.paramatrix = np.concatenate((unit, unit), axis=0)
for i in range(4):
    paramatrix = np.concatenate((paramatrix,unit),axis = 0)
np.random.shuffle(paramatrix)

# open a data file
data = open(fileName,'w')
data.write(f'trials\tcolor\tposition\trightKey\tkeyPressed\tcon/inc\tresponseTime\tresponse\n')

# detect whether to continue or quit
event.waitKeys(keyList = ['space']) # _key = [['j',2.2316546546]]



for i in range(24):
    parameter = paramatrix[i]
    run_trial(parameter,i)

# close the window 
win.close()
data.close()