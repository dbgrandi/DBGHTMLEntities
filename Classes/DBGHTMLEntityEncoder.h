//
//  DBGHTMLEntityEncoder.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityEncoder : NSObject

- (NSString *)encode:(NSString *)string;

- (NSMutableString *)encodeStringInPlace:(NSMutableString *)mutableString;

@end
