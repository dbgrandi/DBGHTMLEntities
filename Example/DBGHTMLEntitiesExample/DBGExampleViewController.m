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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    ORStackView *stackView = stackScrollView.stackView;
    
    DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];
    
    UIFont *explainFont = [UIFont fontWithName:@"AvenirNext-Medium" size:22];
    UIFont *labelFont = [UIFont fontWithName:@"AvenirNext-Regular" size:22];

    UILabel *explainLabel = [[UILabel alloc] init];
    explainLabel.font = explainFont;
    explainLabel.numberOfLines = 0;
    explainLabel.text = @"Labels with NSStrings.";
    [stackView addSubview:explainLabel withTopMargin:@"50" sideMargin:@"20"];
    
    // add a label with basic string
    UILabel *basicStringLabel = [[UILabel alloc] init];
    basicStringLabel.font = labelFont;
    basicStringLabel.numberOfLines = 0;
    basicStringLabel.text = [self basicString];
    [stackView addSubview:basicStringLabel withTopMargin:@"10" sideMargin:@"20"];

    // add a label with basic escaped string
    UILabel *escapedBasicStringLabel = [[UILabel alloc] init];
    escapedBasicStringLabel.font = labelFont;
    escapedBasicStringLabel.numberOfLines = 0;
    escapedBasicStringLabel.text = [decoder decodeString:[self basicString]];
    [stackView addSubview:escapedBasicStringLabel withTopMargin:@"10" sideMargin:@"20"];
    
    UILabel *explain2Label = [[UILabel alloc] init];
    explain2Label.font = explainFont;
    explain2Label.numberOfLines = 0;
    explain2Label.text = @"Labels with NSAttributedStrings.";
    [stackView addSubview:explain2Label withTopMargin:@"50" sideMargin:@"20"];

    // add a label with attributed string
    UILabel *attributedStringLabel = [[UILabel alloc] init];
    attributedStringLabel.numberOfLines = 0;
    attributedStringLabel.attributedText = [self tweetString];
    [stackView addSubview:attributedStringLabel withTopMargin:@"10" sideMargin:@"20"];

    NSMutableAttributedString *tweetString = [self tweetString];
    NSMutableString *mutableTweetString = tweetString.mutableString;
    [decoder decodeStringInPlace:mutableTweetString];

    // add a label with attributed escaped string
    UILabel *escapedAttributedStringLabel = [[UILabel alloc] init];
    escapedAttributedStringLabel.numberOfLines = 0;
    escapedAttributedStringLabel.attributedText = tweetString;
    [stackView addSubview:escapedAttributedStringLabel withTopMargin:@"10" sideMargin:@"20"];
    
    UIView *footerSpacer = [[UIView alloc] init];
    [stackView addSubview:footerSpacer withTopMargin:@"40"];
}

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
