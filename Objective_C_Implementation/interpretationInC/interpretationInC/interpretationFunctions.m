//
//  interpretationFunctions.m
//  interpretationInC
//
//  Created by Maroof Mohammed Farooq on 4/13/16.
//  Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "interpretationFunctions.h"


/* ------------------------------------------------------------------------------------------------------
                                            Function -- 1
//# MARK: Evaluate Numerical Expressions.
//# FIXME: Wont return precise values for 2/3. Returns 0 instead of 0.66

Testing:
 
#Input:
 NSString *testVariable = @"3.02/4.9";
 NSNumber *testOutput = evaluateString(testVariable);
 NSLog(@"%@", testOutput);
 
#Output:
 0.61632
 
 */

NSNumber *evaluateString(NSString *numericExpression){
    NSExpression *expression = [NSExpression expressionWithFormat:numericExpression];
    NSNumber *result = [expression expressionValueWithObject:nil context:nil];
    return result;
}



/* ------------------------------------------------------------------------------------------------------
                                            Function -- 2
# MARK: Sorting Based on index Values in Ascending Order.

 Testing:
 
 #Input:
 
 NSMutableDictionary *testVariable = @{@"1": [NSMutableArray arrayWithObjects:@2,@3,@4, nil],
 @"2": [NSMutableArray arrayWithObjects:@7,@9,@1, nil],
 @"5": [NSMutableArray arrayWithObjects:@1,@3,@9, nil],
 @"3": [NSMutableArray arrayWithObjects:@3,@5,@3, nil]
 };
NSMutableArray *testOutput = dictionarySortAscending(testVariable, 2);
NSLog(@"%@", testOutput);
 
 #Output : 
 [2,3,1,5]
 */

NSMutableArray *dictionarySortAscending(NSMutableDictionary *dataDictionary, int index){
    NSMutableArray *dictionaryArray = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *returnArray = [NSMutableArray arrayWithObjects:nil];
    
    returnArray = [dataDictionary keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1[index] integerValue] > [obj2[index] integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1[index] integerValue] < [obj2[index] integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return returnArray;
}

/* ------------------------------------------------------------------------------------------------------
                                             Function -- 3
 # MARK: Calculating X-Centroid
 
 Testing:
 
 #Input:
 NSMutableArray *testVariable = @[@300,@413,@50,@72,@"2",@"N",@"breakable"];
 NSNumber *testOutput = xcent(testVariable);
 NSLog(@"%@",testOutput);
 
 #Output:
 356.5
 
 */

NSNumber *xcent(NSMutableArray *dataArray){
    NSNumber *x0_value = [NSNumber numberWithDouble: [dataArray[0] doubleValue]];
    NSNumber *x1_value = [NSNumber numberWithDouble: [dataArray[1] doubleValue]];
    NSNumber *returnValue = [NSNumber numberWithDouble:([x0_value doubleValue] + [x1_value doubleValue])/2.0];
    return returnValue;
}

/* ------------------------------------------------------------------------------------------------------
                                             Function -- 4
 # MARK: Calculating Y-Centroid
 
 Testing:
 
 #Input:
 NSMutableArray *testVariable = @[@300,@413,@50,@73,@"2",@"N",@"breakable"];
 NSNumber *testOutput = ycent(testVariable);
 NSLog(@"%@",testOutput);
 
 #Output:
 61.5
 
 */

NSNumber *ycent(NSMutableArray *dataArray){
    NSNumber *y0_value = [NSNumber numberWithDouble: [dataArray[2] doubleValue]];
    NSNumber *y1_value = [NSNumber numberWithDouble: [dataArray[3] doubleValue]];
    NSNumber *returnValue = [NSNumber numberWithDouble:([y0_value doubleValue] + [y1_value doubleValue])/2.0];
    return returnValue;
}

/* ------------------------------------------------------------------------------------------------------
                                             Function -- 5
 # MARK: Return sorted keys of a dictionary
 
 Testing:
 
 #Input:
 NSMutableDictionary *testVariable = @{@"1": [NSMutableArray arrayWithObjects:@2,@3,@4, nil],
 @"189": [NSMutableArray arrayWithObjects:@7,@9,@1, nil],
 @"111": [NSMutableArray arrayWithObjects:@1,@3,@9, nil],
 @"6": [NSMutableArray arrayWithObjects:@3,@5,@3, nil]
 };
 NSArray *testOutput = sortedKeys(testVariable);
 NSLog(@"%@",testOutput);
 
 #Output:
 1,6,111,189
 
 */

NSMutableArray *sortedKeys(NSMutableDictionary *dataDictionary){
    NSMutableArray *keys = dataDictionary.allKeys;
    
    NSMutableArray *sortedKey = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        if ([obj1 doubleValue] < [obj2 doubleValue]){
            return NSOrderedAscending;
        } else if (([obj1 doubleValue] > [obj2 doubleValue])){
            return NSOrderedDescending;
        } else{
            return NSOrderedSame;
        }
    }];

    return sortedKey;
}

