//
//  RandomHiragana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonController.h"
#import "LessonRandomHiragana.h"

@interface LessonController ()

@end

@implementation LessonController

@synthesize lesson = _lesson;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize currentController = _currentController;

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
    
    NSLog(@"%@", _currentController);
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(
                                                                          0,
                                                                          0,
                                                                          self.view.frame.size.width,
                                                                          self.view.frame.size.height - 44
                                                                          )
                            ];
    scroll.scrollEnabled = YES;
    scroll.bounces = FALSE;
    scroll.contentSize = CGSizeMake(_currentController.view.frame.size.width, _currentController.view.frame.size.height);
    
    [scroll addSubview:_currentController.view];
    
    [self.view addSubview:scroll];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
