'''
PHASE # 3
'''

import inputData
import customFunctions as cf
import preProcess
import stringGenRules
import breakAnalyser

'''
This class breaks the preprocessed data into small chunks of key values that will be used to format strings.

-------------------------------------------------------------------------------------------------------------------------
Data Present:
self.dataObject --> Data object created from the class inputDataProperties
self.data --> Input Data
self.keyList --> Sorted Key List of base dictionary
self.famousD2 --> [key: abstract_dictionary]

-------------------------------------------------------------------------------------------------------------------------
Methods:


-------------------------------------------------------------------------------------------------------------------------
Inputs:

-------------------------------------------------------------------------------------------------------------------------
Outputs:

'''

class stringFormation:
    def __init__(self):
        self.dataObject = preProcess.inputDataProperties()
        self.data = self.dataObject.processedData  #Sould be called only once! #TODO: Generalize processedData such that it can be called n times
        self.keyList = self.dataObject.sortedKeyList()
        self.famousD2 = {}
        self.processID = {}
        self.index = 0
        self.skipList = []

    def d2Formation(self):
        index = 0
        evaluatedString = ''
        keyRange = []
        dupKeyList = self.keyList
        for keys in dupKeyList:
            if keys in self.skipList:
                continue
            if self.data[keys][8] == 'break':
                newObject = breakAnalyser.breakAnalyser(keys,keyRange,self.data,self.skipList)
                evaluatedString +=  newObject.pathRouting()
                self.skipList = newObject.skipList
                # self.famousD2[str(index)] = self.abstractDataType(keyRange)
                keyRange = []
                index += 1

            else:
                keyRange.append(keys)
        print(eval(evaluatedString))

obj = stringFormation()
obj.d2Formation()

