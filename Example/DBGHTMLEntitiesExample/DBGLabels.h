//
//  LabelGenerator.h
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/16/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

@interface DBGLabels : NSObject

+ (UILabel *)title:(NSString *)text;
+ (UILabel *)explain:(NSString *)text;
+ (UILabel *)basic:(id)text;
+ (UILabel *)attributed:(NSAttributedString *)attributedText;

@end
