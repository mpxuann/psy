# GUI DEMO for informations of participants
from psychopy import 
# Create dlg
dlg = gui.Dlg(title="My experiment", pos=(200, 400))
# Add each field manually
dlg.addText('Subject Info', color='Blue')
dlg.addField('Name:', tip='or subject code')
dlg.addField('Age:', 21)
dlg.addText('Experiment Info', color='Blue')
dlg.addField('', 45)
# Call show() to show the dlg and wait for it to close (this was automatic with DlgFromDict
thisInfo = dlg.show()

if dlg.OK: # This will be True if user hit OK...
    print(thisInfo)
else:
    print('User cancelled') # ...or False, if they hit Cancel