//
//  DBGHTMLEntityEncodeMap.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBGHTMLEntityEncodeMap.h"
#import "DBGHTMLEntityDecodeMap.h"

@interface DBGHTMLEntityEncodeMap ()

@property (nonatomic, readonly, strong) NSDictionary *namedMap;

@end

@implementation DBGHTMLEntityEncodeMap

- (NSDictionary *)namedMap {
    static NSDictionary *_sharedMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBGHTMLEntityDecodeMap *decodeMap = [[DBGHTMLEntityDecodeMap alloc] init];
        NSDictionary *rawDecodeMap = decodeMap.rawMap;
        NSMutableDictionary *mutableMap = [@{} mutableCopy];
        
        for (NSString *key in rawDecodeMap) {
            mutableMap[rawDecodeMap[key]] = key;
        }
        
        _sharedMap = [NSDictionary dictionaryWithDictionary:mutableMap];
    });
    
    return _sharedMap;
}

- (NSString *)encodeAsNamed:(UTF32Char)inputChar {
    NSNumber *charNumber = [NSNumber numberWithUnsignedInt:inputChar];
    if (self.namedMap[charNumber]) {
        return [NSString stringWithFormat:@"&%@;", self.namedMap[charNumber]];
    }
    return nil;
}

- (NSString *)encodeAsHex:(UTF32Char)inputChar {
    // check to make sure we SHOULD encode this hex value?
    return [NSString stringWithFormat:@"&#x%lx;", (unsigned long)inputChar];
}

- (NSString *)encodeAsDecimal:(UTF32Char)inputChar {
    // check to make sure we SHOULD encode this decimal value?
    return [NSString stringWithFormat:@"&#%lu;", (unsigned long)inputChar];
}

@end
