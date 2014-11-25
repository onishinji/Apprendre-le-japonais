//
//  JapanCell.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParametersCell : PSTCollectionViewCell
{
    BOOL highlited;
}

@property (strong, nonatomic) IBOutlet UILabel * title;
@property (strong, nonatomic) IBOutlet UILabel * subTitle; 

- (void) disabled;
- (void) enabled;
- (void) empty;
- (BOOL) cellIsHighlighted;

@end
