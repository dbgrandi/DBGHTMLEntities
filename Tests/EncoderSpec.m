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

    it(@"should encode text using mix of entities", ^{
        NSString *original = @"\"bientôt\" & 文字";

        // :basic, :named, :hexadecimal
        expect([encoder encode:original]).to.equal(@"&quot;bient&ocirc;t&quot; &amp; &#x6587;&#x5b57;");

        // :basic, :named, :decimal
        expect([encoder encode:original]).to.equal(@"&quot;bient&ocirc;t&quot; &amp; &#25991;&#23383;");
    });

    it(@"should sort commands when encoding using mix of entities", ^{
        NSString *original = @"\"bientôt\" & 文字";

        // :named, :hexadecimal, :basic
        expect([encoder encode:original]).to.equal(@"&quot;bient&ocirc;t&quot; &amp; &#x6587;&#x5b57;");

        // :decimal, :named, :basic
        expect([encoder encode:original]).to.equal(@"&quot;bient&ocirc;t&quot; &amp; &#25991;&#23383;");
    });

    it(@"should not encode normal ASCII", ^{
        expect([encoder encode:@"`"]).to.equal(@"`");
        expect([encoder encode:@" "]).to.equal(@" ");
    });

    it(@"should double encode existing entity", ^{
        expect([encoder encode:@"&amp;"]).to.equal(@"&amp;amp;");
    });
});

SpecEnd
