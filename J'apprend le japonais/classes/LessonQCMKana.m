//
//  LessonQCMHiraganaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 05/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonQCMKana.h"
#import "Computer.h"

@interface LessonQCMKana ()

@end


@implementation LessonQCMKana

@synthesize leftBottomButton = _leftBottomButton;
@synthesize leftMiddleButton = _leftMiddleButton;
@synthesize leftTopButton = _leftTopButton;

@synthesize rightBottomButton = _rightBottomButton;
@synthesize rightMiddleButton = _rightMiddleButton;
@synthesize rightTopButton = _rightTopButton;

@synthesize kanaFlipView = _hiraganaFlipView;

@synthesize scoreLabel = _scoreLabel;

@synthesize goodKana = _goodHiragana;
@synthesize goodRomanji = _goodRomanji;

@synthesize goodKanaPlain = _goodHiraganaPlain;
@synthesize goodRomanjiPlain = _goodRomanjiPlain;

@synthesize falseKana = _falseHiragana;
@synthesize falseRomanji = _falseRomanji;

@synthesize msg = _msg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        currentScore = 0;
        btnArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.kanaFlipView setMode:[[self params] objectForKey:@"mode"]];
    
    [[self.view viewWithTag:100] setHidden:TRUE];
    [[self.view viewWithTag:200] setHidden:TRUE];
    
    //
    [self configureButton:_leftTopButton];
    [self configureButton:_leftMiddleButton];
    [self configureButton:_leftBottomButton];
    [self configureButton:_rightTopButton];
    [self configureButton:_rightMiddleButton];
    [self configureButton:_rightBottomButton];
    
    //
    [btnArray addObject:_leftTopButton];
    [btnArray addObject:_leftMiddleButton];
    [btnArray addObject:_leftBottomButton];
    
    [btnArray addObject:_rightTopButton];
    [btnArray addObject:_rightMiddleButton];
    [btnArray addObject:_rightBottomButton];
    
    //
    [_leftTopButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBottomButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_leftMiddleButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightTopButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBottomButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightMiddleButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    
    [self displayNext];
    // Do any additional setup after loading the view from its nib.
}

- (void) configureButton:(UIButton *)btn
{
    CGFloat size = 0;
    size = btn.titleLabel.font.pointSize;
    [btn.titleLabel setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:size]];
}

- (void) checkResponse:(id)sender
{
    
    if(currentKana != nil)
    {
        UIButton * btn = (UIButton *)sender;
        
        if(
           ([self isForRomanjiToJapan] && [btn.titleLabel.text isEqualToString:currentKana.romanji]) ||
           ([self isForJapanToRomanji] && [btn.titleLabel.text isEqualToString:currentKana.japan])
           )
        {
            currentScore++;
            currentKana.scoring = [NSNumber numberWithInt:[currentKana.scoring intValue] + 1];
            [self displayTrueResponse:currentKana];
        }
        else
        {
            if([self isForHiragana])
            {
                if([self isForRomanjiToJapan])
                {
                    
                    [self displayFalseResponse:currentKana falseReponse:[[Computer sharedInstance] getHiraganaWithRomanji:btn.titleLabel.text]];
                }
                else
                {
                    [self displayFalseResponse:currentKana falseReponse:[[Computer sharedInstance] getHiraganaWithJapan:btn.titleLabel.text]];
                }
            }
            else
            {
                if([self isForRomanjiToJapan])
                {
                    
                    [self displayFalseResponse:currentKana falseReponse:[[Computer sharedInstance] getKatakanaWithRomanji:btn.titleLabel.text]];
                }
                else
                {
                    [self displayFalseResponse:currentKana falseReponse:[[Computer sharedInstance] getKatakanaWithJapan:btn.titleLabel.text]];
                }
            }
            currentKana.scoring = [NSNumber numberWithInt:[currentKana.scoring intValue] - 1];
        }
        [[Computer sharedInstance] flush];
        
    }
    
    
    [self displayNext];
    
    
}

