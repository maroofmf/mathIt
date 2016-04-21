''' Import Libraries '''

import matplotlib.pyplot as plt
import numpy as np
import math
import scipy.special
from scipy.stats import chisquare
import random
import sys

''' Functions '''

# Returns Keys
def findMax(dict,index):
    dictLength = len(dict)
    tupleArray =[]
    for keys,vals in dict.items():
        tupleArray.append((keys,vals[index]))
    return max(tupleArray, key= lambda tupleArray:tupleArray[1])[0]

def findMin(dict,index):
    dictLength = len(dict)
    tupleArray =[]
    for keys,vals in dict.items():
        tupleArray.append((keys,vals[index]))
    return min(tupleArray, key= lambda tupleArray:tupleArray[1])[0]

def findSubExpression(dataDict,index):
    subExpList = []
    for keys in dataDict:
        if dataDict[keys][0] > dataDict[index][0] and dataDict[keys][1] < dataDict[index][1] and dataDict[keys][8] == 'b':
            subExpList.append(keys)
    return(subExpList)

def lexer(type,dataDict,indexArray):

    # type 1 : number^number
    if type ==1:
        return(str(pow(int(dataDict[indexArray[0]][4]),int(dataDict[indexArray[1]][4]))))

    # type 2 : sqrt(a,b)
    if type ==2:
            if len(indexArray) == 2:
                return str(pow(int(dataDict[indexArray[0]][4]),1/(int(dataDict[indexArray[0]][4]))))
            else:
                return str(pow(int(dataDict[indexArray[0]][4]),(1/2)))

''' Initilize Variables: '''

dataStore={};
a=[]
yArray = []
xArray = []
baseLineElements = []
unclassifiedElements = []
finalExpression = ''

#TODO: Classification of OCR Recognized symbols



'''
Import Data
Dictionary Structure >>  key : [x1, x2, y1, y2, symbol, symbolType, x_centroid, y_centroid, baseLineElement(b/u)]
key value of dictionary is selected based on sorted x1 values
'''

x1 = [652,738,775,870,962,1111,1339,1410,1472,1550];
x2= [709,788,825,1111,1062,1174,1389,1440,1537,1572];
y1 = [402,366,460,384,420,445,425,481,448,441];
y2 = [505,432,479,520,506,523,527,507,529,533];
symbol = ['9','0','-','root','5','-','7','.','0','1'];
symbolType = ['n','n','o','root','n','o','n','o','n','n'];




''' Select Data Structure: '''

for i in range(0,len(x1)):
    dataStore[str(i)] = [x1[i],x2[i],y1[i],y2[i],symbol[i],symbolType[i]]
    dataStore[str(i)].append((x1[i]+x2[i])/2)
    dataStore[str(i)].append((y1[i]+y2[i])/2)
    a.append(-dataStore[str(i)][7])


# print(a)
# plt.plot(range(0,len(a)),a)
# plt.show()

''' Find Baseline Elements: '''

dominantElement = str(findMin(dataStore,0))
# print(dominantElement)
topThreshold = dataStore[str(findMin(dataStore,2))][2]
# print(topThreshold)
bottomThreshold = dataStore[str(findMax(dataStore,3))][3]
# print(bottomThreshold)

for keys in dataStore:
    yArray.append((topThreshold/dataStore[keys][3]))
    xArray.append((bottomThreshold/dataStore[keys][7]))


# plt.scatter([1]*len(yArray),yArray)
# plt.show()

for keys in dataStore:
    testValue = topThreshold/(dataStore[keys][3])
    if testValue < 0.8:
        dataStore[keys].append('b')
    else:
        dataStore[keys].append('u')

''' String Formation '''
dataKeys = []
dataKeys = list(dataStore.keys())
dataKeys = sorted(dataKeys)

for keys in dataKeys:
    if dataStore[keys][5] == 'n':
        try:
            testIndex = int(keys) +1
            if dataStore[str(testIndex)][8] == 'u':
                finalExpression = finalExpression + lexer(1,dataStore,[keys,str(testIndex)])
            elif dataStore[keys][8] == 'b':
                finalExpression = finalExpression + dataStore[keys][4]
        except:
            finalExpression = finalExpression + dataStore[keys][4]

    if dataStore[keys][5] == 'root':
        subKeys = findSubExpression(dataStore,keys)
        subKeys = subKeys[0]
        try:
            if dataStore[keys-1][8] == 'u':
                finalExpression = finalExpression + lexer(2,dataStore,[subKeys,keys-1])
            else:
                finalExpression = finalExpression + lexer(2,dataStore,[subKeys])
        except:
                finalExpression = finalExpression + lexer(2,dataStore,[subKeys])


    if dataStore[keys][5] == 'o':
        finalExpression = finalExpression + dataStore[keys][4]

''' Output '''

print(eval(finalExpression))













