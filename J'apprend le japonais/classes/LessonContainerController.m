//
//  RandomHiragana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonContainerController.h"
#import "LessonRandomKana.h"
#import "LessonQCMKana.h"

@interface LessonContainerController ()

@end

@implementation LessonContainerController

@synthesize lesson = _lesson;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize currentController = _currentController;
@synthesize parameters = _parameters;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"je dois afficher %@", _lesson.title);
    //self.navigationController.navigationBar.topItem.title = _lesson.title;
    
    self.title = _lesson.title;
    self.navigationItem.backBarButtonItem.title = @"Menu";
    self.view.backgroundColor = [UIColor redColor];
    
    _currentController = [[NSClassFromString(_lesson.className) alloc] initWithNibName:_lesson.className bundle:nil];
    
    _currentController.currentKanaType = [[self parameters] objectForKey:@"kanaType"];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(
                                                                          0,
                                                                          0,
                                                                          480,
                                                                          320
                                                                          )
                            ];
    
    NSLog(@" frame %@", NSStringFromCGRect(self.view.frame));
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
    }
    scroll.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    
    
    scroll.scrollEnabled = YES;
    scroll.bounces = FALSE;
    scroll.contentSize = CGSizeMake(_currentController.view.frame.size.width, _currentController.view.frame.size.height);
    
    [scroll addSubview:_currentController.view];
    
    [self.view addSubview:scroll];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
