//
//  DBGHTMLEntityEncoder.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

/**
 * Available format options:
 * - NamedFormat: &quot;
 * - DecimalFormat: &#34
 * - HexFormat: &#x22
 *
 * The default encoder uses Named | Decimal, favoring Named if a
 * mapping exists.
 */
typedef NS_OPTIONS(NSUInteger, DBGHTMLEntityEncoderFormats) {
    DBGHTMLEntityEncoderNamedFormat = 1 << 0,
    DBGHTMLEntityEncoderDecimalFormat = 1 << 1,
    DBGHTMLEntityEncoderHexFormat = 1 << 2
};

@interface DBGHTMLEntityEncoder : NSObject

/**
 * Encode the string using the default formats (named and decimal). Returns
 * a new string.
 */
- (NSString *)encode:(NSString *)string;

/**
 * Encode the string using the passed in formats. If both Decimal and Hex are
 * passed in, Decimal will override Hex. Returns a new string.
 */
- (NSString *)encode:(NSString *)string withFormats:(DBGHTMLEntityEncoderFormats)formats;

/**
 * Encode the string using the default formats (named and decimal).
 */
- (NSMutableString *)encodeStringInPlace:(NSMutableString *)mutableString;

/**
 * Encode the string using the passed in formats. If both Decimal and Hex are
 * passed in, Decimal will override Hex.
 */
- (NSMutableString *)encodeStringInPlace:(NSMutableString *)mutableString withFormats:(DBGHTMLEntityEncoderFormats)formats;

/**
 * Does a string need to be encoded? Exposed mostly for testing.
 */
- (BOOL)stringNeedsEncoding:(NSString *)string;

/**
 * Given a characterSet and string, return an array of NSRange matches.
 */
- (NSArray *)rangesOfCharacters:(NSCharacterSet *)characterSet string:(NSString *)str;

@end
