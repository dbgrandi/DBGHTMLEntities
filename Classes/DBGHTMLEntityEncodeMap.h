//
//  DBGHTMLEntityEncodeMap.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityEncodeMap : NSObject

- (NSString *)encodeAsNamed:(unichar)inputChar;
- (NSString *)encodeAsHex:(unichar)inputChar;
- (NSString *)encodeAsDecimal:(unichar)inputChar;

@end
