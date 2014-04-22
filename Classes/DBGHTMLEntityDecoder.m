//
//  DBGHTMLEntityDecoder.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGHTMLEntityDecoder.h"
#import "DBGHTMLEntityDecoder+Private.h"
#import "DBGHTMLEntityDecodeMap.h"

static NSString *DBGEntityRegexString = @"&(?:([a-z][a-z0-9]{1,7})|#([0-9]{1,7})|#x([0-9a-f]{1,6}));";

@implementation DBGHTMLEntityDecoder

- (NSArray *)entitiesInString:(NSString *)string {
    if ([string rangeOfString:@"&"].location == NSNotFound) {
        return @[];
    }

    NSError *error = NULL;
    NSRegularExpression *regex =
        [NSRegularExpression regularExpressionWithPattern:DBGEntityRegexString
                                                  options:NSRegularExpressionCaseInsensitive
                                                    error:&error];
    NSAssert(!error, @"Error while creating NSRegularExpression");

    return [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
}

- (NSString *)decodeString:(NSString *)string {
    NSMutableString *mutableString = [string mutableCopy];
    [self decodeStringInPlace:mutableString];

    return [NSString stringWithString:mutableString];
}

- (void)decodeStringInPlace:(NSMutableString *)mutableString {
    NSArray *matches = [self entitiesInString:mutableString];

    if ([matches count] == 0) {
        return;
    }

    DBGHTMLEntityDecodeMap *decodeMap = [[DBGHTMLEntityDecodeMap alloc] init];

    // go in reverse to keep the integrity of match ranges
    [matches enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSTextCheckingResult *match = (NSTextCheckingResult *)obj;
        NSString *matchText = [mutableString substringWithRange:match.range];

        NSString *decodedText = decodeMap[matchText];
        if (decodedText) {
            [mutableString replaceCharactersInRange:match.range withString:decodedText];
        }
    }];
}

@end
