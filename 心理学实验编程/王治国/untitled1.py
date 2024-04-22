from psychopy import visual, core
import numpy as np

# 创建一个窗口
win = visual.Window([800, 600],units = 'deg')

# 创建五种不同的视觉刺激
stimuli = [
    visual.GratingStim(win, sf=2, size=3, tex='sin', mask='gauss', pos=(-0.5, 0.5)),  # Gabor patch
    visual.GratingStim(win, size=3, tex=None, mask='cross', pos=(0.5, 0.5)),  # 空白刺激
    visual.GratingStim(win, size=3, tex='sqr', mask='sqr', sf=2, pos=(-0.5, -0.5)),  # 光栅图
    visual.GratingStim(win, size=3, tex='sqrXsqr', mask='circle', sf=2, pos=(0.5, -0.5)),  # 棋盘
    # visual.GratingStim(win, size=3, mask='raisedCos', tex=np.random.rand(64, 64), pos=(0, 0))  # 带mask的图片
]

# 呈现所有的刺激，每个刺激呈现3秒钟
for stim in stimuli:
    stim.draw()
win.flip()
core.wait(3)

win.close()