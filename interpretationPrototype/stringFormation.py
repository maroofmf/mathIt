import inputData
import customFunctions as cf
import preProcess
import stringGenRules

class evaluationPhase:
    def __init__(self):
        self.dataObject = preProcess.inputDataProperties()
        self.data = self.dataObject.processedData
        self.keyList = self.dataObject.sortedKeyList()
        self.famousD2 = {}

    def d2Formation(self):
        index = 0
        keyRange = []
        dupKeyList = self.keyList
        for keys in dupKeyList:
            if self.data[keys][8] == 'break':
                self.breakTest(keys)
                self.famousD2[str(index)] = self.abstractDataType(keyRange)
                keyRange = []
                index += 1
            elif int(keys) == len(self.data)-1:
                keyRange.append(keys)
                self.famousD2[str(index)] = self.abstractDataType(keyRange)
                keyRange = []
            else:
                keyRange.append(keys)

    def breakTest(self,keys):
        if self.data[keys][5] == 'root':
            try:
                faithfullIndex = str(int(keys)-1)
                tempDict[keys] = self.data[keys]
                tempDict[faithfullIndex] = self.data[faithfullIndex]




    def abstractDataType(self,keyRange):
        abstractDict = {}
        abstractDict['keyValues'] = keyRange
        abstractDict['Status'] = 'active'
        abstractDict['baseline'] = cf.findBaseLine(self.data,keyRange,3)
        abstractDict['stringOutput'] = self.stringGenerator(keyRange)
        return(abstractDict)

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
        print(tempDict)
        finalExpression = ''
        sortedKeys = cf.sortedKeyArray(tempDict)
        for keys in sortedKeys:
            if tempDict[keys][5] == 'n':
                try:
                    testIndex = int(keys) +1
                    if tempDict[str(testIndex)][12] == 'superscript':
                        finalExpression = finalExpression + cf.lexer(1,tempDict,[keys,str(testIndex)])
                    elif tempDict[keys][12] == 'baseline':
                        finalExpression = finalExpression + tempDict[keys][4]
                except:
                    print('Exception occured while testing for keyindex +1')
                    finalExpression = finalExpression + tempDict[keys][4]

            if tempDict[keys][5] == 'o':
                finalExpression = finalExpression + tempDict[keys][4]
        return(finalExpression)












obj = evaluationPhase()
obj.d2Formation()