/* ------------------------------------------------------------------------------------------------------
                                                Function -- 6
 # MARK: Pass a dictionary and the key value to find the minimum value of dictionary-value
 
 Testing:
 
 #Input:
 NSMutableDictionary *testVariable = @{@"1": [NSMutableArray arrayWithObjects:@2,@32,@4.444, nil],
 @"189": [NSMutableArray arrayWithObjects:@7,@9234,@1.09, nil],
 @"111": [NSMutableArray arrayWithObjects:@1,@311,@9.1, nil],
 @"6": [NSMutableArray arrayWithObjects:@3,@51,@3.9, nil]
 };
 NSArray *testOutput = minFinder(testVariable,2);
 NSLog(@"%@",testOutput);
 
 #Output:
 1.09
 */

NSNumber *minFinder(NSMutableDictionary *dataDictionary, int index){

    NSMutableArray *valueArray = [NSMutableArray arrayWithObjects: nil];
    
    for (id key in dataDictionary){
        id value = [dataDictionary objectForKey:key];
        NSNumber *indexValue = [value objectAtIndex:index];
        [valueArray addObject:indexValue];
    }
    NSNumber *minValue = [valueArray valueForKeyPath:@"@min.self"];
    return minValue;
}

/* ------------------------------------------------------------------------------------------------------
                                                Function -- 7
 # MARK: Pass a dictionary and the key value to find the maximum value of dictionary-value
 
 Testing:
 
 #Input:
 NSMutableDictionary *testVariable = @{@"1": [NSMutableArray arrayWithObjects:@2,@32,@4.444, nil],
 @"189": [NSMutableArray arrayWithObjects:@7,@9234,@1.09, nil],
 @"111": [NSMutableArray arrayWithObjects:@1,@311,@9.1, nil],
 @"6": [NSMutableArray arrayWithObjects:@3,@51,@3.9, nil]
 };
 NSArray *testOutput = maxFinder(testVariable,2);
 NSLog(@"%@",testOutput);
 
 #Output:
 9.1
 */

NSNumber *maxFinder(NSMutableDictionary *dataDictionary, int index){
    
    NSMutableArray *valueArray = [NSMutableArray arrayWithObjects: nil];
    
    for (id key in dataDictionary){
        id value = [dataDictionary objectForKey:key];
        NSNumber *indexValue = [value objectAtIndex:index];
        [valueArray addObject:indexValue];
    }
    NSNumber *maxValue = [valueArray valueForKeyPath:@"@max.self"];
    return maxValue;
}

/* ------------------------------------------------------------------------------------------------------
                                                Function -- 8
//# MARK: Sort Array Elements
 
 Testing:
 
 #Input:
 NSMutableArray *testVariable = @[@"4",@"55.33",@"1.2",@"9"];
 NSArray *testOutput = sortArray(testVariable);
 NSLog(@"%@",testOutput);
 
 
 #Output:
 1.2, 4, 9, 55.33
 */

NSMutableArray *sortArray(NSMutableArray *dataArray){
    
    NSMutableArray *sortedValues = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        if ([obj1 doubleValue] < [obj2 doubleValue]){
            return NSOrderedAscending;
        } else if (([obj1 doubleValue] > [obj2 doubleValue])){
            return NSOrderedDescending;
        } else{
            return NSOrderedSame;
        }
    }];
    
    return sortedValues;
}

/* ------------------------------------------------------------------------------------------------------
                                                Function -- 9
 //# MARK: Find maximum value in an array
 
 Testing:
 
 #Input:
 NSMutableArray *testVariable = @[@"4",@"55.3",@"1.2",@"9.92"];
 NSNumber *testOutput = maxStringArray(testVariable);
 NSLog(@"%@",testOutput);
 
 #Output:
 55.33
 */

NSNumber *maxStringArray(NSMutableArray *dataArray){
    
    NSMutableArray *sortedArray = sortArray(dataArray);
    NSNumber *maxValue = sortedArray.lastObject;
    return maxValue;
}

/* ------------------------------------------------------------------------------------------------------
                                                Function -- 10
 //# MARK: Find the elements lying under the root symbol and return the keys in sorted order
 //# TODO: Test for rootSearch based on centroid values.
 Testing:
 
 #Input:
 The Equation is : (3^3-2^2)/(5.05)
 
 NSMutableDictionary *testVariable = @{@"0": @[@220, @340, @110, @135, @"/", @"longDivision"], @"9": @[@305, @315, @77, @86, @"2", @"N"], @"2": @[@243, @253, @77, @86, @"3", @"N"], @"8": @[@285, @300, @85, @100, @"2", @"N"], @"6": @[@292, @310, @120, @130, @"5", @"N"], @"3": @[@254, @265, @120, @130, @"5", @"N"], @"1": @[@225, @240, @85, @103, @"3", @"N"], @"5": @[@278, @290, @121, @131, @"0", @"N"], @"4": @[@270, @275, @127, @131, @".", @"O"], @"7": @[@268, @275, @95, @100, @"-", @"O"]};
 NSMutableArray *testOutput = underRootSearch(testVariable,@"0");
 NSLog(@"%@",testOutput);

 
 #Output:
 3,4,5,6

 */

