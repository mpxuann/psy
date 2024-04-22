import random as rd
'''
for i in range(10):
    a = rd.gauss(0,1)
    print(a)
   
   '''
#x = [rd.gauss(0,1) for i in range(10)]
x = [800*rd.random()-400 for i in range(10)]
print(x)