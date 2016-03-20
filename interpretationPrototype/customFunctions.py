import math

'''Function to find the MAX value of a particular element in value array. Returns keys in order '''
def findMax(dict,index):
    dictLength = len(dict)
    tupleArray =[]
    for keys,vals in dict.items():
        tupleArray.append((keys,vals[index]))
    return sorted(tupleArray, key= lambda tupleArray:tupleArray[1], reverse=True)

'''Function to find the MIN value of a particular element in value array. Returns keys in order '''

def findMin(dict,index):
    dictLength = len(dict)
    tupleArray =[]
    for keys,vals in dict.items():
        tupleArray.append((keys,vals[index]))
    return sorted(tupleArray, key= lambda tupleArray:tupleArray[1])

def findUpperIndices(dict, index):
    xThresholdLeft = dict[index][0]
    xThresholdRight = dict[index][1]
    yThreshold = dict[index][3]
    upperIndices = []
    for keys in dict():
        if dict[keys][0] > xThresholdLeft and dict[keys][1] < xThresholdRight and dict[keys][3] < yThreshold:
            upperIndices.append(keys)
    return(upperIndices)

def findLowerIndices(dict, index):
    xThresholdLeft = dict[index][0]
    xThresholdRight = dict[index][1]
    yThreshold = dict[index][3]
    lowerIndices = []
    for keys in dict():
        if dict[keys][0] > xThresholdLeft and dict[keys][1] < xThresholdRight and dict[keys][3] > yThreshold:
            lowerIndices.append(keys)
    return(lowerIndices)

def findBaseLine(dict,indexRange,index):
    tupleArray =[]
    for keyValue in indexRange:
        tupleArray.append(dict[keyValue][index])
    return(max(tupleArray))

def sortedKeyArray(dict):
        keyArray = dict.keys()
        sortedKeyArray = sorted(list(keyArray))
        return(sortedKeyArray)

#TODO: Imporve Lexer Rules
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



