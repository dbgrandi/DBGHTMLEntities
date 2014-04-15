//
//  EncoderSpec.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "DBGHTMLEntityEncoder.h"

SpecBegin(EncoderSpec)

describe(@"EncoderSpec", ^{

    __block DBGHTMLEntityEncoder *encoder;

    before(^{
        encoder = [[DBGHTMLEntityEncoder alloc] init];
    });
    
    it(@"should detect if a string needs encoding", ^{
        expect([encoder stringNeedsEncoding:@"asdf"]).to.beFalsy();
        expect([encoder stringNeedsEncoding:@"`"]).to.beFalsy();

        expect([encoder stringNeedsEncoding:@"&"]).to.beTruthy();
        expect([encoder stringNeedsEncoding:@"'"]).to.beTruthy();
        expect([encoder stringNeedsEncoding:@">"]).to.beTruthy();
        expect([encoder stringNeedsEncoding:@"<"]).to.beTruthy();
        expect([encoder stringNeedsEncoding:@"文字"]).to.beTruthy();
    });

    it(@"should not encode normal ASCII", ^{
        expect([encoder encode:@"`"]).to.equal(@"`");
        expect([encoder encode:@" "]).to.equal(@" ");
        expect([encoder encode:@"Nothing to encode here."]).to.equal(@"Nothing to encode here.");
    });

    it(@"should parse the correct number of ranges", ^{
        NSCharacterSet *basicEntities = [encoder basicEntitiesCharacterSet];
        expect([[encoder rangesOfCharacters:basicEntities string:@"<html>"] count]).to.equal(2);
    });

    it(@"should default to encoding basic entities as basic", ^{
        expect([encoder encode:@"<html>"]).to.equal(@"&lt;html&gt;");
    });

    it(@"should encode text using mix of entities", ^{
        NSString *original = @"\"bientôt\" & 文字";

        DBGHTMLEntityEncoderFormats namedAndHex = (DBGHTMLEntityEncoderNamedFormat | DBGHTMLEntityEncoderHexFormat);
        expect([encoder encode:original withFormats:namedAndHex]).to.equal(@"&quot;bient&ocirc;t&quot; &amp; &#x6587;&#x5b57;");

        DBGHTMLEntityEncoderFormats namedAndDecimal = (DBGHTMLEntityEncoderNamedFormat | DBGHTMLEntityEncoderDecimalFormat);
        expect([encoder encode:original withFormats:namedAndDecimal]).to.equal(@"&quot;bient&ocirc;t&quot; &amp; &#25991;&#23383;");
    });

    it(@"should double encode existing entity", ^{
        expect([encoder encode:@"&amp;"]).to.equal(@"&amp;amp;");
    });
});

SpecEnd
