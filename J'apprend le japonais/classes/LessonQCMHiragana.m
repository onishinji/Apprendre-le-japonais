//
//  LessonQCMHiraganaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 05/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonQCMHiragana.h"
#import "Computer.h"

@interface LessonQCMHiragana ()

@end


@implementation LessonQCMHiragana

@synthesize leftBottomButton = _leftBottomButton;
@synthesize leftMiddleButton = _leftMiddleButton;
@synthesize leftTopButton = _leftTopButton;

@synthesize rightBottomButton = _rightBottomButton;
@synthesize rightMiddleButton = _rightMiddleButton;
@synthesize rightTopButton = _rightTopButton;

@synthesize imgCentral = _imgCentral;
@synthesize scoreLabel = _scoreLabel;

@synthesize goodHiragana = _goodHiragana;
@synthesize goodRomanji = _goodRomanji;

@synthesize goodHiraganaPlain = _goodHiraganaPlain;
@synthesize goodRomanjiPlain = _goodRomanjiPlain;

@synthesize falseHiragana = _falseHiragana;
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
    
    
    [[self.view viewWithTag:100] setHidden:TRUE];
    [[self.view viewWithTag:200] setHidden:TRUE];
    
    [btnArray addObject:_leftTopButton];
    [btnArray addObject:_leftMiddleButton];
    [btnArray addObject:_leftBottomButton];
    
    [btnArray addObject:_rightTopButton];
    [btnArray addObject:_rightMiddleButton];
    [btnArray addObject:_rightBottomButton];
    
    [_leftTopButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBottomButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_leftMiddleButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightTopButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBottomButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightMiddleButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    
    [self displayNextHiragana];
    // Do any additional setup after loading the view from its nib.
}

- (void) checkResponse:(id)sender
{
    
    if(currentHiragan != nil)
    {
        UIButton * btn = (UIButton *)sender;
        
        if([btn.titleLabel.text isEqualToString:currentHiragan.romanji])
        {
            currentScore++;
            currentHiragan.scoring = [NSNumber numberWithInt:[currentHiragan.scoring intValue] + 1];
            [self displayTrueResponse:currentHiragan];
        }
        else
        {
         //   currentScore--;
            [self displayFalseResponse:currentHiragan falseReponse:[[Computer sharedInstance] getHiraganaWithRomanji:btn.titleLabel.text]];
            currentHiragan.scoring = [NSNumber numberWithInt:[currentHiragan.scoring intValue] - 1];
        }
        [[Computer sharedInstance] flush];
        
    }
    
    
    [self displayNextHiragana];
    
    
}

-(void) displayNextHiragana
{
    currentHiragan = [[Computer sharedInstance] getRandomHiragana:knowsRomanji];
    
    int goodIndex = arc4random() % 6;
    
    UIButton * goodButton = [btnArray objectAtIndex:goodIndex];
    [goodButton setTitle:currentHiragan.romanji forState:UIControlStateNormal];// = currentHiragan.romanji;
    
    NSMutableArray * mutableArray = [[Computer sharedInstance] getRandomHiraganaExcept:currentHiragan limit:6];
    
    int i = 0;
    for (Hiragana * hir in mutableArray) {
        
        if(goodIndex != i)
        {
            UIButton * falseButton = [btnArray objectAtIndex:i];
            [falseButton setTitle:hir.romanji forState:UIControlStateNormal];
        }
        
        i++;
    }
    
    if(currentHiragan != nil)
    {
        [knowsRomanji addObject:currentHiragan.romanji];
        [knows addObject:currentHiragan];
        
    }
    
    int nb = [[[Computer sharedInstance] getSelectedsHiragana] count] - [knows count];
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        _msg.text = [NSString stringWithFormat:@"Encore %i hiragana(s) à deviner", nb ];
    }
    
    if(currentHiragan == nil)
    {
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        
        
         float percent = (0.0 + currentScore) / (0.0 + [[[Computer sharedInstance] getSelectedsHiragana] count]) * 100;
        // NSLog(@"%f %d  %d", percent, currentScore, [[[Computer sharedInstance] getSelectedsHiragana] count]);
        
        _hiragana.text = @"";
        
        _msg.text = [NSString stringWithFormat:@"Fini ! ton scocre est de %2.f %% de réussite !", percent];
        currentScore = 0;
        _imgCentral.image = [UIImage imageNamed:@"tired-konata.jpeg"];
        [_imgCentral setContentMode:UIViewContentModeScaleAspectFill];
        [_imgCentral setClipsToBounds:YES];
        
    }
    else
    {
        _imgCentral.image = nil;
        _hiragana.text = currentHiragan.japan;
    }
    
   // float percent = (0.0 + currentScore) / (0.0 + [[[Computer sharedInstance] getSelectedsHiragana] count]) * 100;
   // NSLog(@"%f %d  %d", percent, currentScore, [[[Computer sharedInstance] getSelectedsHiragana] count]);
    _scoreLabel.text = [NSString stringWithFormat:@"%d / %d réussi ", currentScore, [[[Computer sharedInstance] getSelectedsHiragana] count]];
    
}

- (void) displayTrueResponse:(Hiragana *)hiragana
{
    [[self.view viewWithTag:100] setHidden:FALSE];
    [[self.view viewWithTag:200] setHidden:TRUE];
    
    _goodHiraganaPlain.text = hiragana.japan;
    _goodRomanjiPlain.text = hiragana.romanji;
}

- (void) displayFalseResponse:(Hiragana *)trueHiragana falseReponse:(Hiragana *)falseReponse
{
    [[self.view viewWithTag:100] setHidden:TRUE];
    [[self.view viewWithTag:200] setHidden:FALSE];
    
    _goodHiragana.text = trueHiragana.japan;
    _goodRomanji.text = trueHiragana.romanji;
    
    _falseHiragana.text = falseReponse.japan;
    _falseRomanji.text = falseReponse.romanji;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgCentral:nil];
    [self setHiragana:nil];
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
