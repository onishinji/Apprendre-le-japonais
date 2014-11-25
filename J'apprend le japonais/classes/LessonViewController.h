//
//  LessonViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 22/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "RAPageViewController.h"
#import "ContentViewController.h"

@interface LessonViewController : UIViewController <RAPageViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, WEPopoverControllerDelegate, ContentViewControllerDelegate>
{
    int currentIndex;
    int nbSizeUpDown;
    
	WEPopoverController *popoverController;
	Class popoverClass;
    
    NSArray * titleLessons;
    UITableViewController *contentViewController;
    
}
    
@property (strong, nonatomic) RAPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;
@property (nonatomic, retain) WEPopoverController *popoverController;

-(IBAction)sizeUp:(id)sender;
-(IBAction)sizeDown:(id)sender;
- (WEPopoverContainerViewProperties *)improvedContainerViewProperties;

@end
