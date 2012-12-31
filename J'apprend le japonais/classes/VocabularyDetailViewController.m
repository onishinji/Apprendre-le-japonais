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
    
    nbSizeUpDown = 0;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
    
    dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
    
    NSLog(@"%@", self.currentItem.sampleUsageTraduction);
    
    NSDictionary * substitutions = [NSDictionary
                                    dictionaryWithObjects:[NSArray arrayWithObjects:
                                                           self.currentItem.romanji ? self.currentItem.romanji : @"-",
                                                           self.currentItem.traduction ? self.currentItem.traduction : @"-",
                                                           self.currentItem.kana ? self.currentItem.kana : @"-",
                                                           self.currentItem.kanji ? self.currentItem.kanji : @"-",
                                                           self.currentItem.sampleUsageTraduction ? self.currentItem.sampleUsageTraduction : @"-",
                                                           self.currentItem.sampleUsageJapan ? self.currentItem.sampleUsageJapan : @"-",
                                                           self.currentItem.sampleUsageRomanji ? self.currentItem.sampleUsageRomanji : @"-",
                                            nil]
                                    forKeys:[NSArray arrayWithObjects:
                                             @"romanji",
                                             @"traduction",
                                             @"kana",
                                             @"kanji",
                                             @"sampleUsageTraduction",
                                             @"sampleUsageKana",
                                             @"sampleUsage",
                                             nil]
                                    ];
    
    NSMutableString *html = [NSMutableString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"vocabulary" ofType:@"html"]
                                                             encoding:NSUTF8StringEncoding
                                                                error:nil];
   
    for(NSString *substitutionKey in substitutions)
    {
        NSString *substitution = [[substitutions objectForKey:substitutionKey] description];
        NSString *searchTerm = [NSString stringWithFormat:@"<!--%@-->", substitutionKey];
        
        NSLog(@"%@, je cherche %@ et je remplace par %@",substitutionKey, searchTerm, substitution);
        
        [html replaceOccurrencesOfString:searchTerm withString:substitution options:0 range:NSMakeRange(0, [html length])];
    }
    
    dataViewController.dataObject = html;
    dataViewController.nbUpDown = [NSNumber numberWithInt:nbSizeUpDown];

    
    [self.view addSubview:dataViewController.view];
    
    
    UIBarButtonItem *Button1 = [[UIBarButtonItem alloc]initWithTitle:@"aA" style:UIBarButtonItemStylePlain
                                                              target:self action:@selector(sizeUp:)] ;
    
    UIBarButtonItem *Button2 = [[UIBarButtonItem alloc] initWithTitle:@"Aa" style:UIBarButtonItemStylePlain
                                                               target:self action:@selector(sizeDown:)] ;
     
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: Button1,Button2, nil];
    
    
   /* self.romanji.text = self.currentItem.romanji;
    self.kana.text = self.currentItem.kana;
    self.sampleUsageJapan.text = self.currentItem.sampleUsageJapan;
    self.sampleUsageRomanji.text = self.currentItem.sampleUsageRomanji;
    self.sampleUsageTraduction.text = self.currentItem.sampleUsageTraduction;
    self.kanji.text = self.currentItem.kanji;
    self.traduction.text = self.currentItem.traduction;
	// Do any additional setup after loading the view.
    */
    
    self.title = @"Détails";
}
#pragma mark - IBAction

- (IBAction)sizeUp:(id)sender
{
    if(nbSizeUpDown < 12)
    {
        nbSizeUpDown++;
        [dataViewController sizeUp];
    }
}

- (IBAction)sizeDown:(id)sender
{
    if(nbSizeUpDown > -8)
    {
        nbSizeUpDown--;
        [dataViewController sizeDown];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
