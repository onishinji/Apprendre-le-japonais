//
//  LessonCell.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonCell.h"
#import "UIColor+RGB.h"

@implementation LessonCell

@synthesize title = _title;
@synthesize icon = _icon;
@synthesize backgroundView = _backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    // todo make background view to change color ...
    if(highlighted)
    {
     //   [self roundView:self.backgroundView onCorner:(UIRectCornerAllCorners) radius:100];
    }
    else
    {
    //    [self roundView:self.backgroundView onCorner:(UIRectCornerAllCorners) radius:10];
    }
}

-(void)configBackground
{
    self.backgroundView.layer.borderColor = [UIColor colorWithR:127 G:0 B:13 A:1].CGColor;
    self.backgroundView.layer.borderWidth = 2.0f;
    self.backgroundView.layer.cornerRadius = 10;
    
    [self roundView:self.backgroundView onCorner:(UIRectCornerAllCorners) radius:10];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.backgroundView.bounds;
    
    
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithR:255 G:77 B:63 A:1] CGColor],(id)[[UIColor colorWithR:235 G:0 B:0 A:1] CGColor],(id)[[UIColor colorWithR:100 G:0 B:0 A:1] CGColor], nil];
    
    [self.backgroundView.layer insertSublayer:gradient atIndex:100];
}


-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    
    [view.layer setMask:maskLayer];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
