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
//        
//        
        NSMutableDictionary *testVariable1 = @{
            @"1" :    @[
                     @486,
                     @879,
                     @117,
                     @378,
                     @"2",
                     @"N"
                     ],
            @"2" :     @[
                     @109,
                     @469,
                     @194,
                     @552,
                     @"2",
                     @"N"
                     ]
            };
        
        
        NSMutableDictionary *testVariable = [testVariable1 mutableCopy];
        interpretationClass *testOuptut = [[interpretationClass alloc] initWithRawData:testVariable];
        
        NSLog(@"This : %@", testOuptut.evaluate);
        
        
    }
    return 0;
}