//
//  JapanCell.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParametersCell : PSTCollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel * title;
@property (strong, nonatomic) IBOutlet UILabel * subTitle;
@property (strong, nonatomic) IBOutlet UIImageView * circle;

- (void) disabled;
- (void) enabled;
- (void) empty;

@end
