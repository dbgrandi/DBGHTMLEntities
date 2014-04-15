//
//  DBGHTMLEntityEncoder.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGHTMLEntityEncoder.h"
#import "DBGHTMLEntityDecodeMap.h"

@implementation DBGHTMLEntityEncoder

- (NSString *)encode:(NSString *)string {
    NSMutableString *mutableString = [string mutableCopy];
    [self encodeStringInPlace:mutableString];
    return mutableString;
}

- (NSMutableString *)encodeStringInPlace:(NSMutableString *)mutableString {
    
    // identify & replace basic entities /[<>"&]/
    
    // identify & replace 
    return mutableString;
}

@end
