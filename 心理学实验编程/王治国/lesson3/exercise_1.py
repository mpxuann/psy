
from psychopy import visual, core, event,gui
import random as rd

# Create dlg
dlg = gui.Dlg(title="My experiment", pos=(200, 400))
# Add each field manually
dlg.addText('Subject Info', color='Blue')
dlg.addField('No.:',tip = 'participant #')
dlg.addField('Name:', tip='or subject code')
dlg.addField('Age:', 21)
'''
dlg.addText('Experiment blocks', color='Blue')
dlg.addField('', 45)
'''
# Call show() to show the dlg and wait for it to close (this was automatic with DlgFromDict
thisInfo = dlg.show()

if dlg.OK: # This will be True if user hit OK...
    print(thisInfo)
    num, name, age = thisInfo
    fileName = f'{num}_{name}_{age}.csv'
else:
    print('User cancelled') # ...or False, if they hit Cancel
    core.quit()

# open a window
win = visual.Window(units = 'pix')

# draw the texture
sti = visual.GratingStim(win, tex = None, mask = 'circle',
                        size = 100)
      
# creating a clock for timing
clk = core.Clock()

# open a data file
data = open(fileName,'w')
data.write(f'keyPressed\tresponseTime\tcolor\n')
for i in range(3):
    # event in a single trial
    # show the target disk
    sti_color = rd.choice(['red','green'])
    sti.color = sti_color
    sti.draw()
    win.flip()
    
    # get the start time 
    #onset = core.getAbsTime()
    clk.reset()
    
    # get the key response
    res = event.waitKeys(keyList = ['f','j'],timeStamped = clk)
    key,restime = res[0]
    
    # save data to datafile
    _d = f'{key}\t{restime}\t{sti_color}\n'
    data.write(_d)

    # clear the window, wait for the next trial
    win.color = [0,0,0]
    win.flip()
    core.wait(2*rd.random())


# close the window 
win.close()
data.close()