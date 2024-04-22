# file I/O demo
'''
# open a file
f = open('demo.txt','w')

# write a line into a file
for i in range(10):
    f.write(f'this is line #{i}\n')

# close the file
f.close()
'''
f2 = open('demo.txt','r')
'''
for _line in f2:
    print(_line)
'''

'''
for _line in f2:
    _d = _line.split()
    print(_d)
'''
