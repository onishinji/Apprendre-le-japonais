//
//  LessonViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 22/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"

@interface LessonViewController : UIViewController <UIPageViewControllerDataSource, UITableViewDataSource, UITableViewDelegate, WEPopoverControllerDelegate>
{
    int currentIndex;
    int fontSize;
    
	WEPopoverController *popoverController;
	Class popoverClass;
    
    NSArray * titleLessons;
    
}
    
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;
@property (nonatomic, retain) WEPopoverController *popoverController;

-(IBAction)sizeUp:(id)sender;
-(IBAction)sizeDown:(id)sender;
- (WEPopoverContainerViewProperties *)improvedContainerViewProperties;

@end
