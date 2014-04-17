//
//  DBGHTMLEntityEncoder+Private.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/17/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#ifndef DBGHTMLEntitiesExample_DBGHTMLEntityEncoder_Private_h
#define DBGHTMLEntitiesExample_DBGHTMLEntityEncoder_Private_h

@interface DBGHTMLEntityEncoder (Private)

/**
 * Does a string need to be encoded?
 */
- (BOOL)stringNeedsEncoding:(NSString *)string;

/**
 * Given a characterSet and string, return an array of NSRange matches.
 */
- (NSArray *)rangesOfCharacters:(NSCharacterSet *)characterSet string:(NSString *)str;

@end

#endif
