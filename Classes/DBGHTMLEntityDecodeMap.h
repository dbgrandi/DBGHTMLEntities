//
//  DBGHTMLEntityDecodeMap.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityDecodeMap : NSObject

/**
 * Support keyed subscript (e.g. map[@"quot"]) interaction. This will
 * return the key if no mapping can be done. This MAY change to return
 * nil in the future.
 */
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
