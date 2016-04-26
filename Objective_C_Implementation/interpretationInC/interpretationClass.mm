//
//  interpretationClass.m
//  interpretationInC
//
//  Created by Maroof Mohammed Farooq on 4/15/16.
//  Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
//

#import "interpretationClass.h"
#import "interpretationFunctions.h"

@implementation interpretationClass

/* ------------------------------------------------------------------------------------------------------
 PART - A
 //# MARK: Class Constructor
 */


-(id)initWithRawData:(NSMutableDictionary*)inputData{
    self = [super init];
    if (self){
        _rawData = [inputData mutableCopy];
        _symName = @[@"N",@"O",@"Root",@"longDivision",@"Bracket",@"dot"];
        _breakList = @[@"Root",@"longDivision",@"Bracket"];
        _processedDataRunKey = [NSNumber numberWithInt:1];
        _numberOfElements = [NSNumber numberWithUnsignedInteger:_rawData.count];
        _skipList = [NSMutableArray arrayWithObjects: nil];
    }
    return self;
}

-(id)init{
    NSMutableDictionary *notUsed;
    return [self initWithRawData:notUsed];
}


/* ------------------------------------------------------------------------------------------------------
 PART - B
 //# MARK: Data Preprocessing!
 */

-(NSMutableDictionary*)processedData{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *rawDataSortedKeys = dictionarySortAscending(self.rawData,0);
    if (self.processedDataRunKey == [NSNumber numberWithInt:1]){
        NSNumber *index = [NSNumber numberWithInt:0];
        for (id keys in rawDataSortedKeys){
            NSMutableArray *keyValue = [NSMutableArray arrayWithObjects: nil];
            [keyValue addObjectsFromArray : [self.rawData objectForKey:keys]];
            [keyValue addObjectsFromArray: @[(xcent(keyValue)),(ycent(keyValue))]];
            
            if ([self.breakList containsObject:keyValue[5]]){
                [keyValue addObject: @"breakable"];
            }
            else if ([[NSNumber numberWithInt: index.integerValue +1] isEqual:self.numberOfElements]) {
                
                [keyValue addObject: @"breakable"];
            }
            else {
                [keyValue addObject: @"not_breakable"];
            }
            [dataDictionary setObject:keyValue forKey:index.stringValue];
            index = [NSNumber numberWithInt:index.integerValue + 1];
        }
    }
    self.processedDataRunKey = [NSNumber numberWithInt:0];
    NSLog(@"%@",dataDictionary);
    return dataDictionary;
}


/* ------------------------------------------------------------------------------------------------------
 PART - C
 //# MARK: Evaluation and Routing
 */


-(NSNumber*)evaluate{
    NSNumber *index = [NSNumber numberWithInt:0];
    NSNumber *finalOutput = [NSNumber numberWithDouble:0.0];
    NSString *subProcessOutput = @"";
    NSMutableArray *keyRange = [NSMutableArray arrayWithObjects: nil];
    NSMutableDictionary *data = self.processedData;
    NSMutableArray *dictionaryKeys = sortedKeys(data);
    
    for (id keys in dictionaryKeys){
        
        if ([self.skipList containsObject:keys]){
            continue;
        }
        else if ([(data[keys][8])  isEqual: @"breakable"]) {
            subProcessOutput = [subProcessOutput stringByAppendingString: [self subExpressionRouting:keys inputKeyRange:keyRange inputData:data]];
            [keyRange removeAllObjects];
        }
        else{
            [keyRange addObject:keys];
        }
    }
    
    finalOutput = evaluateString(subProcessOutput);
    NSLog(@"Final %@", finalOutput);
    return finalOutput;
    
}


