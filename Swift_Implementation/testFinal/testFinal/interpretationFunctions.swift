/*
 Function Name: interpretationFunctions.swift
 File Name:     finalClass
 //# MARK: General Complaints
 ------------------------------------------------------------------------------------------------------------
 Description:
 This file contains all the functions necessary for the interpretation system to operate.
 
 ------------------------------------------------------------------------------------------------------------
 Function Description:
 
 (1) evaluateString : It takes a string numeric expression as the input and returns the evaluated string of Double type as the output.
 
 Usage: evaluateString("1.01+2.01")
 
 ------------X-------------
 
 
 ------------------------------------------------------------------------------------------------------------
 Settings Used:
 
 (1) symName:
 
 Symbol Naming Convention Setting for the interpretation system.
 The symName variable contains all the symbol names used for interpretation. The symName follows the information structure:
 
 symName[0] >> Numbers from [0~9]
 symName[1] >> Operators from [+,-,*,dottedDivision]
 symName[2] >> Square Root
 symName[3] >> Long Division
 symName[4] >> Brackets [,],{,},(,)
 symName[5] >> dot(.)
 ------------X-------------
 
 ------------------------------------------------------------------------------------------------------------
 Created by Maroof Mohammed Farooq on 3/31/16.
 Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
 
 */

import Foundation



public class interpretationFunctions {
    
    public var defaultValue: Int

    init(defaultValue: Int){
        self.defaultValue = defaultValue
    }
    
    //# MARK: Symbol Name Array
    public var symName = ["N","O","Root","longDivision","Bracket","dot"]
    
    //# MARK: Create a breakable only elements list
    var breakList: [String] = []
    
    //# MARK: EvaluateString
    public func evaluateString(numericExpression: String) -> Double {
        let expression = NSExpression(format: numericExpression)
        var result: Double
        result = expression.expressionValueWithObject(nil, context: nil) as! Double
        return result
    }
    
    //# MARK: Sorting Based on index Values in Ascending Order
    public func dictionarySortAscending(dataDictionary: [String:[Any]], index: Int) -> [String]{
        var dictionaryArray: [(String,Any)] = []
        var returnArray: [String]=[]
        var bufferArray: [(String,Any)] = []
        
        for (keys,values) in dataDictionary{
            dictionaryArray.append((keys,values[index]))
        }
        
        bufferArray = dictionaryArray.sort{(element1, element2) -> Bool in
            return (element1.1 as! Int) < (element2.1 as! Int)
            
        }
        
        for (keys,_) in bufferArray{
            returnArray.append(keys)
        }
        return(returnArray)
        
    }
    
    //# MARK: Calculate X Centroid
    public func xcent(inputArray: [Any]) -> Double {
        return ((anyToDouble(inputArray[0])) + (anyToDouble(inputArray[1])))/2
    }
    
    //# MARK: Calculate Y Centroid
    public func ycent(inputArray: [Any]) -> Double {
        return ((anyToDouble(inputArray[2])) + (anyToDouble(inputArray[3])))/2
    }
    
    
    //# MARK: Convert ANY to DOUBLE
    public func anyToDouble(value: Any) -> Double{
        
        let int_value = value as? Int
        let str_value = value as? String
        var double_value:Double = 0
        if let _ = int_value{
            double_value = Double(int_value!)
        }
        else if let _ = str_value{
            double_value = Double(str_value!)!
        }
        else{
            double_value = (value as! Double)
        }
        return double_value
    }
    
    //# MARK: Return sorted keys of a dictionary
    public func sortedKeys(dataDictionary: [String:[Any]]) -> [String]{
        let allKeys: [String] = Array(dataDictionary.keys)
        let sortedKeys = allKeys.sort({ (s1: String, s2: String) -> Bool in
            let s1 = Int(s1)
            let s2 = Int(s2)
            return s1 < s2
        })
        return sortedKeys
        
    }
    
    //# MARK: Pass a dictionary and the key value to find the minimum value of dictionary-value
    public func minFinder(funcDict: [String:[Any]], arrayIndex: Int) -> Int {
        var minElement = funcDict.minElement{(element1,element2) -> Bool in
            let value1 = element1.1[arrayIndex]
            let value2 = element2.1[arrayIndex]
            return (value1 as! Int) < (value2 as! Int)
        }
        
        let minElementValue = minElement!.1[arrayIndex] as! Int
        return minElementValue
    }
    
