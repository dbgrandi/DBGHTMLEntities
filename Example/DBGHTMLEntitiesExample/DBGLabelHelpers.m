//
//  LabelGenerator.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/16/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGLabelHelpers.h"

@implementation DBGLabelHelpers

+ (UILabel *)titleLabel:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:28];
    titleLabel.numberOfLines = 0;
    titleLabel.text = text;
    titleLabel.backgroundColor = UIColor.whiteColor;
    
    return titleLabel;
}

+ (UILabel *)explainLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Medium" size:22];
    label.numberOfLines = 0;
    label.text = text;
    label.backgroundColor = UIColor.whiteColor;

    return label;
}

+ (UILabel *)basicLabel:(id)text {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22];
    label.text = text;
    label.backgroundColor = UIColor.whiteColor;

    return label;
}

+ (UILabel *)attributedLabel:(NSAttributedString *)attributedText {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.attributedText = attributedText;
    label.backgroundColor = UIColor.whiteColor;

    return label;
}

@end
