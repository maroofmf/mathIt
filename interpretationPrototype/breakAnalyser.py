import inputData
import customFunctions as cf
import preProcess
import stringGenRules

class breakFactory():
    def __init__(self,key,data,skipList):
        self.key = key
        self.data = data
        self.breakType = self.data[key][5]
        self.skipList = skipList

    def test(self):
        self.testPrint()


newObj = breakFactory()
newObj.test()