    //# MARK: Pass a dictionary and the key value to find the maximum value of dictionary-value
    public func maxFinder(funcDict: [String:[Any]], arrayIndex: Int) -> Int {
        var maxElement = funcDict.maxElement{(element1,element2) -> Bool in
            let value1 = element1.1[arrayIndex]
            let value2 = element2.1[arrayIndex]
            return (value1 as! Int) < (value2 as! Int)
        }
        
        let maxElementValue = maxElement!.1[arrayIndex] as! Int
        return maxElementValue
    }
    
    //# MARK: Find maximum value in an array
    public func maxStringArray(funcArray: [String]) -> String {
        let maxElement = funcArray.maxElement{(element1, element2) -> Bool in
            return Double(element1) < Double(element2)
        }
        return maxElement!
    }
    
    //# MARK: Sort Array Elements
    public func sortArray(funcArray: [String]) -> [String] {
        let sortedArray = funcArray.sort{(element1, element2) -> Bool in
            return Double(element1) < Double(element2)
        }
        return sortedArray
    }
    
    //# MARK: Find the elements lying under the root symbol and return the keys in sorted order
    public func underRootSearch(funcDict: [String:[Any]], rootKey: String) -> [String]{
        let x0_threshold:Double = anyToDouble(funcDict[rootKey]![0])
        let x1_threshold:Double = anyToDouble(funcDict[rootKey]![1])
        let y0_threshold:Double = anyToDouble(funcDict[rootKey]![2])
        let y1_threshold:Double = anyToDouble(funcDict[rootKey]![3])
        let dictKeys = Array(funcDict.keys)
        var returnKeys: [String] = []
        
        for keys in dictKeys{
            let xCentVal = anyToDouble(funcDict[keys]![6])
            let yCentVal = anyToDouble(funcDict[keys]![7])
            if ((xCentVal > x0_threshold) && (xCentVal < x1_threshold) && (yCentVal > y0_threshold) && (yCentVal < y1_threshold)) {
                if keys != rootKey{
                    returnKeys.append(keys)
                }
            }
        }
        returnKeys = sortArray(returnKeys)
        return returnKeys
    }
    
    //# MARK: Finding Elements in long Division
    public func longDivision(funcDict: [String: [Any]], ldKey: String) -> ([String],[String]){
        let x0_threshold:Double = anyToDouble(funcDict[ldKey]![0])
        let x1_threshold:Double = anyToDouble(funcDict[ldKey]![1])
        let y0_threshold:Double = anyToDouble(funcDict[ldKey]![2])
        let y1_threshold:Double = anyToDouble(funcDict[ldKey]![3])
        let dictKeys = Array(funcDict.keys)
        var returnTopKeys: [String] = []
        var returnBottomKeys: [String] = []
        for keys in dictKeys {
            let xCentVal = anyToDouble(funcDict[keys]![6])
            let yCentVal = anyToDouble(funcDict[keys]![7])
            if ((xCentVal > x0_threshold) && (xCentVal < x1_threshold)){
                if (yCentVal < y0_threshold) && keys != ldKey {
                    returnTopKeys.append(keys)
                } else if (yCentVal > y1_threshold) && keys != ldKey {
                    returnBottomKeys.append(keys)
                }
            }
        }
        returnTopKeys = sortArray(returnTopKeys)
        returnBottomKeys = sortArray(returnBottomKeys)
        return (returnTopKeys, returnBottomKeys)
    }
    
    //# MARK: Find Next element in dictionary
    public func nextElement(funcDict: [String:[Any]], currentKeyValue: String) -> String {
        let keyValue:[String] = sortArray(Array(funcDict.keys))
        let currentIndex: Int = keyValue.indexOf(currentKeyValue)!
        let nextIndex: Int = currentIndex + 1
        
        if nextIndex == keyValue.count {
            return "nil"
        }
        else {
            return keyValue[nextIndex]
        }
    }
}


//var a = interpretationFunctions(defaultValue: 0)
//var myDict:[String:[Any]] = {"4": [183, 190, 100, 139, ")", "Bracket"], "5": [189, 200, 90, 105, "2", "N"], "2": [150, 155, 110, 120, "+", "O"], "0": [100, 120, 100, 140, "(", "Bracket"], "1": [125, 140, 107, 135, "2", "N"], "3": [170, 185, 106, 118, "3", "N"]}
//var b = a.dictionarySortAscending(myDict, index: 0)











