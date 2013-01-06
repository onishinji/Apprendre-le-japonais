//
//  LessonQCMHiraganaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 05/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "KanaQCMController.h"
#import "Computer.h"
#import "UIColor+RGB.h"

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
    [self displaySentenceOK:NSLocalizedString(@"QCM.Neko.wait", "Neko sensei attend ta réponse")];
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
            
            if(![btn.titleLabel.text isEqualToString:@"N/A"])
            {
                
                if(
                   ([self isForRomanjiToJapan] && [btn.titleLabel.text isEqualToString:currentKana.displayRomanji]) ||
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
                            NSLog(@"isForRomanjiToJapan %@", self.currentMode);
                            [self displayFalseResponse:currentKana falseReponse:[[Computer sharedInstance] getKatakanaWithRomanji:btn.titleLabel.text]];
                        }
                        else
                        {
                            NSLog(@"!isForRomanjiToJapan %@", self.currentMode);
                            [self displayFalseResponse:currentKana falseReponse:[[Computer sharedInstance] getKatakanaWithJapan:btn.titleLabel.text]];
                        }
                    }
                    currentKana.scoring = [NSNumber numberWithInt:[currentKana.scoring intValue] - 1];
                }
                [[Computer sharedInstance] flush];
            }

        }
    }
}

-(void) displayNext
{
    int nbSeleted = 0;
    
    if([self isForHiragana])
    {
        nbSeleted =  [[[Computer sharedInstance] getSelectedsHiragana] count];
    }
    else
    {
        nbSeleted =  [[[Computer sharedInstance] getSelectedsKatakana] count];
    }
    
    
    if(nbSeleted <= 5)
    {
        _msg.hidden = TRUE;
        _scoreLabel.hidden = TRUE;
        [self.kanaView displayEmpty];
        [self displaySentenceKO:@""];
        
        [self desactiveButtons];
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"QCM.Error.Title", @"Oups") message:NSLocalizedString(@"QCM.Error.NoEnoughKana", @"Il n'y a pas assez de kana à apprendre !") delegate:self cancelButtonTitle:@"Fermer" otherButtonTitles:nil, nil] show];
    }
    else
    {
        
        hasWrongAnswer = FALSE;
        
        [_hiraganaFlipView.lblHiragana setTextColor:defaultLblColor];
        
        [_hiraganaFlipView removeGestureRecognizer:tapToNext];
        
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
            [goodButton setTitle:currentKana.displayRomanji forState:UIControlStateNormal];
        }
        else
        {
            [goodButton setTitle:currentKana.japan forState:UIControlStateNormal];
        }
        
        // switch type
        NSMutableArray * othersKanaChoice;
        if([self isForHiragana])
        {
            othersKanaChoice = [[Computer sharedInstance] getRandomHiraganaExcept:currentKana limit:5];
        }
        else
        {
            othersKanaChoice = [[Computer sharedInstance] getRandomKatakanaExcept:currentKana limit:5];
        }
        
        int currentBadPosition = 0;
        
        int i=0;
        for(UIButton * btn in btnArray)
        {
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            if(i != goodIndex)
            {
                Kana * hir = [othersKanaChoice objectAtIndex:currentBadPosition];
                
                if([self isForRomanjiToJapan])
                {
                    [btn setTitle:hir.displayRomanji forState:UIControlStateNormal];
                }
                else
                {
                    [btn setTitle:hir.japan forState:UIControlStateNormal];
                }
                
                currentBadPosition++;
                
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
        
        nb = nbSeleted - [knows count];
        
        if(nb == 0)
        {
            _msg.text = NSLocalizedString(@"QCM.Neko.lastKana", @"Encore un dernier effort et c'est fini !");
        }
        else
        {
            _msg.text = [NSString stringWithFormat:NSLocalizedString(@"QCM.Neko.nbKanaPending", @"Encore %i kana à deviner"), nb ];
        }
        
        if(currentKana == nil)
        {
            knows = [[NSMutableArray alloc] init];
            knowsRomanji = [[NSMutableArray alloc] init];
            
            
            float percent = (0.0 + currentScore) / (0.0 + nbSeleted) * 100;
            [_hiraganaFlipView displayEmpty];
            
            if(isnan(percent)) percent = 100;
            
            _msg.text = [NSString stringWithFormat:NSLocalizedString(@"QCM.Neko.Finish", @"Fini ! ton scocre est de %2.f %% de réussite !)"), percent];
            _scoreLabel.hidden = TRUE;
            
            [self desactiveButtons];
            
            if(percent == 100.0)
            {
                [self displaySentenceOK:NSLocalizedString(@"QCM.Neko.score100",@"Neko Sensei t'offre un poisson !")];
            }
            else if(percent >= 90.0)
            {
                [self displaySentenceOK:NSLocalizedString(@"QCM.Neko.score90", @"Neko Sensei te félicite !")];
            }
            else if(percent >= 70.0)
            {
                [self displaySentenceOK:NSLocalizedString(@"QCM.Neko.score70",@"Neko Sensei se dit que tu es sur la bonne voie !")];
            }
            else if(percent >= 50.0)
            {
                [self displaySentenceOK:NSLocalizedString(@"QCM.Neko.score50", @"Neko Sensei t'encourage à continuer tes efforts !")];
            }
            else if(percent >= 25.0)
            {
                [self displaySentenceKO:NSLocalizedString(@"QCM.Neko.score25", @"Neko Sensei pense que tu ne dois pas te décourager.")];
            }
            else if(percent >= 0.0)
            {
                [self displaySentenceKO:NSLocalizedString(@"QCM.Neko.score0", @"Neko Sensei pense que tu as beaucoup à apprendre.")];
            }
            
            currentScore = 0;
            
        }
        else
        {
            [_hiraganaFlipView displayJapan];
        }
        
        float percent = (float)( ((float)nbSeleted - ((float)([knows count] -1) - (float)currentScore)) / (float)nbSeleted) * 100;
        _scoreLabel.text = [NSString stringWithFormat:NSLocalizedString(@"QCM.score",@"%2.f %% de réussite"), percent];
    }
}

