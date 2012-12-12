//
//  HelpViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 12/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender
{
    [self dismissOverViewControllerAnimated:YES];
}

@end
