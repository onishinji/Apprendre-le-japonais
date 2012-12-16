//
//  LessonRandomHiragana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonRandomKana.h"
#import "Computer.h"

@interface LessonRandomKana ()

- (void) displayNext;

@end

@implementation LessonRandomKana

@synthesize btnNext = _btnNext;
@synthesize btnPrev = _btnPrev;
@synthesize msg = _msg;
@synthesize kanaFlipView = _kanaFlipView;

@synthesize fliteController;
@synthesize slt;
@synthesize pocketsphinxController;
@synthesize openEarsEventsObserver;

- (FliteController *)fliteController {
	if (fliteController == nil) {
		fliteController = [[FliteController alloc] init];
	}
	return fliteController;
}

- (Slt *)slt {
	if (slt == nil) {
		slt = [[Slt alloc] init];
	}
	return slt;
}

- (PocketsphinxController *)pocketsphinxController {
	if (pocketsphinxController == nil) {
		pocketsphinxController = [[PocketsphinxController alloc] init];
	}
	return pocketsphinxController;
}

- (OpenEarsEventsObserver *)openEarsEventsObserver {
	if (openEarsEventsObserver == nil) {
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
	}
	return openEarsEventsObserver;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        currentPos = 0;
        
        lmGenerator = [[LanguageModelGenerator alloc] init];
        
        NSArray *words = [NSArray arrayWithObjects:@"NEXT", @"PREVIOUS", @"SWITCH", @"FLIP", @"TOGGLE", nil];
        NSString *name = @"NameIWantForMyLanguageModelFiles";
        NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name];
        
        
        NSDictionary *languageGeneratorResults = nil;
        
        NSString *lmPath = nil;
        NSString *dicPath = nil;
        
        if([err code] == noErr) {
            
            languageGeneratorResults = [err userInfo];
            
            lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
            dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
            
        } else {
            NSLog(@"Error: %@",[err localizedDescription]);
        }
        
        // Decomment to reactive voice support
      //  [self.pocketsphinxController startListeningWithLanguageModelAtPath:lmPath dictionaryAtPath:dicPath languageModelIsJSGF:NO];
        
        [self.openEarsEventsObserver setDelegate:self];
    }
    return self;
}


- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    
    if([hypothesis isEqualToString:@"PREVIOUS"])
    {
        [self displayPrevious];
    }
    
    if([hypothesis isEqualToString:@"NEXT"])
    {
        [self displayNext];
    }
    
    if([hypothesis isEqualToString:@"SWITCH"])
    {
        [_kanaFlipView switchToggleFace];
    }
    
	NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
}

- (void) pocketsphinxDidStartCalibration {
	NSLog(@"Pocketsphinx calibration has started.");
}

- (void) pocketsphinxDidCompleteCalibration {
	NSLog(@"Pocketsphinx calibration is complete.");
}

- (void) pocketsphinxDidStartListening {
	NSLog(@"Pocketsphinx is now listening.");
}

- (void) pocketsphinxDidDetectSpeech {
	NSLog(@"Pocketsphinx has detected speech.");
}

- (void) pocketsphinxDidDetectFinishedSpeech {
	NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
}

- (void) pocketsphinxDidStopListening {
	NSLog(@"Pocketsphinx has stopped listening.");
}

- (void) pocketsphinxDidSuspendRecognition {
	NSLog(@"Pocketsphinx has suspended recognition.");
}

- (void) pocketsphinxDidResumeRecognition {
	NSLog(@"Pocketsphinx has resumed recognition.");
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
	NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFail { // This can let you know that something went wrong with the recognition loop startup. Turn on OPENEARSLOGGING to learn why.
	NSLog(@"Setting up the continuous recognition loop has failed for some reason, please turn on OpenEarsLogging to learn more.");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.kanaFlipView setMode:[[self params] objectForKey:@"mode"]];
    
    [self displayNext];
    
    [_btnNext addTarget:self action:@selector(displayNext) forControlEvents:UIControlEventTouchUpInside];
    [_btnPrev addTarget:self action:@selector(displayPrevious) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    // @todo switch type
    int nb = [[[Computer sharedInstance] getSelectedsHiragana] count] - currentPos - 1;
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        // @todo switch type
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
        [_kanaFlipView displayNext:kana];
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


- (void)openHelp:(UIBarButtonItem *)bar
{
    helpVC = [[HelpViewController alloc] initWithNibName:@"helpRandom" bundle:nil];
    
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBtnPrev:nil];
    [super viewDidUnload];
}
@end
