//
//  LessonRandomHiragana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "KanaRandomController.h"
#import "Computer.h"

@interface KanaRandomController ()

- (void) displayNext;

@end

@implementation KanaRandomController

@synthesize btnNext = _btnNext;
@synthesize btnPrev = _btnPrev;
@synthesize msg = _msg;
@synthesize kanaFlipView = _kanaFlipView;



- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"activeController %@, %@", self.currentKanaType, self.currentMode);
    
    [_kanaFlipView setMode:self.currentMode];
    
    [_btnNext addTarget:self action:@selector(displayNext) forControlEvents:UIControlEventTouchUpInside];
    [_btnPrev addTarget:self action:@selector(displayPrevious) forControlEvents:UIControlEventTouchUpInside];
    
    [self displayNext];
    
}
- (void) activeController
{
    
    knows = [[NSMutableArray alloc] init];
    knowsRomanji = [[NSMutableArray alloc] init];
    currentPos = 0;
}

-(void) displayNext
{

    currentPos++;
    
    // switch type
    int nbKanaLesson = 0;
    if([self isForHiragana])
    {
        nbKanaLesson = [[[Computer sharedInstance] getSelectedsHiragana] count];
    }
    else
    {
        nbKanaLesson = [[[Computer sharedInstance] getSelectedsKatakana] count];
    }
    
    if(nbKanaLesson == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Oups !" message:@"Vous n'avez aucun Kana à apprendre ! Il faut aller dans l'écran Paramètre pour en ajouter." delegate:nil cancelButtonTitle:@"Fermer" otherButtonTitles:nil, nil] show];
    }
    
    Kana * kana = nil;
    if(currentPos < [knows count])
    {
        kana = [knows objectAtIndex:currentPos];
    }
    else
    {
        // switch type
        if([self isForHiragana])
        {
            kana = [[Computer sharedInstance] getRandomHiragana:knowsRomanji];
            
        }
        else
        {
            kana = [[Computer sharedInstance] getRandomKatakana:knowsRomanji];
        }
    
        if(kana != nil)
        {
            currentPos = [knows count];
            [knowsRomanji addObject:kana.romanji];
            [knows addObject:kana];
            
        }
    }
    
    //
    int nb = 0;
    if([self isForHiragana])
    {
         nb = nbKanaLesson - currentPos - 1;
    }
    else
    {
        nb = nbKanaLesson - currentPos - 1;
    }
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        _msg.text = [NSString stringWithFormat:@"Encore %i kana à deviner", nb ];
    }
    
    if(currentPos >= nbKanaLesson)
    {
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        
        _msg.text = @"Fini ! ";
        [_kanaFlipView displayEmpty];
        currentPos = 0;
    }
    else
    {
        [self.kanaFlipView displayNext:kana];
    }

}

- (void) displayPrevious
{
    if(currentPos > 0)
    {
        currentPos--;
        currentPos--;
        [self displayNext];
    }
    
}


- (IBAction)openHelp:(UIBarButtonItem *)bar
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
    helpVC = [storyboard instantiateViewControllerWithIdentifier:@"helpRandom"];
    
    if(openHelpAlready)
    {
        openHelpAlready = false;
        [self dismissOverViewControllerAnimated:YES];
    }
    else
    {
        openHelpAlready = true;
        [self presentOverViewController:helpVC animated:YES];
    }
}

@end
