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

    describe(@"the entity regular expression", ^{
        __block NSArray *matches;
        __block NSString *input;
        
        before(^{
            input = @"&quot;bient&ocirc;t&quot; &amp; &#25991;&#x5b57;";
            matches = [decoder entitiesInString:input];
        });
        
        it(@"matches the right number of entities", ^{
            expect([matches count]).to.equal(6);
        });
        
        it(@"matches all the entities", ^{
            NSTextCheckingResult *match = matches[0];
            expect([input substringWithRange:match.range]).to.equal(@"&quot;");

            match = matches[1];
            expect([input substringWithRange:match.range]).to.equal(@"&ocirc;");
            
            match = matches[2];
            expect([input substringWithRange:match.range]).to.equal(@"&quot;");
            
            match = matches[3];
            expect([input substringWithRange:match.range]).to.equal(@"&amp;");
            
            match = matches[4];
            expect([input substringWithRange:match.range]).to.equal(@"&#25991;");
            
            match = matches[5];
            expect([input substringWithRange:match.range]).to.equal(@"&#x5b57;");
        });

    });

    it(@"should decode text with a mix of entities", ^{
        NSString *input = @"&quot;bient&ocirc;t&quot; &amp; &#25991;&#x5b57;";
        NSString *output = @"\"bientôt\" & 文字";
        expect([decoder decodeString:input]).to.equal(output);
    });
    
    it(@"should decode an empty string", ^{
        expect([decoder decodeString:@""]).to.equal(@"");
    });
    
    it(@"should skip unknown entity", ^{
        expect([decoder decodeString:@"&bogus;"]).to.equal(@"&bogus;");
    });
    
    it(@"should decode a double encoded entity once", ^{
        expect([decoder decodeString:@"&amp;amp;"]).to.equal(@"&amp;");
    });
    
    it(@"should only decode the first element in masked entities", ^{
        expect([decoder decodeString:@"&amp;#3346;"]).to.equal(@"&#3346;");
    });

});

SpecEnd
