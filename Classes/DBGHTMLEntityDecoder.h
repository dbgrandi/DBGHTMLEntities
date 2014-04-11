//
//  DBGHTMLEntityDecoder.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityDecoder : NSObject

/**
 * Match entities within the string using a Regular Expression.
 */
- (NSArray *)entitiesInString:(NSString *)string;

/**
 * Decode all the entities within a string.
 */
- (NSString *)decodeString:(NSString *)string;

@end
