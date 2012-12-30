//
//  LessonQCMHiraganaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 05/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "KanaQCMController.h"
#import "Computer.h"

@interface KanaQCMController ()

@end


@implementation KanaQCMController

@synthesize leftBottomButton = _leftBottomButton;
@synthesize leftMiddleButton = _leftMiddleButton;
@synthesize leftTopButton = _leftTopButton;

@synthesize rightBottomButton = _rightBottomButton;
@synthesize rightMiddleButton = _rightMiddleButton;
@synthesize rightTopButton = _rightTopButton;

@synthesize kanaView = _hiraganaFlipView;

@synthesize scoreLabel = _scoreLabel;

@synthesize lblResponse = _lblResponse;

@synthesize msg = _msg;
 

- (void)toTapNext:(UIGestureRecognizer *)gestureRecognizer
{
    [self displayWaitingMessage];
    [self displayNext];
}

- (void) displayWaitingMessage
{
    [self displaySentenceOK:@"Neko sensei attend ta réponse"];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.kanaView setMode:self.currentMode];
    
    defaultLblColor = self.kanaView.lblHiragana.textColor;
    
    [self displayWaitingMessage];
    
    //
    [self configureButton:_leftTopButton];
    [self configureButton:_leftMiddleButton];
    [self configureButton:_leftBottomButton];
    [self configureButton:_rightTopButton];
    [self configureButton:_rightMiddleButton];
    [self configureButton:_rightBottomButton];
    
    // add buttons
    [btnArray addObject:_leftTopButton];
    [btnArray addObject:_leftMiddleButton];
    [btnArray addObject:_leftBottomButton];
    
    [btnArray addObject:_rightTopButton];
    [btnArray addObject:_rightMiddleButton];
    [btnArray addObject:_rightBottomButton];
    
    // Configure buttons
    [_leftTopButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBottomButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_leftMiddleButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightTopButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBottomButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
    [_rightMiddleButton addTarget:self action:@selector(checkResponse:) forControlEvents:UIControlEventTouchUpInside];
     
    
    [self displayNext];
}

- (void) activeController
{
    
    knows = [[NSMutableArray alloc] init];
    knowsRomanji = [[NSMutableArray alloc] init];
    currentScore = 0;
    btnArray = [[NSMutableArray alloc] init];
    
    tapToNext = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTapNext:)];
    tapToNext.numberOfTapsRequired = 1;
    
    hasWrongAnswer = FALSE;
    
}

- (void) configureButton:(UIButton *)btn
{
    CGFloat size = 0;
    size = btn.titleLabel.font.pointSize;
    [btn.titleLabel setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:size]];
}

- (void) checkResponse:(id)sender
{
    // don't check response if wrong is display
    if(hasWrongAnswer == TRUE)
    {
        [self displayWaitingMessage];
        [self displayNext];
    }
    else
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
    }
}

