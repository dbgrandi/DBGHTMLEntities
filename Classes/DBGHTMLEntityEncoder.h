//
//  DBGHTMLEntityEncoder.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, DBGHTMLEntityEncoderFormats) {
    DBGHTMLEntityEncoderNamedFormat = 1 << 0,
    DBGHTMLEntityEncoderDecimalFormat = 1 << 1,
    DBGHTMLEntityEncoderHexFormat = 1 << 2
};

@interface DBGHTMLEntityEncoder : NSObject

- (NSString *)encode:(NSString *)string;

- (NSString *)encode:(NSString *)string withFormats:(DBGHTMLEntityEncoderFormats)formats;

- (NSMutableString *)encodeStringInPlace:(NSMutableString *)mutableString;

- (NSMutableString *)encodeStringInPlace:(NSMutableString *)mutableString withFormats:(DBGHTMLEntityEncoderFormats)formats;

- (BOOL)stringNeedsEncoding:(NSString *)string;
- (BOOL)stringContainsOnlyASCII:(NSString *)string;

- (NSCharacterSet *)basicEntitiesCharacterSet;
- (NSCharacterSet *)nonASCIICharacterSet;

- (NSArray *)rangesOfCharacters:(NSCharacterSet *)characterSet string:(NSString *)str;

@end