-(NSString*)subExpressionRouting:(NSString*)keys inputKeyRange:(NSMutableArray*)keyRange inputData:(NSMutableDictionary*)data{
    
    
    NSString *processOutput = @"";
    NSString *keyRangeString = @"";
    int symNameIndex = [self.symName indexOfObject:data[keys][5]];
    switch (symNameIndex){
            
            // Case: last element
        case 0:
        {
            [keyRange addObject:keys];
            processOutput = [self stringGenerator:keyRange inputData:data];
            break;
        }
            
            // Case: Root
        case 2:
        {
            NSNumber *rootValue = [NSNumber numberWithDouble:2.0];
            NSMutableArray *underRootElements = [NSMutableArray arrayWithObjects: nil];
            
            if (keyRange.count != 0){
                NSNumber *previousKey = maxStringArray(keyRange);
                if ([data[previousKey.stringValue][5] isEqualToString: self.symName[0]]){
                    rootValue = [NSNumber numberWithDouble: [data[previousKey.stringValue][4] doubleValue]];
                    [keyRange removeObject:previousKey];
                }
                keyRangeString = [self stringGenerator:keyRange inputData:data];
            }
            
            underRootElements = underRootSearch(data, keys);
            NSString *underRootString = [self stringGenerator:underRootElements inputData:data];
            NSNumber *underRootEvaluate = [NSNumber numberWithDouble:(evaluateString(underRootString)).doubleValue];
            
            NSString *rootEvaluate = ([NSNumber numberWithDouble:pow(underRootEvaluate.doubleValue ,1/rootValue.doubleValue)]).stringValue;
            
            [self.skipList addObjectsFromArray:underRootElements];
            processOutput = [[processOutput stringByAppendingString: keyRangeString]stringByAppendingString:rootEvaluate];
            
            break;
        }
            // Case: LongDivision
        case 3:
        {
            if (keyRange.count != 0){
                keyRangeString = [self stringGenerator:keyRange inputData:data];
            }
            
            NSMutableArray *ldIndices = (longDivision(data, keys))[0];
            NSString *topString = [self stringGenerator:ldIndices inputData:data];
            NSMutableArray *bottomIndices = (longDivision(data, keys))[1];
            NSString *bottomString = [self stringGenerator:bottomIndices inputData:data];
            NSMutableArray *elementsArray = [NSMutableArray arrayWithObjects:@"(",topString, @")",@"/",@"(", bottomString, @")", nil];
            processOutput = [elementsArray componentsJoinedByString:@""];
            [self.skipList addObjectsFromArray:ldIndices];
            [self.skipList addObjectsFromArray:bottomIndices];
            break;
        }
            // Case: Brackets
        case 4:
        {
            
            NSMutableArray *openBracketList = @[@"(",@"{",@"["];
            NSMutableArray  *closeBracketList =  @[@")",@"}",@"]"];
            NSString *keyElement = data[keys][4];
            //            skipList.append(key)
            
            if ([openBracketList containsObject: keyElement]){
                if (keyRange.count != 0){
                    keyRangeString = [self stringGenerator:keyRange inputData:data];
                }
            }
            else if ([closeBracketList containsObject: keyElement]){
                NSString *nextElementKey = nextElement(data, keys);
                
                if ([nextElementKey isEqualToString: @"nil"]) {
                    keyRangeString = [self stringGenerator:keyRange inputData:data];
                }
                else if ([data[nextElementKey][5] isEqualToString: self.symName[0]]){
                    NSNumber *primaryEvaluate = evaluateString([self stringGenerator:keyRange inputData:data]);
                    NSNumber *powerTerm = [NSNumber numberWithDouble: [data[nextElementKey][4] doubleValue]];
                    keyRangeString  = ([NSNumber numberWithDouble:pow(primaryEvaluate.doubleValue, powerTerm.doubleValue)]).stringValue;
                    [self.skipList addObject: nextElementKey];
                }
                else{
                    keyRangeString = [self stringGenerator:keyRange inputData:data];
                }
                
            }
            processOutput = keyRangeString;
            break;
        }
            
        default:
        {
            processOutput = @"";
        }
    }
    return processOutput;
}

/* ------------------------------------------------------------------------------------------------------
 PART - D
 //# MARK: Classification Engine
 */


