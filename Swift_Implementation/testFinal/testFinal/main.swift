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

var meraDict:[String:[Any]] = ["0": [220, 340, 110, 115, "/", "longDivision"], "9": [305, 315, 77, 86, "2", "N"], "2": [243, 253, 77, 86, "3", "N"], "8": [285, 300, 85, 100, "2", "N"], "6": [292, 310, 120, 130, "5", "N"], "3": [254, 265, 120, 130, "5", "N"], "1": [225, 240, 85, 103, "3", "N"], "5": [278, 290, 121, 131, "0", "N"], "4": [270, 275, 127, 131, ".", "O"], "7": [268, 275, 95, 100, "-", "O"]]



var meraObj = interpretation(rawData: meraDict)
var c = meraObj.evaluate()
print(c)
