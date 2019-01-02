//
//  LabelGenerator.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/16/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGLabels.h"

@implementation DBGLabels

+ (UILabel *)title:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:26 weight:UIFontWeightMedium];
    titleLabel.numberOfLines = 0;
    titleLabel.text = text;
    titleLabel.backgroundColor = UIColor.whiteColor;
    
    return titleLabel;
}

+ (UILabel *)explain:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    label.numberOfLines = 0;
    label.text = text;
    label.backgroundColor = UIColor.whiteColor;

    return label;
}

+ (UILabel *)basic:(id)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:22];
    label.text = text;
    label.backgroundColor = UIColor.whiteColor;

    return label;
}

+ (UILabel *)attributed:(NSAttributedString *)attributedText {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.attributedText = attributedText;
    label.backgroundColor = UIColor.whiteColor;

    return label;
}

@end
