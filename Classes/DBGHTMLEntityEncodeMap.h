//
//  DBGHTMLEntityEncodeMap.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGHTMLEntityEncodeMap : NSObject

/**
 * Return the code point as a character entity reference.
 * If there is not a named mapping, return nil.
 */
- (NSString *)encodeAsNamed:(UTF32Char)inputChar;

/**
 * Returns the code point as a numeric character reference
 * encoded in hexidecimal form. e.g. - &#xhhhh;
 */
- (NSString *)encodeAsHex:(UTF32Char)inputChar;

/**
 * Returns the code point as a numeric character reference
 * encoded in decimal form. e.g. - &#nnnn;
 */
- (NSString *)encodeAsDecimal:(UTF32Char)inputChar;

@end
