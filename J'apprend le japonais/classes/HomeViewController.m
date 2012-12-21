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

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize managedObjectContext = _managedObjectContext;


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
