//
//  LessonCell.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonCell : PSUICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel * title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UIView * backgroundView;

-(void) configBackground;

-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius;

@end
