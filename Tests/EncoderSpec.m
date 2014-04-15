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

    it(@"shoudl encode text using mix of entities", ^{
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
    
    it(@"should detect illegal encoding command", ^{
        //def test_should_detect_illegal_encoding_command
        //assert_raise HTMLEntities::InstructionError do
        //HTMLEntities.new.encode('foo', :bar, :baz)
        //end
        //end
    });
    
    it(@"should not encode normal ASCII", ^{
        //def test_should_not_encode_normal_ASCII
        //assert_encode '`', '`'
        //assert_encode ' ', ' '
        //end
    });
    
    it(@"should double encode existing entity", ^{
        //def test_should_double_encode_existing_entity
        //assert_encode '&amp;amp;', '&amp;'
        //end
    });
});

SpecEnd