NSMutableArray *underRootSearch(NSMutableDictionary *dataDictionary, NSString *rootKey){
    
    NSMutableArray *returnArray = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *rootValue = [dataDictionary objectForKey:rootKey];
    NSNumber *x0_threshold = [rootValue objectAtIndex:0];
    NSNumber *x1_threshold = [rootValue objectAtIndex:1];
    NSNumber *y0_threshold = [rootValue objectAtIndex:2];
    NSNumber *y1_threshold = [rootValue objectAtIndex:3];
    
    for (id key in dataDictionary){
        NSMutableArray *dataValue = [dataDictionary objectForKey:key];
        NSNumber *xCentVal = [dataValue objectAtIndex:5];
        NSNumber *yCentVal = [dataValue objectAtIndex:6];
        if ((xCentVal > x0_threshold) && (xCentVal < x1_threshold) && (yCentVal > y0_threshold) && (yCentVal < y1_threshold)) {
            if (key != rootKey){
                [returnArray addObject:key];
            }
        }
    }
    returnArray = sortArray(returnArray);
    return returnArray;
}


/* ------------------------------------------------------------------------------------------------------
                                            Function -- 11
//# MARK: Finding Elements in long Division
//# TODO: Test for rootSearch based on centroid values.

 Testing:
 
 #Input:
 The Equation is : (3^3-2^2)/(5.05)
 
 NSMutableDictionary *testVariable = @{@"0": @[@220, @340, @110, @115, @"/", @"longDivision"], @"9": @[@305, @315, @77, @86, @"2", @"N"], @"2": @[@243, @253, @77, @86, @"3", @"N"], @"8": @[@285, @300, @85, @100, @"2", @"N"], @"6": @[@292, @310, @120, @130, @"5", @"N"], @"3": @[@254, @265, @120, @130, @"5", @"N"], @"1": @[@225, @240, @85, @103, @"3", @"N"], @"5": @[@278, @290, @121, @131, @"0", @"N"], @"4": @[@270, @275, @127, @131, @".", @"O"], @"7": @[@268, @275, @95, @100, @"-", @"O"]};
 
 NSMutableArray *testOutput = longDivision(testVariable, @"0");
 NSLog(@"%@",testOutput);
 
 #Output:
 [[1,2,7,8,9],[3,4,5,6]]
 
 */

NSMutableArray *longDivision(NSMutableDictionary *dataDictionary, NSString *divisionKey){
    
    NSMutableArray *topArray = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *bottomArray = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *divisionValue = [dataDictionary objectForKey:divisionKey];
    NSNumber *x0_threshold = [divisionValue objectAtIndex:0];
    NSNumber *x1_threshold = [divisionValue objectAtIndex:1];
    NSNumber *y0_threshold = [divisionValue objectAtIndex:2];
    NSNumber *y1_threshold = [divisionValue objectAtIndex:3];
    
    for (id key in dataDictionary) {
        NSMutableArray *dataValue = [dataDictionary objectForKey:key];
        NSNumber *xCentVal = [dataValue objectAtIndex:5];
        NSNumber *yCentVal = [dataValue objectAtIndex:6];
        if ((xCentVal > x0_threshold) && (xCentVal < x1_threshold)){
            if ((yCentVal < y0_threshold) && (key != divisionKey)){
                [topArray addObject:key];
            } else if ((yCentVal > y1_threshold) && (key != divisionKey)) {
                [bottomArray addObject:key];
            }
        }
    }
    topArray = sortArray(topArray);
    bottomArray = sortArray(bottomArray);
    NSMutableArray *returnArray = @[topArray, bottomArray];
    return returnArray;
    }
    
/* ------------------------------------------------------------------------------------------------------
                                                Function -- 12
//# MARK: Find Next element in dictionary
 
 Testing:
 
 #Input:
 NSMutableDictionary *testVariable = @{@"0": @[@220, @340, @110, @115, @"/", @"longDivision"], @"9": @[@305, @315, @77, @86, @"2", @"N"], @"2": @[@243, @253, @77, @86, @"3", @"N"], @"6": @[@292, @310, @120, @130, @"5", @"N"], @"3": @[@254, @265, @120, @130, @"5", @"N"], @"1": @[@225, @240, @85, @103, @"3", @"N"], @"5": @[@278, @290, @121, @131, @"0", @"N"], @"4": @[@270, @275, @127, @131, @".", @"O"], @"7": @[@268, @275, @95, @100, @"-", @"O"]};
 
 
 NSString *testOutput = nextElement(testVariable, @"7");
 NSLog(@"%@",testOutput);
 
 #Output:
 9
 */

NSString *nextElement(NSMutableDictionary *dataDictionary, NSString *currentKey){
    NSMutableArray *dictKeys = sortArray(dataDictionary.allKeys);
    int currentKeyIndex = [dictKeys indexOfObject:currentKey];
    int nextKeyIndex = currentKeyIndex + 1;
    
    if (nextKeyIndex == dictKeys.count) {
        return @"nil";
    }
    else {
        return [dictKeys objectAtIndex:nextKeyIndex];
    }
    }

/* ------------------------------------------------------------------------------------------------------
 */
















