//
//  ContentViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 22/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMHTMLView.h"

@interface ContentViewController : UIViewController
{
    CGFloat fontSize;
}

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) CMHTMLView * htmlView;
@property (strong, nonatomic) NSNumber * nbUpDown;

-(void)sizeUp;
-(void)sizeDown;

@end
