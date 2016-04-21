import matplotlib.pyplot as plt
import numpy as np
import math
import scipy.special
from scipy.stats import chisquare
import random
import customFunctions as cf
from collections import defaultdict

class pleaseDontKillMe:

    def __init__(inputDictionary):
        self.data = inputDictionary
        self.d2 = defaultdict(list)
        self.upperIndices = []
        self.keys = ''

    def d2form(self):
        index=0
        for self.keys in self.data:
            if self.data[8] == 'nb':
                d2[str(index)].append(self.keys)
            if self.data[8] == 'b' :
                d2[str(index)].append('a')
                index +=1
                if self.data[5] == 'longDivision':
                    self.upperIndices = cf.findUpperIndices(self.data, self.keys)
                    self.lowerIndices = cf.findLowerIndices(self.data,self.keys)

        self.breakTest()

    def breakTest(self):



