'''
Phase # 2
'''

import inputData
import customFunctions as cf

'''

-The preProcess step performs the following operations on the input data:
    1. Normalizes the co-ordinates such that the noise due to rotation is filtered out
    2. Calculates centroids and checks if the element is breakable or not
    3. Assigns proper key values to dicitonary. The key values are strings containing numbers based on increasing order
    of the x co-ordinates

-------------------------------------------------------------------------------------------------------------------------

Outputs:
    1. Sorted Key List of the dictionary:
    use -> inputDataProperties.sortedKeyList()

    2. Processed Dictionary:
    use -> inputDataProperties.processedDictionary()

-------------------------------------------------------------------------------------------------------------------------

Warning:

Using processedDictionary multiple times may yield wrong dictionary formation.

'''

class inputDataProperties():

    def __init__(self):
        self.rawData = inputData.data()
        self.processedData = {}
        self.sortedKeys = []
        self.processedData1 = {}
        self.listOfBreakables = ['Root','Bracket','longDivision']
        self.run = 0
        self.dictLength = len(self.rawData.keys())
        self.lastElementKey = ''

#TODO: Develop immunity against noise due to rotation by rawData PreProcess

    def processedDictionary(self):
        if self.run == 0:
            sortedKeys = cf.findMin(self.rawData,0)
            self.lastElementKey = sortedKeys[-1][0]
            index = 0
            for (key,garbageValue) in sortedKeys:
                self.processedData[str(index)] = self.rawData[key]
                self.processedData[str(index)].append(self.xCentOfRawData(key))
                self.processedData[str(index)].append(self.yCentOfRawData(key))
                self.processedData[str(index)].append(self.breakable(key))
                index += 1
            self.run = 1
        print('this:',self.processedData)
        return(self.processedData)

    def breakable(self,key):
        if self.rawData[key][5] in self.listOfBreakables or self.lastElementKey == key:
            return('break')
        else:
            return('no_break')


    def sortedKeyList(self):
        bufferList = []
        self.processedDictionary()
        for keys in self.processedData:
            self.sortedKeys.append(keys)

        [bufferList.append(int(i)) for i in self.sortedKeys]
        bufferList = sorted(bufferList)
        self.sortedKeys = []
        [self.sortedKeys.append(str(i)) for i in bufferList]
        return(self.sortedKeys)

    def xCentOfRawData(self,key):
        return((self.rawData[key][0]+self.rawData[key][1])/2)

    def yCentOfRawData(self,key):
        return((self.rawData[key][2]+self.rawData[key][3])/2)


# obj = inputDataProperties()
# a=obj.processedDictionary()
# print(a['19'])



