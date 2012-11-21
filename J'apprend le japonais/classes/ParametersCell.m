//
//  JapanCell.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "ParametersCell.h"

@implementation ParametersCell

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize circle = _circle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ParametersCell" owner:self options:nil];
        
        if ([arrayOfViews count] > 1) { return nil; }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[PSTCollectionViewCell class]]) { return nil; }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [_title setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:45]];
        
    }
    
    return self;
    
}

- (void) enabled
{
    [_circle setImage:[UIImage imageNamed:@"circle-green"]];
}

- (void) disabled
{
    [_circle setImage:[UIImage imageNamed:@"circle-red"]];
}

- (void) empty
{
    _title.text = @"";
    _subTitle.text = @"";
    [_circle setImage:nil];
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
