//
//  RoundTripSpec.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/19/14
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "DBGHTMLEntityDecodeMap.h"
#import "DBGHTMLEntityDecoder.h"
#import "DBGHTMLEntityEncoder.h"

SpecBegin(RoundTripSpec)

describe(@"RoundTripSpec", ^{
    
    __block DBGHTMLEntityDecodeMap *decodeMap;
    __block DBGHTMLEntityDecoder *decoder;
    __block DBGHTMLEntityEncoder *encoder;
    
    before(^{
        decodeMap = [[DBGHTMLEntityDecodeMap alloc] init];
        decoder = [[DBGHTMLEntityDecoder alloc] init];
        encoder = [[DBGHTMLEntityEncoder alloc] init];
    });
    
    it(@"should handle round trip encoding of everything in the decoder map", ^{
        NSDictionary *rawMap = decodeMap.rawMap;
        
        // start with encoded &apos; -> decode to ' -> encode:named to &apos;
        for(id key in rawMap) {
            NSString *initialString = [NSString stringWithFormat:@"&%@;", key];
            NSString *decodedString = [decoder decodeString:initialString];
            NSString *roundTrippedString = [encoder encode:decodedString];
            expect(roundTrippedString).to.equal(initialString);
        }
    });

});

SpecEnd
