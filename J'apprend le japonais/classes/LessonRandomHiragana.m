//
//  LessonRandomHiragana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonRandomHiragana.h"
#import "Computer.h"

@interface LessonRandomHiragana ()

- (void) displayNextHiragana;

@end

@implementation LessonRandomHiragana

@synthesize btnNext = _btnNext;
@synthesize btnPrev = _btnPrev;
@synthesize msg = _msg;
@synthesize hiraganaView = _hiraganaView;

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
        
        [self.pocketsphinxController startListeningWithLanguageModelAtPath:lmPath dictionaryAtPath:dicPath languageModelIsJSGF:NO];
        
        [self.openEarsEventsObserver setDelegate:self];
    }
    return self;
}


- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    
    if([hypothesis isEqualToString:@"PREVIOUS"])
    {
        [self displayPrevHiragana];
    }
    
    if([hypothesis isEqualToString:@"NEXT"])
    {
        [self displayNextHiragana];
    }
    
    if([hypothesis isEqualToString:@"SWITCH"])
    {
        [_hiraganaView switchToggleFace];
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
    [self displayNextHiragana];
    
    [_btnNext addTarget:self action:@selector(displayNextHiragana) forControlEvents:UIControlEventTouchUpInside];
    [_btnPrev addTarget:self action:@selector(displayPrevHiragana) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) displayNextHiragana
{

    currentPos++;
    
    int nbHiraganaLesson = [[[Computer sharedInstance] getSelectedsHiragana] count];
    
    
    Hiragana * hiragana = nil;
    if(currentPos < [knows count])
    {
        hiragana = [knows objectAtIndex:currentPos];
    }
    else
    {
        hiragana = [[Computer sharedInstance] getRandomHiragana:knowsRomanji];
    
        if(hiragana != nil)
        {
            currentPos = [knows count];
            [knowsRomanji addObject:hiragana.romanji];
            [knows addObject:hiragana];
            
        }
    }
    
    int nb = [[[Computer sharedInstance] getSelectedsHiragana] count] - currentPos - 1;
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        _msg.text = [NSString stringWithFormat:@"Encore %i hiragana(s) à deviner", nb ];
    }
    
    if(currentPos >= nbHiraganaLesson)
    {
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        
        _msg.text = @"Fini ! ";
        [_hiraganaView displayEmpty];
        currentPos = 0;
    }
    else
    {
     //   [self.fliteController say:@"I am a fucking program who work great" withVoice:self.slt];
        [_hiraganaView displayNewHiragana:hiragana];
    }

}

- (void) displayPrevHiragana
{
    if(currentPos > 0)
    {
        currentPos--;
        currentPos--;
        [self displayNextHiragana];
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
