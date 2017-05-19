#result_filtering.py
from numpy import *

# W/ CPU usage
#data = loadtxt('result.txt', delimiter=',', usecols=(9,10,11,12,15,16,17,18))
# W/O CPU usage
data = loadtxt('result.txt', delimiter=',', usecols=(9,11,15,17), dtype=None)

#save as txt file
savetxt('table.txt', data, fmt='%d')
