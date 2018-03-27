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
        expect([encodeMap encodeAsNamed:'&']).to.equal(@"&amp;");
        expect([encodeMap encodeAsNamed:'"']).to.equal(@"&quot;");
        expect([encodeMap encodeAsNamed:'<']).to.equal(@"&lt;");
    });

    it(@"should encode basic entities to decimal", ^{
        expect([encodeMap encodeAsDecimal:'&']).to.equal(@"&#38;");
        expect([encodeMap encodeAsDecimal:'"']).to.equal(@"&#34;");
        expect([encodeMap encodeAsDecimal:'<']).to.equal(@"&#60;");
        expect([encodeMap encodeAsDecimal:'>']).to.equal(@"&#62;");
        expect([encodeMap encodeAsDecimal:'\'']).to.equal(@"&#39;");
    });
    
    it(@"should encode basic entities to hexadecimal", ^{
        expect([encodeMap encodeAsHex:'&']).to.equal(@"&#x26;");
        expect([encodeMap encodeAsHex:'"']).to.equal(@"&#x22;");
        expect([encodeMap encodeAsHex:'<']).to.equal(@"&#x3c;");
        expect([encodeMap encodeAsHex:'>']).to.equal(@"&#x3e;");
        expect([encodeMap encodeAsHex:'\'']).to.equal(@"&#x27;");
    });
    
    it(@"should encode extended named entities", ^{
        expect([encodeMap encodeAsNamed:L'±']).to.equal(@"&plusmn;");
        expect([encodeMap encodeAsNamed:L'ð']).to.equal(@"&eth;");
        expect([encodeMap encodeAsNamed:L'Œ']).to.equal(@"&OElig;");
        expect([encodeMap encodeAsNamed:L'œ']).to.equal(@"&oelig;");
    });
    
    it(@"should encode decimal entities", ^{
        expect([encodeMap encodeAsDecimal:L'“']).to.equal(@"&#8220;");
        expect([encodeMap encodeAsDecimal:L'…']).to.equal(@"&#8230;");
        expect([encodeMap encodeAsDecimal:L'👍']).to.equal(@"&#128077;");
    });
    
    it(@"should encode hexadecimal entities", ^{
        expect([encodeMap encodeAsHex:L'−']).to.equal(@"&#x2212;");
        expect([encodeMap encodeAsHex:L'—']).to.equal(@"&#x2014;");
        expect([encodeMap encodeAsHex:L'👍']).to.equal(@"&#x1f44d;");
    });

});

SpecEnd
