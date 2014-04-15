//
//  DBGExampleViewController.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/11/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGExampleViewController.h"
#import "DBGHTMLEntityDecoder.h"
#import "ORStackScrollView.h"

@implementation DBGExampleViewController

- (void)loadView {
    ORStackScrollView *stackScrollView = [[ORStackScrollView alloc] init];
    stackScrollView.backgroundColor = [UIColor whiteColor];
    self.view = stackScrollView;

    ORStackView *stackView = stackScrollView.stackView;

    DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];

    //
    // examples with NSString, one is regular, the other is decoded
    //
    UILabel *explainLabel = [self explainLabelWithText:@"Labels with NSStrings."];
    [stackView addSubview:explainLabel withTopMargin:@"50" sideMargin:@"20"];

    UILabel *basicStringLabel = [self basicLabelWithText:[self basicString]];
    [stackView addSubview:basicStringLabel withTopMargin:@"10" sideMargin:@"20"];

    UILabel *escapedBasicStringLabel = [self basicLabelWithText:[decoder decodeString:[self basicString]]];
    [stackView addSubview:escapedBasicStringLabel withTopMargin:@"10" sideMargin:@"20"];

    //
    // examples with NSAttributedString, one regular, one decoded
    //
    UILabel *explain2Label = [self explainLabelWithText:@"Labels with NSAttributedStrings."];
    [stackView addSubview:explain2Label withTopMargin:@"50" sideMargin:@"20"];

    UILabel *attributedStringLabel = [self attributedLabelWithText:[self tweetString]];
    [stackView addSubview:attributedStringLabel withTopMargin:@"10" sideMargin:@"20"];

    NSMutableAttributedString *tweetString = [self tweetString];
    NSMutableString *mutableTweetString = tweetString.mutableString;
    [decoder decodeStringInPlace:mutableTweetString];

    UILabel *escapedAttributedStringLabel = [self attributedLabelWithText:tweetString];
    [stackView addSubview:escapedAttributedStringLabel withTopMargin:@"10" sideMargin:@"20"];

    
    UIView *footerSpacer = [[UIView alloc] init];
    [stackView addSubview:footerSpacer withTopMargin:@"40"];
}

#pragma mark - Label generators

- (UILabel *)explainLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Medium" size:22];
    label.numberOfLines = 0;
    label.text = text;
    
    return label;
}

- (UILabel *)basicLabelWithText:(id)text {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22];
    label.text = text;
    
    return label;
}

- (UILabel *)attributedLabelWithText:(NSAttributedString *)attributedText {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.attributedText = attributedText;
    
    return label;
}

#pragma mark - String generators

- (NSString *)basicString {
    return @"Today &amp; tomorrow only, we&apos;ve got extra pies to give out. Not to be confused with &#960; #betterthandonuts, cc/ @dbgrandi";
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