-(NSMutableDictionary*)classificationEngine:(NSMutableDictionary*)tempDict{
    
    //    NSNumber *topThreshold = [NSNumber numberWithDouble:(minFinder(tempDict, 2)).doubleValue];
    //    NSNumber *bottomThreshold = [NSNumber numberWithDouble:(maxFinder(tempDict, 3)).doubleValue];
    //    NSNumber *totalRange = [NSNumber numberWithDouble: fabs(bottomThreshold.doubleValue - topThreshold.doubleValue)];
    NSMutableArray *tempDictKeys = sortedKeys(tempDict);
    NSNumber *discValue = [NSNumber numberWithDouble:0.0];
    int firstElementCheck = 1;
    
    for (id keys in tempDictKeys) {
        
        //        NSMutableArray *keyValue = [NSMutableArray arrayWithObjects: nil];
        //        [keyValue addObjectsFromArray:tempDict[keys]];
        
        //        [keyValue addObject: [NSNumber numberWithDouble: fabs(topThreshold.doubleValue - [tempDict[keys][2] doubleValue])/(totalRange.doubleValue)]];
        //        [keyValue addObject: [NSNumber numberWithDouble: fabs([tempDict[keys][2] doubleValue] - [tempDict[keys][3] doubleValue])/(totalRange.doubleValue)]];
        //        [keyValue addObject: [NSNumber numberWithDouble: fabs(bottomThreshold.doubleValue - [tempDict[keys][2] doubleValue])/(totalRange.doubleValue)]];
        //
        //        [tempDict setObject:keyValue forKey:keys];
        //        //# FIXME: Get better classification
        //
        //        discValue = [NSNumber numberWithDouble: -0.7 * [tempDict[keys][9] doubleValue] - 0.4* [tempDict[keys][10] doubleValue] + 0.8* [tempDict[keys][11] doubleValue] - 0.6];
        //        [keyValue addObject: discValue];
        //
        //        if (discValue.doubleValue < 0.0) {
        //            [keyValue addObject: @"baseline"];
        //        }
        //        else{
        //            [keyValue addObject: @"superscript"];
        //        }
        //        [tempDict setObject:keyValue forKey:keys];
        
        NSString *nextKey = nextElement(tempDict, keys);
        if (firstElementCheck == 1){
            NSMutableArray *keyValue = [NSMutableArray arrayWithObjects: nil];
            [keyValue addObjectsFromArray:tempDict[keys]];
            [keyValue addObject:@"baseline"];
            [tempDict setObject:keyValue forKey: keys];
            firstElementCheck = 0;
            
            if (nextKey == @"nil"){
                continue;
            }else{
                NSMutableArray *keyValue = [NSMutableArray arrayWithObjects: nil];
                [keyValue addObjectsFromArray:tempDict[nextKey]];
                [keyValue addObject:[self classificationDecisionTree:tempDict current_Key:keys next_Key:nextKey]];
                [tempDict setObject:keyValue forKey:nextKey];
            }
        }
        else{
            if (nextKey == @"nil"){
                continue;
            }
            else{
                NSMutableArray *keyValue = [NSMutableArray arrayWithObjects: nil];
                [keyValue addObjectsFromArray:tempDict[nextKey]];
                [keyValue addObject:[self classificationDecisionTree:tempDict current_Key:keys next_Key:nextKey]];
                [tempDict setObject:keyValue forKey:nextKey];
            }
        }
    }
    return tempDict;
}

-(NSString*)classificationDecisionTree:(NSMutableDictionary*)tempDict current_Key:(NSString*)currentKey next_Key:(NSString*)nextKey{
    
    NSLog(@"forKEy %@",tempDict[nextKey][4]);
    int caseID = 0;
    NSNumber *hypothesisValue = [NSNumber numberWithDouble:0];
    NSNumber *thresholdValue = [NSNumber numberWithDouble:0.5];
    
    // Encoding the cases to use in switch statement.
    if ([tempDict[nextKey][5] isEqualToString: self.symName[0]]){
        caseID = 1;
    } else{
        if ([tempDict[nextKey][4] isEqualToString: @"."]){
            caseID = 2;
        }else{
            caseID = 3;
        }
    }
    NSLog(@"caseID %d", caseID);
    
    switch (caseID) {
            
        case 3:
            
            if ([tempDict[currentKey][9] isEqualToString:@"baseline"]){
                return @"baseline";
            }
            
            else{
                NSString *next_nextKey = nextElement(tempDict, nextKey);
                NSLog(@"Next Element: %@ ", tempDict[next_nextKey]);
                hypothesisValue = [self hypothesisEvaluator:tempDict[next_nextKey] second_Element: tempDict[currentKey]];
                if (hypothesisValue.doubleValue <= thresholdValue.doubleValue){
                    return @"superscript";
                }else{
                    return @"baseline";
                }
            }
            break;
            
        case 2:
            return tempDict[currentKey][9];
            break;
            
        case 1:
            if ([tempDict[currentKey][5] isEqualToString:self.symName[1]]){
                return tempDict[currentKey][9];
            }
            else{
                hypothesisValue = [self hypothesisEvaluator:tempDict[currentKey] second_Element: tempDict[nextKey]];
                if (hypothesisValue.doubleValue <= thresholdValue.doubleValue){
                    return tempDict[currentKey][9];
                }else{
                    return @"superscript";
                }
            }
            
        default:
            NSLog(@"Default Executed");
            return tempDict[currentKey][9];
            break;
    }
}

