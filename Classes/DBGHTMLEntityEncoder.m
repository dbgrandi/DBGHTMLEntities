//
//  DBGHTMLEntityEncoder.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGHTMLEntityEncoder.h"
#import "DBGHTMLEntityEncoder+Private.h"
#import "DBGHTMLEntityEncodeMap.h"
#import "DBGHTMLEntityDecodeMap.h"

@implementation DBGHTMLEntityEncoder

- (NSString *)encode:(NSString *)string {
    return [self encode:string withFormats:[self defaultFormats]];
}

- (NSString *)encode:(NSString *)string withFormats:(DBGHTMLEntityEncoderFormats)formats {
    NSMutableString *mutableString = [string mutableCopy];
    [self encodeStringInPlace:mutableString withFormats:formats];
    return mutableString;
}

- (void)encodeStringInPlace:(NSMutableString *)mutableString {
    [self encodeStringInPlace:mutableString withFormats:[self defaultFormats]];
}

- (void)encodeStringInPlace:(NSMutableString *)mutableString withFormats:(DBGHTMLEntityEncoderFormats)formats {
    // If it does NOT need encoding, return the string.
    if (![self stringNeedsEncoding:mutableString]) {
        return;
    }

    NSMutableArray *ranges = [@[] mutableCopy];

    NSCharacterSet *basicEntities = [NSCharacterSet characterSetWithCharactersInString:@"<>'\"&"];
    [ranges addObjectsFromArray:[self rangesOfCharacters:basicEntities string:mutableString]];
    
    NSCharacterSet *nonASCII = [self nonASCIICharacterSet];
    [ranges addObjectsFromArray:[self rangesOfCharacters:nonASCII string:mutableString]];

    // reverse sort the array of ranges
    [ranges sortUsingComparator:^NSComparisonResult(NSValue *val1, NSValue *val2) {
        NSRange range1 = [val1 rangeValue];
        NSRange range2 = [val2 rangeValue];

        if(range1.location == range2.location) {
            return NSOrderedSame;
        }
        
        if(range1.location < range2.location){
            return NSOrderedDescending;
        }

        return NSOrderedAscending;
    }];
    
    DBGHTMLEntityEncodeMap *encodeMap = [[DBGHTMLEntityEncodeMap alloc] init];
    
    // for each range, try to decode as basic, then name, then decimal/hex
    for (NSValue *value in ranges) {
        NSRange range = [value rangeValue];
        unichar theChar = [mutableString characterAtIndex:range.location];
        NSString *replacement = nil;
        
        if (formats & DBGHTMLEntityEncoderNamedFormat) {
            replacement = [encodeMap encodeAsNamed:theChar];
            if (replacement) {
                [mutableString replaceCharactersInRange:range withString:replacement];
                continue;
            }
        }
        if (formats & DBGHTMLEntityEncoderDecimalFormat) {
            [mutableString replaceCharactersInRange:range withString:[encodeMap encodeAsDecimal:theChar]];
            continue;
        }
        if (formats & DBGHTMLEntityEncoderHexFormat) {
            [mutableString replaceCharactersInRange:range withString:[encodeMap encodeAsHex:theChar]];
            continue;
        }
    }

    return;
}

- (BOOL)stringNeedsEncoding:(NSString *)string {
    // if the string contains ANY basic entities, it DOES need encoding
    NSCharacterSet *basicEntities = [self basicEntitiesCharacterSet];
    NSRange basicEntityRange = [string rangeOfCharacterFromSet:basicEntities];
    if (basicEntityRange.location != NSNotFound) {
        return YES;
    }

    // if the string contains ANY characters that are not 7 bit ASCII, it DOES need encoding
    if (![self stringContainsOnlyASCII:string]) {
        return YES;
    }

    return NO;
}

#pragma mark - Internal Helpers

- (DBGHTMLEntityEncoderFormats)defaultFormats {
    return (DBGHTMLEntityEncoderNamedFormat | DBGHTMLEntityEncoderDecimalFormat);
}

- (BOOL)stringContainsOnlyASCII:(NSString *)string {
    return [string canBeConvertedToEncoding:NSASCIIStringEncoding];
}

- (NSCharacterSet *)basicEntitiesCharacterSet {
    return [NSCharacterSet characterSetWithCharactersInString:@"<>'\"&"];
}

- (NSCharacterSet *)nonASCIICharacterSet {
    return [[NSCharacterSet characterSetWithRange:NSMakeRange(0, 128)] invertedSet];
}

- (NSArray *)rangesOfCharacters:(NSCharacterSet *)characterSet string:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfCharacterFromSet:characterSet options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return results;
}

@end
