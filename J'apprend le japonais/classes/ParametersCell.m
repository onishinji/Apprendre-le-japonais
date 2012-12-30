//
//  JapanCell.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "ParametersCell.h"
#import "UIColor+RGB.h"

@implementation ParametersCell

@synthesize title = _title;
@synthesize subTitle = _subTitle; 

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
        
        [_title setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:80]];
        
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1;
        
        [self disabled];
        
    }
    
    return self;
    
}

- (void) enabled
{
    highlited = true;
    
    _title.textColor = [UIColor colorWithR:0 G:0 B:0 A:1];
    _subTitle.textColor = [UIColor colorWithR:0 G:0 B:0 A:1];
    self.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:0.5]; 
}

- (void) disabled
{
    highlited = false;
    
    int r = 100;
    int g = 100;
    int b = 100;
    
    _title.textColor = [UIColor colorWithR:r G:g B:b A:1];
    _subTitle.textColor = [UIColor colorWithR:r G:g B:b A:1];
    self.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:0.3]; 
}

- (void) empty
{
    self.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:0.3];

    highlited = false;
    
    _title.text = @"";
    _subTitle.text = @"";
    
}

- (BOOL) cellIsHighlighted
{
    return highlited;
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
