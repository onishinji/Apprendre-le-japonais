//
//  HomeKanaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "HomeKanaViewController.h"
#import "LessonControllerViewController.h"

@interface HomeKanaViewController ()

@end

@implementation HomeKanaViewController

@synthesize kanaType = _kanaType;

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
     
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@  from %@", segue.identifier, self.kanaType);
    
    LessonControllerViewController *dest = (LessonControllerViewController *)[segue destinationViewController];
    [dest setCurrentKanaType:self.kanaType];
    
    if ([segue.identifier isEqualToString:@"romanji"]) {
        [dest setCurrentMode:[NSNumber numberWithInt:MODE_ROMANJI_JAPAN]];
    }
    
    if ([segue.identifier isEqualToString:@"japan"]) { 
        [dest setCurrentMode:[NSNumber numberWithInt:MODE_JAPAN_ROMANJI]];
    }
    
    [dest activeController];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
