//
//  HomeViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "HomeViewController.h"
#import "constant.h"
#import "HomeKanaViewController.h"
#import "VocabularyViewController.h"
#import "UIColor+RGB.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize managedObjectContext = _managedObjectContext;


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:TRUE];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.bounds = self.view.bounds;
    gradient.frame = CGRectMake(0, 0, 1024, 320);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithR:255 G:77 B:63 A:1]CGColor], (id)[[UIColor colorWithR:127 G:0 B:13 A:1]CGColor], nil];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(![segue.identifier isEqualToString:@"vocabulary"])
    {
        HomeKanaViewController *dest = (HomeKanaViewController *)[segue destinationViewController];
        
        if ([segue.identifier isEqualToString:@"hiragana"]) {
            ([dest setKanaType:[NSNumber numberWithInt:TYPE_HIRAGANA]]);
        } else if ([segue.identifier isEqualToString:@"katakana"]) {
            ([dest setKanaType:[NSNumber numberWithInt:TYPE_KATAKANA]]);
        }
    }

    if([segue.identifier isEqualToString:@"vocabulary"])
    {
        VocabularyViewController *dest = (VocabularyViewController *)[segue destinationViewController];
        [dest activeController];
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
