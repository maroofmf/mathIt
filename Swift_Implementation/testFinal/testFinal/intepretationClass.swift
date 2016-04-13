/*
 Class Name: interpretationClass.swift
 File Name:     finalClass
 //# MARK: General Complaints
 //# TODO: Documentation
 ------------------------------------------------------------------------------------------------------------
 Description:
 The interpretation class takes input from OCR stage and produces the evaluated mathematical expression.
 
 ------------------------------------------------------------------------------------------------------------
 Variables Used:
 
 (1) rawData:
 
 Description: Data in the form of a dictonary that contains the mathmatical expression to be processed.
 
 Data Structure: Dictionary ---> [String:Any]. Generally the key value of raw data is a string integer from 0 to N where N is the total number of mathematical elements in the expression.
 
 Scope: Global. Use self.rawData to acess the data within the class.
 
 Data: In rawData we have detailed information of each mathematical element in the expression.
 
 Example:   rawData["0"] ====> [100,110,120,140,"2",symName[0]]
 
 DataType:  rawData["0"] ====> [Int,Int,Int,Int,String,String]
 
            Data:      rawData["0"]?[0] ====> X0
                       rawData["0"]?[1] ====> X1
                       rawData["0"]?[2] ====> Y0
                       rawData["0"]?[3] ====> Y1
                       rawData["0"]?[4] ====> RecognizedSymbol
                       rawData["0"]?[5] ====> SymbolType
 
                            -----------------X----------------------
 
 (2) processedData:
 
          Data:      processedData["0"]?[0] ====> X0
                     processedData["0"]?[1] ====> X1
                     processedData["0"]?[2] ====> Y0
                     processedData["0"]?[3] ====> Y1
                     processedData["0"]?[4] ====> RecognizedSymbol
                     processedData["0"]?[5] ====> SymbolType
                     processedData["0"]?[6] ====> X Centroid
                     processedData["0"]?[7] ====> Y Centroid
                     processedData["0"]?[8] ====> breakable/not_breakable
 
 (3) tempData:
 
          Data:      tempData["0"]?[0] ====> X0
                     tempData["0"]?[1] ====> X1
                     tempData["0"]?[2] ====> Y0
                     tempData["0"]?[3] ====> Y1
                     tempData["0"]?[4] ====> RecognizedSymbol
                     tempData["0"]?[5] ====> SymbolType
                     tempData["0"]?[6] ====> X Centroid
                     tempData["0"]?[7] ====> Y Centroid
                     tempData["0"]?[8] ====> breakable/not_breakable
                     tempData["0"]?[9] ====>  abs(topThreshold - tempDict[keys]![2])/totalRange
                     tempData["0"]?[10] ====> abs(tempDict[keys]![2] - tempDict[keys]![3])/totalRange
                     tempData["0"]?[11] ====> abs(bottomThreshold - tempDict[keys]![3])/totalRange
                     tempData["0"]?[12] ====> discValue
                     tempData["0"]?[13] ====> baseline / superscript

 
------------------------------------------------------------------------------------------------------------
 SuperClass Used:
 
 (1) interpretationFunctions:
 
 It contains all the general functions required for constructing and evaluating the mathematical expression

 
 
 
------------------------------------------------------------------------------------------------------------
 Created by Maroof Mohammed Farooq on 3/31/16.
 Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
 
 */

import Foundation


public class interpretation: interpretationFunctions {
    
    //# MARK: Variables
    private var processedDataRunKey:Int = 1
    private var numberOfElements:Int = 0
    public var rawData: [String:[Any]] = [:]
    private var rawDataSortedKeys: [String] = []
    public var skipList: [String] = []
    
    //# MARK: Constructor
    init(rawData: [String:[Any]]){
        self.rawData = rawData
        super.init(defaultValue: 0)
        var breakList: [String] = [super.symName[2], super.symName[3], super.symName[4]]
        self.breakList = breakList
        var skipList: [String] = []
        self.skipList = skipList
    }
    
