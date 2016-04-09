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
        finalExpression  = ''
        if self.data[self.key][5] == 'N':
            self.keyRange.append(self.key)
            finalExpression = (self.stringGenerator(self.keyRange))

        elif self.data[self.key][5] == 'Root':
            keyRangeString = ''
            previousKey = max(self.keyRange)
            rootValue = 2

            if self.data[previousKey][5] == 'N':
                rootKeyValue = previousKey
                rootValue = float(self.data[rootKeyValue][4])
                self.keyRange.pop(self.keyRange.index(str(rootKeyValue)))
            try:
                keyRangeString = self.stringGenerator(self.keyRange)
            except:
                settings.logger.debug('Empty keyRange due to small value')
            x0 = self.data[self.key][0]
            x1 = self.data[self.key][1]
            underRootElements = cf.searchDictionary(x0,x1,self.data)
            underRootElements = cf.sortStringList(underRootElements)
            underRoot = eval(self.stringGenerator(underRootElements))
            finalExpression = keyRangeString + str(pow(underRoot,1/rootValue))
            for rootElements in underRootElements:
                self.skipList.append(rootElements)

        elif self.data[self.key][5] == 'longDivision':
            keyRangeString = ''
            try:
                keyRangeString = self.stringGenerator(self.keyRange)
                [self.skipList.append(i) for i in self.keyRange]
            except:
                settings.logger.debug('Empty keyRange due to small value')

            topElements, bottomElements = cf.longDivisionFind(self.key,self.data)
            topString = self.stringGenerator(topElements)
            bottomString = self.stringGenerator(bottomElements)
            finalExpression = keyRangeString +'('+ topString + ')'+'/'+'('+bottomString+')'
            [self.skipList.append(i) for i in bottomElements]
            [self.skipList.append(i) for i in topElements]

        elif self.data[self.key][5] == 'Bracket':
            keyRangeString=''
            self.skipList.append(self.key)
            if self.data[self.key][4] in ['(','{','[']:
                try:
                    keyRangeString = self.stringGenerator(self.keyRange)
                    [self.skipList.append(i) for i in self.keyRange]
                except:
                    settings.logger.debug('Empty keyRange due to small value')
                finalExpression = keyRangeString
            else:
                try:
                    nextKey = str(int(self.key)+1)
                    #TODO: nextKey should be choosen carefully in cases when we have complex
                    if self.data[nextKey][5] == 'N':
                        finalExpression = str(pow(eval(self.stringGenerator(self.keyRange)), int(self.data[nextKey][4])))
                        self.skipList.append(nextKey)
                        [self.skipList.append(i) for i in self.keyRange]
                    else:
                        finalExpression = self.stringGenerator(self.keyRange)
                        [self.skipList.append(i) for i in self.keyRange]
                except:
                    settings.logger.debug('Running Exception becuase last element is a bracket')
                    # finalExpression = self.stringGenerator(self.keyRange)
                    [self.skipList.append(i) for i in self.keyRange]
        print(finalExpression)
        return(finalExpression)

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
        print('TempDict:',tempDict)
        finalExpression = ''
        sortedKeys = cf.sortStringList(tempDict)
        for keys in sortedKeys:
            if tempDict[keys][5] == 'N':
                try:
                    testIndex = sortedKeys[sortedKeys.index(keys)+1]
                    if tempDict[str(testIndex)][12] == 'superscript':
                        finalExpression = finalExpression + cf.lexer(1,tempDict,[keys,str(testIndex)])
                        sortedKeys.pop(sortedKeys.index(str(testIndex)))
                    elif tempDict[keys][12] == 'baseline':
                        finalExpression = finalExpression + tempDict[keys][4]
                except:
                    settings.logger.debug('Exception occured while testing for keyindex +1')
                    finalExpression = finalExpression + tempDict[keys][4]

            if tempDict[keys][5] == 'O':
                finalExpression = finalExpression + tempDict[keys][4]
        return(finalExpression)


# daa = inputData.data()
# baa ={}
# for i in ['0','1','2','3','4','5']:
#     baa[i] = daa[i]
#
# obj = breakAnalyser('4',['1','2','3'],baa,[])
# a=obj.pathRouting()
# print(a)
