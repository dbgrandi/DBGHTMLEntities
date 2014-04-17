//
//  DBGHTMLEntityDecoder+Private.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/17/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#ifndef DBGHTMLEntitiesExample_DBGHTMLEntityDecoder_Private_h
#define DBGHTMLEntitiesExample_DBGHTMLEntityDecoder_Private_h

@interface DBGHTMLEntityDecoder (Private)

/**
 * Match entities within the string using a Regular Expression.
 */
- (NSArray *)entitiesInString:(NSString *)string;

@end

#endif