-(void) displayNext
{
    hasWrongAnswer = FALSE;
    
    [_hiraganaFlipView.lblHiragana setTextColor:defaultLblColor];
    
    [_hiraganaFlipView removeGestureRecognizer:tapToNext];
    
    NSLog(@"displayNext %@, %@", self.currentKanaType, self.currentMode);
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
    
    int nb = 0;
    int nbSeleted = 0;
    
    if([self isForHiragana])
    {
        nbSeleted =  [[[Computer sharedInstance] getSelectedsHiragana] count];
    }
    else
    {
        nbSeleted =  [[[Computer sharedInstance] getSelectedsKatakana] count];
    }
    
    nb = nbSeleted - [knows count];
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        _msg.text = [NSString stringWithFormat:@"Encore %i kana à deviner", nb ];
    }
    
    if(currentKana == nil)
    {
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        
        
        float percent = (0.0 + currentScore) / (0.0 + nbSeleted) * 100; 
        [_hiraganaFlipView displayEmpty];
        
        if(isnan(percent)) percent = 100;
        
        _msg.text = [NSString stringWithFormat:@"Fini ! ton scocre est de %2.f %% de réussite !", percent];
        _scoreLabel.hidden = TRUE;
        for(UIButton * btn in btnArray)
        {
            btn.enabled = FALSE;
            btn.titleLabel.text = @"";
        }
         
        if(percent == 100.0)
        {
            [self displaySentenceOK:@"Neko Sensei t'offre un poisson !"];
        }
        else if(percent >= 90.0)
        {
            [self displaySentenceOK:@"Neko Sensei te félicite !"];
        }
        else if(percent >= 70.0)
        {
            [self displaySentenceOK:@"Neko Sensei se dit que tu es sur la bonne voie !"];
        }
        else if(percent >= 50.0)
        {
            [self displaySentenceOK:@"Neko Sensei t'encourage à continuer tes efforts !"];
        }
        else if(percent >= 25.0)
        {
            [self displaySentenceKO:@"Neko Sensei pense que tu ne dois pas te décourager."];
        }
        else if(percent >= 0.0)
        {
            [self displaySentenceKO:@"Neko Sensei pense que tu as beaucoup à apprendre."];
        }
        
        currentScore = 0;
        
    }
    else
    {
        [_hiraganaFlipView displayJapan];
    }
    
    float percent = (float)( ((float)nbSeleted - ((float)([knows count] -1) - (float)currentScore)) / (float)nbSeleted) * 100;
    _scoreLabel.text = [NSString stringWithFormat:@"%2.f %% de réussite", percent];
    
}

- (void) displayTrueResponse:(Kana *)kana
{
    if(!hasWrongAnswer)
    {
        NSArray * sentences = [NSArray arrayWithObjects:
                               @"Sugoi !",
                               @"Bravo !",
                               @"C'est bien, continue !",
                               @"C'est exact.",
                               @"Tout à fait !",
                               @"Neko sensei est fier de toi !",
                               @"Tu as raison.",
                               @"Continue, tu es sur la bonne voie.",
                               @"Tu m'impressiones",
                               @"Fortiche !",
                               @"Subarashii !"
                               , nil];
        
        int randomIndex = arc4random() % [sentences count];
        [self displaySentenceOK:[sentences objectAtIndex:randomIndex]];
         
    }
    
    [self displayNext];
        
}

- (void) displayFalseResponse:(Kana *)trueResponse falseReponse:(Kana *)falseResponse
{
    NSArray * sentences = [NSArray arrayWithObjects:
                           @"Non !",
                           @"Oups ?",
                           @"Tu devrais le savoir !",
                           @"Qui veut aller loin ménage sa monture ...",
                           @"Concentre toi un peu ..",
                           @"Neko sensei n'est pas content de toi",
                           @"As tu appris ?",
                           @"Gomen, c'est pas ça ..",
                           @"Un petit effort",
                           @"Presque ..."
                           , nil];
    
    int randomIndex = arc4random() % [sentences count]; 
    [self displaySentenceKO:[sentences objectAtIndex:randomIndex]];
    
    hasWrongAnswer = TRUE;
    [_hiraganaFlipView displayRomanji];
    
    
    [_hiraganaFlipView.lblHiragana setTextColor:[UIColor redColor]];
    
    [_hiraganaFlipView addGestureRecognizer:tapToNext];
}

- (void) displaySentenceOK:(NSString *) msg
{
    _lblResponse.textColor = [UIColor blackColor];
    _lblResponse.text = msg;
}

- (void) displaySentenceKO:(NSString *) msg
{
    _lblResponse.textColor = [UIColor redColor];
    _lblResponse.text = msg;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openHelp:(UIBarButtonItem *)bar
{
    helpVC = [[HelpViewController alloc] initWithNibName:@"helpQCM" bundle:nil];
    
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

- (void)viewDidUnload {
    [self setKanaView:nil];
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