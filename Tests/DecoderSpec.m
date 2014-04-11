//
//  DecoderSpec.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "DBGHTMLEntityDecoder.h"

SpecBegin(DecoderSpec)

describe(@"DecoderSpec", ^{

    __block DBGHTMLEntityDecoder *decoder;

    before(^{
        decoder = [[DBGHTMLEntityDecoder alloc] init];
    });

    it(@"should exist", ^{
        expect(decoder).toNot.beNil();
    });

    it(@"should decode text with a mix of entities", ^{
        NSString *input = @"&quot;bient&ocirc;t&quot; &amp; &#25991;&#x5b57;";
        NSString *output = @"\"bientôt\" & 文字";
        expect([decoder decodeString:input]).to.equal(output);
    });

});

SpecEnd
