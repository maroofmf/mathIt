import inputData
import customFunctions as cf
import preProcess
import stringGenRules
# import stringFormation
import preProcess as pp
import settings

'''
There are 4 kinds of breaks:
- sqrt
- long division
- last element
- open brackets (,{,[
- close brackets ),},]

Each break should be handled seperately.

1. For last element simple return the string! -- Done

2. For sqrt:
    (i) Check if the previous element is the nth root term! (Assumption: If the previous term is a superscript then use that as the n'th
    term.) Default Root term = 2
    (ii) Find all the elements lying in the root term.
    (iii) Evaluate the root

3. For long Division:




'''

#TODO: Work to generalize the 1st conditon on sqrt.
#TODO:


class breakAnalyser():
    def __init__(self,key,keyRange,data,skipList):
        self.key = key
        self.data = data
        self.breakType = self.data[key][5]
        self.skipList = skipList
        self.keyRange = keyRange

    def pathRouting(self):
        if self.data[self.key][5] == 'n':
            return(self.stringGenerator(self.keyRange))

        elif self.data[self.key][5] == 'root':
            previousKey = max(self.keyRange)
            rootValue = 2

            if self.data[previousKey][5] == 'n':
                rootKeyValue = previousKey
                rootValue = int(self.data[rootKeyValue][4])
                self.keyRange.pop(self.keyRange.index(str(rootKeyValue)))
            try:
                keyRangeString = self.stringGenerator(self.keyRange)
            except:
                keyRangeString = ''
                settings.logger.debug('Empty keyRange due to small value')
            x0 = self.data[self.key][0]
            x1 = self.data[self.key][1]
            underRootElements = cf.searchDictionary(x0,x1,self.data)
            underRoot = eval(self.stringGenerator(underRootElements))
            finalExpression = keyRangeString + str(pow(underRoot,1/rootValue))

        # elif self.data[self.key][5] == 'root':




    def classificationEngine(self,tempDict):

        #TODO: More robost classification required
        topThreshold = cf.findMin(tempDict,2)[0][1]
        bottomThreshold = cf.findMax(tempDict,3)[0][1]
        totalRange = abs(topThreshold-bottomThreshold)
        for keys in tempDict:
            tempDict[keys].append(abs(topThreshold-tempDict[keys][2])/totalRange)
            tempDict[keys].append(abs(tempDict[keys][2]-tempDict[keys][3])/totalRange)
            tempDict[keys].append(abs(bottomThreshold-tempDict[keys][3])/totalRange)
            discValue = -0.7*tempDict[keys][9]-0.4*tempDict[keys][10]+0.8*tempDict[keys][11]+0.1
            if discValue<0:
                tempDict[keys].append('baseline')
            else:
                tempDict[keys].append('superscript')
            tempDict[keys].append(discValue)
        return(tempDict)


    def stringGenerator(self,keyRange):
        tempDict = {}
        for keys in keyRange:
            tempDict[keys] = self.data[keys]

        tempDict = self.classificationEngine(tempDict)
        finalExpression = ''
        sortedKeys = cf.sortedKeyArray(tempDict)
        for keys in sortedKeys:
            if tempDict[keys][5] == 'n':
                try:
                    testIndex = int(keys) +1
                    if tempDict[str(testIndex)][12] == 'superscript':
                        finalExpression = finalExpression + cf.lexer(1,tempDict,[keys,str(testIndex)])
                        sortedKeys.pop(sortedKeys.index(str(testIndex)))
                    elif tempDict[keys][12] == 'baseline':
                        finalExpression = finalExpression + tempDict[keys][4]
                except:
                    settings.logger.debug('Exception occured while testing for keyindex +1')
                    finalExpression = finalExpression + tempDict[keys][4]

            if tempDict[keys][5] == 'o':
                finalExpression = finalExpression + tempDict[keys][4]
        return(finalExpression)



obj = pp.inputDataProperties()
dictA = obj.processedDictionary()
[dictA.pop(i) for i in ['1','2','5','6','7','8','9']]

testCase = breakAnalyser('3',['0'],dictA,[])
testCase.pathRouting()