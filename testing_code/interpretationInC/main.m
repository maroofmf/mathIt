//
//  main.m
//  interpretationInC
//
//  Created by Maroof Mohammed Farooq on 4/12/16.
//  Copyright © 2016 Maroof Mohammed Farooq. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        UInt a = sizeof(int);
//        NSLog(@"%d",a);
//    }
//    return 0;
//}
//
//


// main.m
#import <Foundation/Foundation.h>
#import "interpretationFunctions.h"
#import "interpretationClass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // For equation: (9^3 - 2^2)/ (5.05) = 143.5643
        
//        NSMutableDictionary *testVariable1 = @{@"0": @[@220, @340, @110, @115, @"/", @"longDivision"], @"9": @[@305, @315, @77, @86, @"2", @"N"], @"2": @[@243, @253, @77, @86, @"3", @"N"], @"6": @[@292, @310, @120, @130, @"5", @"N"], @"3": @[@254, @265, @120, @130, @"5", @"N"], @"1": @[@225, @240, @85, @103, @"9", @"N"], @"5": @[@278, @290, @121, @131, @"0", @"N"], @"4": @[@270, @275, @127, @131, @".", @"O"], @"7": @[@268, @275, @95, @100, @"-", @"O"],  @"8": @[@285, @300, @85, @100, @"2", @"N"],};

        NSMutableDictionary *testVariable1 =    @{@"1" :     @[

@1886,

@0,

@63,

@0,

@")",

@"Bracket"

],

                                                  @"10" :     @[

@714,

@0,

@141,

@0,

@3,

@"N"

],

                                                  @"11" :     @[

@1041,

@0,

@147,

@0,

@"*",

@"O"

],

                                                  @"13" :     @[

@230,

@0,

@159,

@0,

@2,

@"N"

],

                                                  @"14" :    @[

@1429,

@0,

@160,

@0,

@4,

@"N"

],

                                                  @"15" :     @[

@445,

@0,

@179,

@0,

@"+",

@"O"

],

                                                  @"16" :     @[

@1588,

@0,

@181,

@0,

@"*",

@"O"

],

                                                  @"17" :     @[

@1776,

@0,

@188,

@0,

@5,

@"N"

],

                                                  @2 :     @[

@1296,

@0,

@84,

@0,

@"(",

@"Bracket"

],

                                                  @"3" :     @[
                                                              

@71,

@0,

@87,

@0,

@"(",

@"Bracket"

],

                                                  @"8" :     @[

@843,

@0,

@115,

@0,

@")",
@"Bracket"]};
        
//        NSMutableDictionary *testVariable = [testVariable1 mutableCopy];
//        interpretationClass *testOuptut = [[interpretationClass alloc] initWithRawData:testVariable];
        NSMutableDictionary *tt = @{                                                  @"15" :     @[
                                                                                              
                                                                                              @445,
                                                                                              
                                                                                              @0,
                                                                                              
                                                                                              @179,
                                                                                              
                                                                                              @0,
                                                                                              
                                                                                              @"+",
                                                                                              
                                                                                              @"O"
                                                                                              
                                                                                              ],};
        NSString *test = @"";
        test = [test stringByAppendingString:tt[@"15"][4]];
        
        NSLog(@"This : %@", test);
        
        
    }
    return 0;
}