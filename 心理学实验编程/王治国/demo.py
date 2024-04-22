from psychopy import visual, core, event

# open a window

from psychopy import monitors

mon_mac15 = monitors.Monitor("mac15", distance=57.0, width=32.0)
mon_mac15.setSizePix([1920, 1080])
win = visual.Window([1000, 800], monitor=mon_mac15, units="deg")


# draw a gabor
gabor = visual.GratingStim(win, sf = 2, size = 3, tex = 'sin', mask = 'gauss')

sqrXsqr = visual.GratingStim(win, sf = 2, size = 3, tex = 'sqrXsqr', mask = 'circle',pos=(3,3) )

blank = visual.GratingStim(win, sf = 2, size = 3, tex = None, mask = 'cross',pos=(3,-3))

gabor2 = visual.GratingStim(win, sf = 2, size = 3, tex = 'sqr', mask = None,pos = (-3,3))

picture = visual.GratingStim(win, sf =2 ,size = 3,tex = 'texture.png',mask = 'raisedCos',pos=(-3,-3))


while not event.getKeys():
    gabor.draw()
    gabor2.draw()
    sqrXsqr.draw()
    blank.draw()
    picture.draw()
    win.flip()

core.wait(1.0)

win.close()