-(void) displayNext
{
    // switch type
    if([self isForHiragana])
    {
        currentKana = [[Computer sharedInstance] getRandomHiragana:knowsRomanji];
    }
    else
    {
        currentKana = [[Computer sharedInstance] getRandomKatakana:knowsRomanji];
    }
    
    int goodIndex = arc4random() % 6;
    
    UIButton * goodButton = [btnArray objectAtIndex:goodIndex];
    
    if([self isForRomanjiToJapan])
    {
        [goodButton setTitle:currentKana.romanji forState:UIControlStateNormal];
    }
    else
    {
        [goodButton setTitle:currentKana.japan forState:UIControlStateNormal];
    }
    
    // switch type
    NSMutableArray * mutableArray;
    if([self isForHiragana])
    {
        mutableArray = [[Computer sharedInstance] getRandomHiraganaExcept:currentKana limit:6];
    }
    else
    {
        mutableArray = [[Computer sharedInstance] getRandomKatakanaExcept:currentKana limit:6];
    }
    
    int i = 0;
    for (Kana * hir in mutableArray) {
        
        if(goodIndex != i)
        {
            UIButton * falseButton = [btnArray objectAtIndex:i];
            
            
            if([self isForRomanjiToJapan])
            {
                [falseButton setTitle:hir.romanji forState:UIControlStateNormal];
            }
            else
            {
                [falseButton setTitle:hir.japan forState:UIControlStateNormal];
            }
        }
        
        i++;
    }
    
    if(currentKana != nil)
    {
        [knowsRomanji addObject:currentKana.romanji];
        [knows addObject:currentKana];
        
        [_hiraganaFlipView setCurrentHiragana:currentKana];
        
    }
    
    // @todo switch type
    int nb = 0;
    
    if([self isForHiragana])
    {
        nb = [[[Computer sharedInstance] getSelectedsHiragana] count] - [knows count];
    }
    else
    {
        nb = [[[Computer sharedInstance] getSelectedsKatakana] count] - [knows count];
    }
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        // @todo switch type
        _msg.text = [NSString stringWithFormat:@"Encore %i kana(s) à deviner", nb ];
    }
    
    if(currentKana == nil)
    {
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        
        
        float percent = (0.0 + currentScore) / (0.0 + [[[Computer sharedInstance] getSelectedsHiragana] count]) * 100;
        // NSLog(@"%f %d  %d", percent, currentScore, [[[Computer sharedInstance] getSelectedsHiragana] count]);
        
        [_hiraganaFlipView displayEmpty];
        
        _msg.text = [NSString stringWithFormat:@"Fini ! ton scocre est de %2.f %% de réussite !", percent];
        currentScore = 0;
        
    }
    else
    {
        [_hiraganaFlipView displayJapan];
    }
    
    _scoreLabel.text = [NSString stringWithFormat:@"%d / %d réussi ", currentScore, [[[Computer sharedInstance] getSelectedsHiragana] count]];
    
}

- (void) displayTrueResponse:(Kana *)kana
{
    [[self.view viewWithTag:100] setHidden:FALSE];
    [[self.view viewWithTag:200] setHidden:TRUE];
    
    _goodHiraganaPlain.text = kana.japan;
    _goodRomanjiPlain.text = kana.romanji;
}

- (void) displayFalseResponse:(Kana *)trueResponse falseReponse:(Kana *)falseResponse
{
    [[self.view viewWithTag:100] setHidden:TRUE];
    [[self.view viewWithTag:200] setHidden:FALSE];
    
    _goodHiragana.text = trueResponse.japan;
    _goodRomanji.text = trueResponse.romanji;
    
    _falseHiragana.text = falseResponse.japan;
    _falseRomanji.text = falseResponse.romanji;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openHelp:(UIBarButtonItem *)bar
{
    helpVC = [[HelpViewController alloc] initWithNibName:@"helpQCM" bundle:nil];
    
    if(openHelpAlready)
    {
        openHelpAlready = false;
        [self.parent dismissOverViewControllerAnimated:YES];
    }
    else
    {
        openHelpAlready = true;
        [self.parent presentOverViewController:helpVC animated:YES];
    }
}

- (void)viewDidUnload {
    [self setKanaFlipView:nil];
    [self setLeftTopButton:nil];
    [self setLeftMiddleButton:nil];
    [self setLeftBottomButton:nil];
    [self setRightTopButton:nil];
    [self setRightMiddleButton:nil];
    [self setRightBottomButton:nil];
    [self setScoreLabel:nil];
    [self setMsg:nil];
    [super viewDidUnload];
}
@end
