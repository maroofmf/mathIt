//
//  interpretationFunctions.h
//  interpretationInC
//
//  Created by Maroof Mohammed Farooq on 4/13/16.
//  Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
//
#import <Foundation/Foundation.h>


NSNumber *evaluateString(NSString *numericExpression);
NSMutableArray *dictionarySortAscending(NSMutableDictionary *dataDictionary, int index);
NSNumber *xcent(NSMutableArray *dataArray);
NSNumber *ycent(NSMutableArray *dataArray);
NSMutableArray *sortedKeys(NSMutableDictionary *dataDictionary);
NSNumber *minFinder(NSMutableDictionary *dataDictionary, int index);
NSNumber *maxFinder(NSMutableDictionary *dataDictionary, int index);
NSMutableArray *sortArray(NSMutableArray *dataArray);
NSNumber *maxStringArray(NSMutableArray *dataArray);
NSMutableArray *underRootSearch(NSMutableDictionary *dataDictionary, NSString *rootKey);
NSMutableArray *longDivision(NSMutableDictionary *dataDictionary, NSString *divisionKey);
NSString *nextElement(NSMutableDictionary *dataDictionary, NSString *currentKey);
NSString *previousElement(NSMutableDictionary *dataDictionary, NSString *currentKey);