    //# MARK: Processing Raw Data
    internal func processedData() -> [String:[Any]]{
        var data: [String:[Any]] = [:]
        numberOfElements = rawData.count
        rawDataSortedKeys = dictionarySortAscending(self.rawData, index: 0)
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
//            data = dataCleanup(data)
        }
        processedDataRunKey = 0
        return data
    }
    
    //# MARK: Evaluate the Data and return the final Value
    public func evaluate() -> Double {
        var index = 0
        var finalOutput: Double = 0.0
        var subProcessOutput: String = ""
        var keyRange: [String] = []
        var data = processedData()
        var dictionaryKeys = sortedKeys(data)
        for keys in dictionaryKeys{
            if self.skipList.contains(keys){
                continue
            }
            else if String(data[keys]![8]) == "breakable" {
                subProcessOutput += subExpressionRouting(keys, keyRange1: keyRange, data: data)
                keyRange = []
            }
            else{

                keyRange.append(keys)
            }
        }

        finalOutput = evaluateString(subProcessOutput)
        return finalOutput
        
    }

    //# MARK: Route Functions.
    public func subExpressionRouting(key: String, keyRange1: [String], data: [String:[Any]]) -> String {
        var processOutput: String = ""
        var keyRange:[String] = keyRange1
        
        switch String(data[key]![5]){
            
        case super.symName[0]:
            keyRange.append(key)
            processOutput += stringGenerator(keyRange,data: data)
            break

        case super.symName[2]:
            var keyRangeString: String = ""
            var rootValue: Double = 2.0

            if keyRange.count != 0{
                var previousKey:String =  maxStringArray(keyRange)
                //# FIXME: Multiple digits should be accepted
                if String(data[previousKey]![5]) == super.symName[0]{
                    rootValue = super.anyToDouble(data[previousKey]![4])
                    keyRange.dropLast()
                }
                keyRangeString = stringGenerator(keyRange,data: data)
            }
            
            var underRootElements = super.underRootSearch(data, rootKey: key)
            var underRootString = stringGenerator(underRootElements, data: data)
            var underRootEvaluate = super.evaluateString(underRootString)
            var rootEvaluate = String(pow(underRootEvaluate, 1/rootValue))
            skipList = skipList + underRootElements
            processOutput += keyRangeString + rootEvaluate
            break
            
        // Case: LongDivision
        case super.symName[3]:
            var keyRangeString: String = ""
            
            if keyRange.count != 0{
                keyRangeString = stringGenerator(keyRange, data:data)
            }
            var ldIndices = super.longDivision(data, ldKey: key)
            var topString = stringGenerator(ldIndices.0, data: data)
            var bottomString = stringGenerator(ldIndices.1,data: data)
            processOutput = "(" + topString + ")" + "/" + "(" + bottomString + ")"
            skipList += ldIndices.0 + ldIndices.1
            break
        
        case super.symName[4]:
            var keyRangeString: String = ""
            var openBracketList:[String] = ["(","{","["]
            var closeBracketList:[String] = [")","}","]"]
            var keyElement = String(data[key]![4])
            skipList.append(key)
            
            if openBracketList.contains(keyElement){
                if keyRange.count != 0{
                    keyRangeString = stringGenerator(keyRange, data:data)
                }
            }
            else if closeBracketList.contains(keyElement){
                var nextElementKey = super.nextElement(data, currentKeyValue: key)
                if nextElementKey == "nil" {
                    keyRangeString = stringGenerator(keyRange, data: data)
                }
                //# FIXME: Add support for n length power elements
                else if String(data[nextElementKey]![5]) == super.symName[0]{
                    var primaryEvaluate = super.evaluateString(stringGenerator(keyRange, data: data))
                    var powerTerm = super.evaluateString(String(data[nextElementKey]![4]))
                    keyRangeString = String(pow(primaryEvaluate,powerTerm))
                    skipList.append(nextElementKey)
                }
                else{
                    keyRangeString = stringGenerator(keyRange, data: data)
                }
    
            }
            processOutput = keyRangeString
            break
            
        default:
            processOutput = ""
        }
        print(processOutput)
        return processOutput
    }
    
    //# MARK: Classification between baseline and superscript elements
    public func classificationEngine(tempDict1: [String:[Any]]) -> [String:[Any]] {
        
        var tempDict = tempDict1
        var topThreshold = Double(minFinder(tempDict, arrayIndex: 2))
        var bottomThreshold = Double(maxFinder(tempDict, arrayIndex: 3))
        var totalRange = abs(bottomThreshold - topThreshold)
        var tempDictKeys = sortedKeys(tempDict)
        var discValue: Double = 0.0
        
        for keys in tempDictKeys{
            tempDict[keys]!.append(abs((topThreshold) - anyToDouble(tempDict[keys]![2]))/totalRange)
            tempDict[keys]!.append(abs(anyToDouble(tempDict[keys]![2]) - anyToDouble(tempDict[keys]![3]))/totalRange)
            tempDict[keys]!.append(abs(bottomThreshold - anyToDouble(tempDict[keys]![3]))/totalRange)
            //# FIXME: Get better classification
            discValue = -0.7 * anyToDouble(tempDict[keys]![9]) - 0.4*anyToDouble(tempDict[keys]![10]) + 0.8*anyToDouble(tempDict[keys]![11]) + 0.1
            tempDict[keys]!.append(discValue)
            if discValue < 0.0 {
                tempDict[keys]!.append("baseline")
            }
            else{
                tempDict[keys]!.append("superscript")
            }
        }
        return tempDict
    }

    //# MARK: Generate String Formated Output for a well defined Mathematical Structure
    public func stringGenerator(keyRange: [String], data: [String:[Any]]) -> String{
        var tempDict: [String:[Any]] = [:]
        var expression: String = ""
        var currentIndex: Int = 0
        var numberOfKeys: Int = keyRange.count
        var skipList2: [String] = []
        
        for keys in keyRange{
            tempDict[keys] = data[keys]
        }
        
        tempDict = classificationEngine(tempDict)
        for keys in keyRange{
            if skipList2.contains(keys){
                currentIndex += 1
                continue
            }
            if String(data[keys]![5]) == super.symName[0]{
                if currentIndex == numberOfKeys - 1 {
                    expression += tempDict[keys]![4] as! String
                }
                else if String(tempDict[keyRange[currentIndex+1]]![13]) == "superscript" {
                    //# FIXME: Add support for multiple digits classified as superscript!
                    var baselineElement = evaluateString(String(tempDict[keys]![4]))
                    var superScriptElement = evaluateString(String(tempDict[keyRange[currentIndex+1]]![4]))
                    expression += String(pow(baselineElement, superScriptElement))
                    skipList2.append(keyRange[currentIndex+1])
                }
                    
                else{
                    expression += tempDict[keys]![4] as! String
                }
            }
            else {
                expression += tempDict[keys]![4] as! String
            }
            currentIndex += 1
        }
    
        return expression
    }
    
//    //# Uses Decision Tree to remove noise. Outputs clean Dictionary.
//    public func dataCleanup(data:[String:[Any]]) -> [String:[Any]] {
//        
//    }
    

}



























