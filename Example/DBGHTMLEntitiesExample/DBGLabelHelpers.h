//
//  LabelGenerator.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/16/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGLabelHelpers : NSObject

+ (UILabel *)titleLabel:(NSString *)text;
+ (UILabel *)explainLabel:(NSString *)text;
+ (UILabel *)basicLabel:(id)text;
+ (UILabel *)attributedLabel:(NSAttributedString *)attributedText;

@end
