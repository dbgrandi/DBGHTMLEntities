//
//  DBGHTMLEntityDecoder.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityDecoder : NSObject

/**
 * Decode all the entities within a string, returning a new string.
 */
- (NSString *)decodeString:(NSString *)string;

/**
 * Decode all the entities in place for a mutable string.
 */
- (void)decodeStringInPlace:(NSMutableString *)mutableString;

@end
