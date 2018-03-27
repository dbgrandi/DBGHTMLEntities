//
//  DBGExampleViewController.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/11/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGDecodeExampleViewController.h"
#import "DBGHTMLEntityDecoder.h"
#import "DBGLabelHelpers.h"

#import <ORStackView/ORStackScrollView.h>

@implementation DBGDecodeExampleViewController

- (void)loadView {
    ORStackScrollView *stackScrollView = [[ORStackScrollView alloc] init];
    stackScrollView.backgroundColor = [UIColor whiteColor];
    self.view = stackScrollView;

    ORStackView *stackView = stackScrollView.stackView;

    DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];
    
    [stackView addSubview:[DBGLabelHelpers titleLabel:@"Decoder Examples"]
            withPrecedingMargin:40
               sideMargin:20];

    //
    // examples with NSString, one is regular, the other is decoded
    //
    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Labels with an NSString"]
      withPrecedingMargin:50
               sideMargin:20];

    [stackView addSubview:[DBGLabelHelpers basicLabel:[self basicString]]
      withPrecedingMargin:10
               sideMargin:20];

    NSString *decodedString = [decoder decodeString:[self basicString]];
    [stackView addSubview:[DBGLabelHelpers basicLabel:decodedString]
      withPrecedingMargin:10
               sideMargin:20];

    //
    // examples with NSAttributedString, one regular, one decoded
    //
    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Labels with an NSMutableAttributedString"]
      withPrecedingMargin:50
               sideMargin:20];

    [stackView addSubview:[DBGLabelHelpers attributedLabel:[self tweetString]]
      withPrecedingMargin:10
               sideMargin:20];

    NSMutableAttributedString *tweetString = [self tweetString];
    NSMutableString *mutableTweetString = tweetString.mutableString;
    [decoder decodeStringInPlace:mutableTweetString];

    [stackView addSubview:[DBGLabelHelpers attributedLabel:tweetString]
      withPrecedingMargin:10
               sideMargin:20];

    // footer spacer
    [stackView addSubview:[[UIView alloc] init] withPrecedingMargin:40];
}


#pragma mark - String generators

- (NSString *)basicString {
    return @"Today &amp; tomorrow only, we&apos;ve got extra pies to give out. Not to be confused with &#960; #betterthandonuts, cc/ @dbgrandi &#128077;";
}

- (NSMutableAttributedString *)tweetString {
    UIFont *labelFont = [UIFont fontWithName:@"AvenirNext-Regular" size:22];
    NSDictionary *attributes = @{NSFontAttributeName:labelFont};
    
    NSString *basicString = [self basicString];

    NSMutableAttributedString *attributedTweetString = [[NSMutableAttributedString alloc] initWithString:basicString attributes:attributes];
    
    NSRange hashtagRange = [basicString rangeOfString:@"#betterthandonuts"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:hashtagRange];
    
    NSRange mentionRange = [basicString rangeOfString:@"@dbgrandi"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:mentionRange];

    return attributedTweetString;
}

@end
