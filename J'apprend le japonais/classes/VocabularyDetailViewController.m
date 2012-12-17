//
//  VocabularyDetailViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 16/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "VocabularyDetailViewController.h"

@interface VocabularyDetailViewController ()

@end

@implementation VocabularyDetailViewController

@synthesize currentItem = _currentItem;
@synthesize romanji = _romanji;

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
    
    self.romanji.text = self.currentItem.romanji;
    self.kana.text = self.currentItem.kana;
    self.sampleUsageJapan.text = self.currentItem.sampleUsageJapan;
    self.sampleUsageRomanji.text = self.currentItem.sampleUsageRomanji;
    self.sampleUsageTraduction.text = self.currentItem.sampleUsageTraduction;
    self.kanji.text = self.currentItem.kanji;
    self.traduction.text = self.currentItem.traduction;
	// Do any additional setup after loading the view.
    
    self.title = @"Détails";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRomanji:nil];
    [self setKana:nil];
    [self setTraduction:nil];
    [self setSampleUsageRomanji:nil];
    [self setSampleUsageJapan:nil];
    [self setSampleUsageTraduction:nil];
    [self setKanji:nil];
    [super viewDidUnload];
}
@end
