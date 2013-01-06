//
//  ContentViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 22/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "ContentViewController.h"
#import "CMHTMLView.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

@synthesize nbUpDown = _nbUpDown;
@synthesize htmlView = _htmlView;

- (void)viewDidLoad {
    [super viewDidLoad];
    fontSize = 14;
    
    _htmlView = [[CMHTMLView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _htmlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_htmlView setFontSize:fontSize];
    
    NSString* htmlString = _dataObject;
    
    [_htmlView setBackgroundColor:[UIColor clearColor]];
    
    [_htmlView loadHtmlBody:htmlString competition:^(NSError *error) {
        if (!error) {
            
            // restore size
            for(int i=0; i < fabs([self.nbUpDown intValue]); i++)
            {
                if([self.nbUpDown intValue] > 0)
                {
                    [self sizeUp];
                }
                else
                {
                    [self sizeDown];
                }
            }
        }
    }];
    
    [self.view addSubview:_htmlView];

}

- (void) sizeDown
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"contentLessonAdapterDown" ofType:@"txt"];
    NSData* htmlData = [NSData dataWithContentsOfFile:filePath];
    NSString* htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];

    [_htmlView stringByEvaluatingJavaScriptFromString:htmlString];
     
}

- (void) sizeUp
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"contentLessonAdapterUp" ofType:@"txt"];
    NSData* htmlData = [NSData dataWithContentsOfFile:filePath];
    NSString* htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    
    [_htmlView stringByEvaluatingJavaScriptFromString:htmlString];
    
}

@end
