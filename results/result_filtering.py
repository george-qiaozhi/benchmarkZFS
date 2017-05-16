#result_filtering.py
from numpy import *

data = loadtxt('result.txt', delimiter=',', usecols=(9,10,11,12,15,16,17,18))

#save as txt file
savetxt('table.txt', data, fmt='%d')
