//
//  JapanCell.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "JapanCell.h"

@implementation JapanCell

@synthesize title = _title;
@synthesize subTitle = _subTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"JapanCell" owner:self options:nil];
        
        if ([arrayOfViews count] > 1) { return nil; }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[PSTCollectionViewCell class]]) { return nil; }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
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
