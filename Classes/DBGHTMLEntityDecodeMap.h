//
//  DBGHTMLEntityDecodeMap.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityDecodeMap : NSObject

/**
 * The raw NSDictionary used for named mappings. This is
 * mostly exposed for use by the encoder.
 */
@property (nonatomic, readonly, strong) NSDictionary *rawMap;

/**
 * Support keyed subscript (e.g. map[@"quot"]) interaction. This will
 * return the nil if no mapping can be done.
 */
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
