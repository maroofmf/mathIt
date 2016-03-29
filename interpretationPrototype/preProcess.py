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
        self.listOfBreakables = ['root','bracket','longDivision']
        self.run = 0

#TODO: Develop immunity against noise due to rotation by rawData PreProcess

    def processedDictionary(self):
        if self.run == 0:
            sortedKeys = cf.findMin(self.rawData,0)
            index = 0
            for (key,garbageValue) in sortedKeys:
                self.processedData[str(index)] = self.rawData[key]
                self.processedData[str(index)].append(self.xCentOfRawData(key))
                self.processedData[str(index)].append(self.yCentOfRawData(key))
                self.processedData[str(index)].append(self.breakable(key))
                index += 1
            self.run = 1
        return(self.processedData)

    def breakable(self,key):
        if self.rawData[key][5] in self.listOfBreakables:
            return('break')
        else:
            return('no_break')


    def sortedKeyList(self):
        self.processedDictionary()
        for keys in self.processedData:
            self.sortedKeys.append(keys)
        return(sorted(self.sortedKeys))

    def xCentOfRawData(self,key):
        return((self.rawData[key][0]+self.rawData[key][1])/2)

    def yCentOfRawData(self,key):
        return((self.rawData[key][2]+self.rawData[key][3])/2)



# obj = inputDataProperties()
# a=obj.processedDictionary()
# print(a[''])
