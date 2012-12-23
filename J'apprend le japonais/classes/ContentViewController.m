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
    _htmlView.backgroundColor = [UIColor whiteColor];
    _htmlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_htmlView setFontSize:fontSize];
    
    NSString* htmlString = _dataObject;
    
    _htmlView.alpha = 0;
    [_htmlView setBackgroundColor:[UIColor clearColor]];
    
    [_htmlView loadHtmlBody:htmlString competition:^(NSError *error) {
        if (!error) {
            [UIView animateWithDuration:0.2 animations:^{
                _htmlView.alpha = 1;
            }];
            
            
            for(int i=0; i < [self.nbUpDown intValue]; i++)
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
    
    NSLog(@"content sizeDown");
    [_htmlView stringByEvaluatingJavaScriptFromString:@"if (document.body.style.fontSize == ''){ document.body.style.fontSize = '1.0em'; }document.body.style.fontSize = parseFloat(document.body.style.fontSize) - 0.1 + ' em';"];
     
}

- (void) sizeUp
{
    
    NSLog(@"content sizeUp");
    [_htmlView stringByEvaluatingJavaScriptFromString:@"if (document.body.style.fontSize == ''){ document.body.style.fontSize = '1.0em'; }document.body.style.fontSize = parseFloat(document.body.style.fontSize) + 0.1 + ' em';"];
    
}

@end
