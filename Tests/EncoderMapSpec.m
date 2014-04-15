//
//  EncoderMapSpec.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/14/14
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "DBGHTMLEntityEncodeMap.h"

SpecBegin(EncoderMapSpec)

describe(@"EncoderMapSpec", ^{
    
    __block DBGHTMLEntityEncodeMap *encodeMap;
    
    before(^{
        encodeMap = [[DBGHTMLEntityEncodeMap alloc] init];
    });
    
    it(@"should encode basic entities", ^{
        expect([encodeMap encodeAsNamed:[@"&" characterAtIndex:0]]).to.equal(@"&amp;");
        expect([encodeMap encodeAsNamed:[@"\"" characterAtIndex:0]]).to.equal(@"&quot;");
        expect([encodeMap encodeAsNamed:[@"<" characterAtIndex:0]]).to.equal(@"&lt;");
    });

    it(@"should encode basic entities to decimal", ^{
        expect([encodeMap encodeAsDecimal:[@"&" characterAtIndex:0]]).to.equal(@"&#38;");
        expect([encodeMap encodeAsDecimal:[@"\"" characterAtIndex:0]]).to.equal(@"&#34;");
        expect([encodeMap encodeAsDecimal:[@"<" characterAtIndex:0]]).to.equal(@"&#60;");
        expect([encodeMap encodeAsDecimal:[@">" characterAtIndex:0]]).to.equal(@"&#62;");
        expect([encodeMap encodeAsDecimal:[@"'" characterAtIndex:0]]).to.equal(@"&#39;");
    });
    
    it(@"should encode basic entities to hexadecimal", ^{
        expect([encodeMap encodeAsHex:[@"&" characterAtIndex:0]]).to.equal(@"&#x26;");
        expect([encodeMap encodeAsHex:[@"\"" characterAtIndex:0]]).to.equal(@"&#x22;");
        expect([encodeMap encodeAsHex:[@"<" characterAtIndex:0]]).to.equal(@"&#x3c;");
        expect([encodeMap encodeAsHex:[@">" characterAtIndex:0]]).to.equal(@"&#x3e;");
        expect([encodeMap encodeAsHex:[@"'" characterAtIndex:0]]).to.equal(@"&#x27;");
    });
    
    it(@"should encode extended named entities", ^{
        expect([encodeMap encodeAsNamed:[@"±" characterAtIndex:0]]).to.equal(@"&plusmn;");
        expect([encodeMap encodeAsNamed:[@"ð" characterAtIndex:0]]).to.equal(@"&eth;");
        expect([encodeMap encodeAsNamed:[@"Œ" characterAtIndex:0]]).to.equal(@"&OElig;");
        expect([encodeMap encodeAsNamed:[@"œ" characterAtIndex:0]]).to.equal(@"&oelig;");
    });
    
    it(@"should encode decimal entities", ^{
        expect([encodeMap encodeAsDecimal:[@"“" characterAtIndex:0]]).to.equal(@"&#8220;");
//        expect([encodeMap encodeAsDecimal:[@"…"]).to.equal(@"&#8230;");
    });
    
    it(@"should encode hexadecimal entities", ^{
//        expect([encodeMap encode:@"−"]).to.equal("&#x2212;");
//        expect([encodeMap encode:@"—"]).to.equal("&#x2014;");
    });

});

SpecEnd
