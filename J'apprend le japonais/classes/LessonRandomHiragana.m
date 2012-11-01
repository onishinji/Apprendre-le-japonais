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
@synthesize msg = _msg;
@synthesize hiraganaView = _hiraganaView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        knows = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayNextHiragana];
    [_btnNext addTarget:self action:@selector(displayNextHiragana) forControlEvents:UIControlEventTouchUpInside];
}
     
-(void) displayNextHiragana
{
    int nb = [[[Computer sharedInstance] getSelectedsHiragana] count] - [knows count]-1;
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        _msg.text = [NSString stringWithFormat:@"Encore %i hiragana(s) à deviner", nb ];
    }
    Hiragana * hiragana = [[Computer sharedInstance] getRandomHiragana:knows];
    
    if(hiragana == nil)
    {
        knows = [[NSMutableArray alloc] init];
        _msg.text = @"Fini ! ";
        [_hiraganaView displayEmpty];
    }
    else
    {
        [knows addObject:hiragana.romanji];
        [_hiraganaView displayNewHiragana:hiragana];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