-(void)desactiveButtons
{
    for(UIButton * btn in btnArray)
    {
        btn.enabled = FALSE;
        [btn setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) displayTrueResponse:(Kana *)kana
{
    if(!hasWrongAnswer)
    {
        NSArray * sentences = [NSArray arrayWithObjects:
                               NSLocalizedString(@"QCM.Neko.TrueResponse1", @"Sugoi !"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse2",@"Bravo !"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse3",@"C'est bien, continue !"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse4",@"C'est exact."),
                               NSLocalizedString(@"QCM.Neko.TrueResponse5",@"Tout à fait !"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse6",@"Neko sensei est fier de toi !"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse7",@"Tu as raison."),
                               NSLocalizedString(@"QCM.Neko.TrueResponse8",@"Continue, tu es sur la bonne voie."),
                               NSLocalizedString(@"QCM.Neko.TrueResponse9",@"Tu m'impressiones"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse10",@"Fortiche !"),
                               NSLocalizedString(@"QCM.Neko.TrueResponse11",@"Subarashii !")
                               , nil];
        
        int randomIndex = arc4random() % [sentences count];
        [self displaySentenceOK:[sentences objectAtIndex:randomIndex]];
         
    }
    
    [self displayNext];
        
}

- (void) displayFalseResponse:(Kana *)trueResponse falseReponse:(Kana *)falseResponse
{
    NSArray * sentences = [NSArray arrayWithObjects:
                           NSLocalizedString(@"QCM.Neko.FalseResponse1",@"Non !"),
                           NSLocalizedString(@"QCM.Neko.FalseResponse2",@"Oups ?"),
                           NSLocalizedString(@"QCM.Neko.FalseResponse3",@"Tu devrais le savoir !"),
                           NSLocalizedString(@"QCM.Neko.FalseResponse4",@"Qui veut aller loin ménage sa monture ..."),
                           NSLocalizedString(@"QCM.Neko.FalseResponse5",@"Concentre toi un peu .."),
                           NSLocalizedString(@"QCM.Neko.FalseResponse6",@"Neko sensei n'est pas content de toi"),
                           NSLocalizedString(@"QCM.Neko.FalseResponse7",@"As tu appris ?"),
                           NSLocalizedString(@"QCM.Neko.FalseResponse8",@"Gomen, c'est pas ça .."),
                           NSLocalizedString(@"QCM.Neko.FalseResponse9",@"Un petit effort"),
                           NSLocalizedString(@"QCM.Neko.FalseResponse10",@"Presque ...")
                           , nil];
    
    int randomIndex = arc4random() % [sentences count]; 
    [self displaySentenceKO:[sentences objectAtIndex:randomIndex]];
    
    hasWrongAnswer = TRUE;
    
    for(UIButton * btn in btnArray)
    {
        if(([self isForRomanjiToJapan] && [btn.titleLabel.text isEqualToString:trueResponse.displayRomanji]) ||
           ([self isForJapanToRomanji] && [btn.titleLabel.text isEqualToString:trueResponse.japan]))
        {
            [btn setTitleColor:[UIColor colorWithR:35 G:200 B:0 A:1] forState:UIControlStateNormal];
        }
        
        if(([self isForRomanjiToJapan] && [btn.titleLabel.text isEqualToString:falseResponse.displayRomanji]) ||
           ([self isForJapanToRomanji] && [btn.titleLabel.text isEqualToString:falseResponse.japan]))
        {
            [btn setTitleColor:[UIColor colorWithR:255 G:0 B:0 A:1] forState:UIControlStateNormal];
        }
    }
    
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
    helpVC = [storyboard instantiateViewControllerWithIdentifier:@"helpQCM"];
    
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
