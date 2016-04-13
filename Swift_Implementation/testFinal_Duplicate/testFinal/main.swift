//
//  main.swift
//  testFinal
//
//  Created by Maroof Mohammed Farooq on 4/8/16.
//  Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
//

/*
 Tested for:
 (1) 
 
*/

import Foundation



    //# MARK: Processing Raw Data
internal func processedData(rawData: NSMutableDictionary) -> [String:[Any]]{
        var data: [String:[Any]] = [:]
        var numberOfElements = rawData.count
        var rawDataSortedKeys = dictionarySortAscending(self.rawData, index: 0)
        if processedDataRunKey == 1{
            var index = 0
            for keys in rawDataSortedKeys{
                data[String(index)] = self.rawData[keys]
                data[String(index)]!.append(xcent(data[String(index)]!))
                data[String(index)]!.append(ycent(data[String(index)]!))
                if self.breakList.contains(data[String(index)]![5] as! String){
                    data[String(index)]!.append("breakable")
                }
                else if index+1 == rawDataSortedKeys.count{
                    data[String(index)]!.append("breakable")
                }
                else {
                    data[String(index)]!.append("not_breakable")
                }
                index += 1
            }
        }
        processedDataRunKey = 0
        return data
    }



var meraDict: NSMutableDictionary = ["8": [285, 300, 85, 100, "2", "N"], "9": [305, 315, 77, 86, "2", "N"], "3": [254, 265, 120, 130, "4", "N"], "0": [220, 340, 110, 115, "/", "longDivision"], "2": [243, 253, 77, 86, "3", "N"], "7": [268, 275, 95, 100, "-", "O"], "6": [292, 310, 120, 130, "5", "N"], "1": [225, 240, 85, 103, "3", "N"], "5": [278, 290, 121, 131, "0", "N"], "4": [270, 275, 127, 131, ".", "O"]]
//["2":[1,2,3],"4":[6,7,6,5],"1":[3,5,5],"3":[10,11]]
//var meraObj = interpretation(rawData: meraDict)
//var c = meraObj.evaluate()
//print(c)

var objVal = interpretationFunctions(defaultValue: 0)
//var a = objVal.dictionarySortAscending(["18": [285, 300, 85, 100, "2", "N"], "9": [305, 315, 77, 86, "2", "N"], "3": [254, 265, 120, 130, "4", "N"], "0": [220, 340, 110, 115, "/", "longDivision"]], index: 0)
//var a = objVal.maxFinder(meraDict, arrayIndex: 0)
var a = objVal.underRootSearch([], rootKey: "0")
// var a = objVal.anyToDouble(0.02)
print(a)













//
//["0" : [1,5, 3213, 3263,"-","O"];
//
//    "1" :[1,2,3196,3197,"-","O"];
//
//    "10" :[1127,1228,1264,1633,"4","N"];
//
//"2":[1314,1321,3193,3208,"-","O"];
//
//"3":[1420,1429,2898,
//    
//    2920,
//    
//    "-",
//    
//    O
//    
//);
//
//4 =     (
//    
//    507,
//    
//    512,
//    
//    2859,
//    
//    2864,
//    
//    "-",
//    
//    O
//    
//);
//
//5 =     (
//    
//    1389,
//    
//    1394,
//    
//    1772,
//    
//    1777,
//    
//    "-",
//    
//    O
//    
//);
//
//6 =     (
//    
//    1326,
//    
//    1424,
//    
//    1491,
//    
//    1530,
//    
//    "-",
//    
//    O
//    
//);
//
//7 =     (
//    
//    1316,
//    
//    1408,
//    
//    1425,
//    
//    1453,
//    
//    "-",
//    
//    O
//    
//);
//
//8 =     (
//    
//    944,
//    
//    1025,
//    
//    1416,
//    
//    1610,
//    
//    "+",
//    
//    O
//    
//);
//
//9 =     (
//    
//    766,
//    
//    880,
//    
//    1343,
//    
//    1698,
//    
//    3,
//    
//    N
//    
//);
//
//}
