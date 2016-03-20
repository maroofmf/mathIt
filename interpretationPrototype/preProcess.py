import inputData
import customFunctions as cf

class inputDataProperties():

    def __init__(self):
        self.rawData = inputData.data()
        self.processedData = {}
        self.sortedKeys = []
        self.listOfBreakables = ['root','bracket','longDivision']

#TODO: Develop immunity against noise due to rotation by rawData PreProcess

    def processedDictionary(self):
        sortedKeys = cf.findMin(self.rawData,0)
        index = 0
        for (key,garbageValue) in sortedKeys:
            self.processedData[str(index)] = self.rawData[key]
            self.processedData[str(index)].append(self.xCentOfRawData(key))
            self.processedData[str(index)].append(self.yCentOfRawData(key))
            self.processedData[str(index)].append(self.breakable(key))
            index += 1
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