-(NSNumber*)hypothesisEvaluator:(NSMutableArray*)firstElement second_Element:(NSMutableArray*)secondElement{
    NSNumber *x0_1 = firstElement[0];
    NSNumber *x1_1 = firstElement[1];
    NSNumber *y0_1 = firstElement[2];
    NSNumber *y1_1 = firstElement[3];
    NSNumber *yCentroid_1 = firstElement[7];
    NSNumber *x0_2 = secondElement[0];
    NSNumber *x1_2 = secondElement[1];
    NSNumber *y0_2 = secondElement[2];
    NSNumber *y1_2 = secondElement[3];
    NSNumber *yCentroid_2 = secondElement[7];
    
    NSNumber *bottomValueConfidance = [NSNumber numberWithDouble:0];
    NSNumber *centroidValueConfidance = [NSNumber numberWithDouble:0];
    
    NSNumber *threshold_25 = [NSNumber numberWithDouble: y1_1.doubleValue-fabs(y1_1.doubleValue - y0_1.doubleValue)*0.25];
    NSNumber *threshold_75 = [NSNumber numberWithDouble: y1_1.doubleValue-fabs(y1_1.doubleValue - y0_1.doubleValue)*0.75];
    
    // Scoring for bottomPoint:
    
    if ((y1_2.doubleValue >= threshold_25.doubleValue) &&(y1_2.doubleValue < y1_1.doubleValue)){
        double score = (0.4/(y1_1.doubleValue - threshold_25.doubleValue))*(y1_1.doubleValue - y1_2.doubleValue);
        bottomValueConfidance = [NSNumber numberWithDouble: score];
    } else if((y1_2.doubleValue < threshold_25.doubleValue) &&(y1_2.doubleValue >= y0_1.doubleValue)){
        double score = (0.6/(threshold_25.doubleValue - y0_1.doubleValue))*(threshold_25.doubleValue - y1_2.doubleValue) + 0.4;
        bottomValueConfidance = [NSNumber numberWithDouble: score];
    } else if(y1_2.doubleValue < y0_1.doubleValue){
        bottomValueConfidance = [NSNumber numberWithDouble: 1.0];
    }
    
    
    // Scoring for mean:
    
    if ((yCentroid_2.doubleValue >= yCentroid_1.doubleValue) &&(yCentroid_2.doubleValue < y1_1.doubleValue)){
        double score = (0.15/(y1_1.doubleValue - yCentroid_1.doubleValue))*(y1_1.doubleValue - yCentroid_2.doubleValue);
        centroidValueConfidance = [NSNumber numberWithDouble: score];
    } else if((yCentroid_2.doubleValue < yCentroid_1.doubleValue) &&(yCentroid_2.doubleValue >= y0_1.doubleValue)){
        double score = (0.85/(yCentroid_1.doubleValue - y0_1.doubleValue))*(yCentroid_1.doubleValue - yCentroid_2.doubleValue) + 0.15;
        centroidValueConfidance = [NSNumber numberWithDouble: score];
    } else if(yCentroid_2.doubleValue < y0_1.doubleValue){
        centroidValueConfidance = [NSNumber numberWithDouble: 1.0];
    }
    NSNumber *score_overall = [NSNumber numberWithDouble:(centroidValueConfidance.doubleValue + bottomValueConfidance.doubleValue)/2];
    
    NSLog(@"For overall-> %@", score_overall);
    NSLog(@"For centroidConfidance-> %@", centroidValueConfidance);
    NSLog(@"For bottomConfidance-> %@", bottomValueConfidance);
    return score_overall;
}



/* ------------------------------------------------------------------------------------------------------
 PART - E
 //# MARK: String Generation
 */

-(NSString*)stringGenerator:(NSMutableArray*)keyRange inputData:(NSMutableDictionary*)data{
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    NSString *expression = @"";
    NSNumber *currentIndex = [NSNumber numberWithInt:0];
    NSNumber *numberOfKeys = [NSNumber numberWithUnsignedInteger:keyRange.count];
    NSMutableArray *skipList2 = [NSMutableArray arrayWithObjects: nil];
    for (id keys in keyRange){
        tempDict[keys] = [data[keys] mutableCopy];
    }
    
    tempDict = [self classificationEngine:tempDict];
    NSLog(@"For temp-> %@", tempDict);
    for (id keys in keyRange){
        
        if ([skipList2 containsObject:keys]){
            currentIndex = [NSNumber numberWithInt: currentIndex.intValue + 1];
            continue;
        }
        
        if ([data[keys][5] isEqualToString: self.symName[0]]){
            NSString *nextKey = nextElement(tempDict, keys);
            if ([currentIndex isEqual: [NSNumber numberWithInt:numberOfKeys.intValue - 1]]) {
                expression = [expression stringByAppendingString: tempDict[keys][4]];
            }
            else if ([tempDict[nextKey][9] isEqualToString: @"superscript"]) {
                //# FIXME: Add support for multiple digits classified as superscript!
                
                NSNumber *baselineElement = evaluateString(tempDict[keys][4]);
                NSNumber *superScriptElement = evaluateString(tempDict[nextKey][4]);
                expression = [expression stringByAppendingString: ([NSNumber numberWithDouble: pow(baselineElement.doubleValue, superScriptElement.doubleValue)]).stringValue];
                [skipList2 addObject:nextKey];
            }
            
            else{
                expression = [expression stringByAppendingString: tempDict[keys][4]];
            }
        }
        else {
            
            expression = [expression stringByAppendingString: tempDict[keys][4]];
        }
        currentIndex = [NSNumber numberWithInt: currentIndex.intValue + 1];
    }
    return expression;
}

@end