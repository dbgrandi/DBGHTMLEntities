//
//  DBGHTMLEntityDecoder.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGHTMLEntityDecoder.h"
#import "DBGHTMLEntityDecodeMap.h"

static NSString *DBGEntityRegexString = @"&(?:([a-z][a-z0-9]{2,6})|#([0-9]{1,7})|#x([0-9a-f]{1,6}));";

@implementation DBGHTMLEntityDecoder

- (NSArray *)entitiesInString:(NSString *)string {
    NSError *error = NULL;
    NSRegularExpression *entityRegex =
        [NSRegularExpression regularExpressionWithPattern:DBGEntityRegexString
                                                  options:NSRegularExpressionCaseInsensitive
                                                    error:&error];
    
    if (error) {
        NSLog(@"Could not create Regular Expression with string %@", DBGEntityRegexString);
    }
    
    return [entityRegex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
}

- (NSString *)decodeString:(NSString *)string {
    NSArray *matches = [self entitiesInString:string];

    if ([matches count] == 0) {
        return string;
    }

    NSMutableString *mutableString = [string mutableCopy];
    DBGHTMLEntityDecodeMap *decodeMap = [[DBGHTMLEntityDecodeMap alloc] init];

    // go in reverse to keep the integrity of match ranges
    [matches enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSTextCheckingResult *match = (NSTextCheckingResult *)obj;
        NSString *matchText = [string substringWithRange:match.range];
        
        NSString *decodedText = decodeMap[matchText];
        if (decodedText != matchText) {
            [mutableString replaceCharactersInRange:match.range withString:decodedText];
        }
    }];

    return [NSString stringWithString:mutableString];
}

@end
