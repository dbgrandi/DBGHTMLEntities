//
//  DBGExampleViewController.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/11/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGExampleViewController.h"
#import "DBGHTMLEntityDecoder.h"
#import "DBGHTMLEntityEncoder.h"
#import "DBGLabels.h"

@interface UIStackView (SpacingHelper)
- (void)addArrangedSubview:(UIView *)view withCustomSpacing:(CGFloat)spacing;
@end

@implementation UIStackView (SpacingHelper)
- (void)addArrangedSubview:(UIView *)view withCustomSpacing:(CGFloat)spacing {
    [self addArrangedSubview:view];
    [self setCustomSpacing:spacing afterView:view];
}
@end

@interface DBGExampleViewController ()
@property (nonatomic) UIStackView *stackView;
@end

@implementation DBGExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:scrollView];

    UILayoutGuide *safe = self.view.safeAreaLayoutGuide;

    [scrollView.topAnchor constraintEqualToAnchor:safe.topAnchor].active = YES;
    [scrollView.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor].active = YES;
    [scrollView.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor].active = YES;
    [scrollView.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor].active = YES;

    self.stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentFill;
    [scrollView addSubview:self.stackView];

    [self.stackView.topAnchor constraintEqualToAnchor:scrollView.topAnchor].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor].active = YES;
    [self.stackView.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor constant:20].active = YES;
    [self.stackView.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor constant:-20].active = YES;
    [self.stackView.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor constant:-40].active = YES;

    [self addDecoderExamples];
    [self addEncoderExamples];
}

- (void) addDecoderExamples {
    DBGHTMLEntityDecoder *decoder = [[DBGHTMLEntityDecoder alloc] init];
    NSString *encodedString = @"Today &amp; tomorrow only, we&apos;ve got extra pies to give out. Not to be confused with &#960; #betterthandonuts, cc/ @dbgrandi &#128077;";

    [self.stackView addArrangedSubview:[[UIView alloc] initWithFrame:CGRectZero] withCustomSpacing:80];
    [self.stackView addArrangedSubview:[DBGLabels title:@"Decoder Examples"] withCustomSpacing:30];

    //
    // examples with NSString, one is regular, the other is decoded
    //
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Labels with an NSString"] withCustomSpacing:40];
    [self.stackView addArrangedSubview:[DBGLabels basic:encodedString] withCustomSpacing:20];

    NSString *decodedString = [decoder decodeString:encodedString];
    [self.stackView addArrangedSubview:[DBGLabels basic:decodedString] withCustomSpacing:50];

    //
    // examples with NSAttributedString, one regular, one decoded
    //
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Labels with an NSMutableAttributedString"] withCustomSpacing:40];
    [self.stackView addArrangedSubview:[DBGLabels attributed:[self encodedTweetString]] withCustomSpacing:20];

    NSMutableAttributedString *tweetString = [self encodedTweetString];
    NSMutableString *mutableTweetString = tweetString.mutableString;
    [decoder decodeStringInPlace:mutableTweetString];

    [self.stackView addArrangedSubview:[DBGLabels attributed:tweetString] withCustomSpacing:50];
}

- (void)addEncoderExamples {
    DBGHTMLEntityEncoder *encoder = [[DBGHTMLEntityEncoder alloc] init];

    NSString *decodedString = @"Today & tomorrow only, we've got extra pies to give out. Not to be confused with π #betterthandonuts, cc/ @dbgrandi 👍 ☺";

    [self.stackView addArrangedSubview:[DBGLabels title:@"Encoder Examples"] withCustomSpacing:50];

    //
    // examples of the default encoding (named > decimal)
    //
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Our example string..."] withCustomSpacing:10];
    [self.stackView addArrangedSubview:[DBGLabels basic:decodedString] withCustomSpacing:50];
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Encoded with default settings..."] withCustomSpacing:10];

    NSString *defaultEncode = [encoder encode:decodedString];
    [self.stackView addArrangedSubview:[DBGLabels basic:defaultEncode] withCustomSpacing:50];
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Encoded with decimal only..."] withCustomSpacing:10];

    NSString *decimalEncode = [encoder encode:decodedString withFormats:(DBGHTMLEntityEncoderDecimalFormat)];
    [self.stackView addArrangedSubview:[DBGLabels basic:decimalEncode] withCustomSpacing:50];
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Encoded with named preference over hex..."] withCustomSpacing:10];

    NSString *hexPreferenceEncode = [encoder encode:decodedString withFormats:(DBGHTMLEntityEncoderNamedFormat|DBGHTMLEntityEncoderHexFormat)];
    [self.stackView addArrangedSubview:[DBGLabels basic:hexPreferenceEncode] withCustomSpacing:50];

    //
    // examples of default encoding with NSAttributedString, one regular, one decoded
    //
    [self.stackView addArrangedSubview:[DBGLabels explain:@"Default encoding with an NSMutableAttributedString"] withCustomSpacing:10];
    [self.stackView addArrangedSubview:[DBGLabels attributed:[self decodedTweetString]] withCustomSpacing:10];

    NSMutableAttributedString *tweetString = [self decodedTweetString];
    NSMutableString *mutableTweetString = tweetString.mutableString;
    [encoder encodeStringInPlace:mutableTweetString];

    [self.stackView addArrangedSubview:[DBGLabels attributed:tweetString] withCustomSpacing:40];

    // footer spacer
    [self.stackView addArrangedSubview:[[UIView alloc] initWithFrame:CGRectZero]];
}

#pragma mark - String generators

- (NSMutableAttributedString *)encodedTweetString {
    UIFont *labelFont = [UIFont systemFontOfSize:22];
    NSDictionary *attributes = @{NSFontAttributeName:labelFont};
    
    NSString *basicString = @"Today &amp; tomorrow only, we&apos;ve got extra pies to give out. Not to be confused with &#960; #betterthandonuts, cc/ @dbgrandi &#128077;";

    NSMutableAttributedString *attributedTweetString = [[NSMutableAttributedString alloc] initWithString:basicString attributes:attributes];
    
    NSRange hashtagRange = [basicString rangeOfString:@"#betterthandonuts"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:UIColor.lightGrayColor range:hashtagRange];
    
    NSRange mentionRange = [basicString rangeOfString:@"@dbgrandi"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:UIColor.blueColor range:mentionRange];

    return attributedTweetString;
}

- (NSMutableAttributedString *)decodedTweetString {
    UIFont *labelFont = [UIFont fontWithName:@"AvenirNext-Regular" size:22];
    NSDictionary *attributes = @{NSFontAttributeName:labelFont};

    NSString *basicString = @"Today & tomorrow only, we've got extra pies to give out. Not to be confused with π #betterthandonuts, cc/ @dbgrandi 👍 ☺";

    NSMutableAttributedString *attributedTweetString = [[NSMutableAttributedString alloc] initWithString:basicString attributes:attributes];

    NSRange underlineRange = [basicString rangeOfString:@"Today & tomorrow only"];
    [attributedTweetString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:underlineRange];

    NSRange hashtagRange = [basicString rangeOfString:@"#betterthandonuts"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:hashtagRange];

    NSRange mentionRange = [basicString rangeOfString:@"@dbgrandi"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:mentionRange];

    return attributedTweetString;
}

@end
