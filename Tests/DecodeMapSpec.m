//
//  DecodeMapSpec.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/10/14
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "DBGHTMLEntityDecodeMap.h"

SpecBegin(DecodeMapSpec)

describe(@"DecodeMapSpec", ^{
    
    __block DBGHTMLEntityDecodeMap *decodeMap;

    before(^{
        decodeMap = [[DBGHTMLEntityDecodeMap alloc] init];
    });

    it(@"should decode basic entities", ^{
        expect(decodeMap[@"&apos;"]).to.equal(@"'");
        expect(decodeMap[@"&lt;"]).to.equal(@"<");
        expect(decodeMap[@"&quot;"]).to.equal(@"\"");
        expect(decodeMap[@"&gt;"]).to.equal(@">");
    });

    it(@"should decode extended named entities", ^{
        expect(decodeMap[@"&plusmn;"]).to.equal(@"±");
        expect(decodeMap[@"&eth;"]).to.equal(@"ð");
        expect(decodeMap[@"&OElig;"]).to.equal(@"Œ");
        expect(decodeMap[@"&oelig;"]).to.equal(@"œ");
    });

    it(@"should decode decimal entities", ^{
        expect(decodeMap[@"&#8220;"]).to.equal(@"“");
        expect(decodeMap[@"&#8230;"]).to.equal(@"…");
        expect(decodeMap[@"&#32;"]).to.equal(@" ");
        expect(decodeMap[@"&#128077;"]).to.equal(@"👍");
    });

    it(@"should decode hexadecimal entities", ^{
        expect(decodeMap[@"&#x2212;"]).to.equal(@"−");
        expect(decodeMap[@"&#x2014;"]).to.equal(@"—");
        expect(decodeMap[@"&#x0060;"]).to.equal(@"`");
        expect(decodeMap[@"&#x60;"]).to.equal(@"`");
    });
    
    it(@"should not decode jibberish", ^{
        expect(decodeMap[@"&abacadabba;"]).to.beNil();
        expect(decodeMap[@"1"]).to.beNil();
        expect(decodeMap[@"&;"]).to.beNil();
        expect(decodeMap[@""]).to.beNil();
        expect(decodeMap[@"&#12345678;"]).to.beNil();
    });

});

SpecEnd
