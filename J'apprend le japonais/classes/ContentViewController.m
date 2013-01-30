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
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    fontSize = 14;
    
    _htmlView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _htmlView.delegate = self;
    _htmlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    
 //   [_htmlView setFontSize:fontSize];
    
    NSString* htmlString = _dataObject;
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"css" ofType:@"txt"];
    NSData* htmlData = [NSData dataWithContentsOfFile:filePath];
    NSString* htmlStringCss = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    
    htmlString = [htmlString stringByAppendingString:htmlStringCss];
    
    [_htmlView setBackgroundColor:[UIColor clearColor]];
    
    
    [_htmlView loadHTMLString:htmlString baseURL:nil];
    
    [self.view addSubview:_htmlView];

}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
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
    
    [self addPopupGesture];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@">>> %@", [[request URL] scheme]);
    
    NSURL *loadURL = [request URL];
    //change next line to whatever condition you need, e.g.
    //[[loadURL relativeString]  ....] contains a certain substring
    //or starts with certain letter or ...
    if([[loadURL scheme] isEqualToString: @"about"])
    {
        return TRUE;
    }
    
    if([[loadURL scheme] isEqualToString: @"http"])
    {
        [self.delegate openExternWebView:request.URL];
    }
    
    return FALSE;
}



- (void) addPopupGesture
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"jquery" ofType:@"txt"];
    NSData* htmlData = [NSData dataWithContentsOfFile:filePath];
    NSString* htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    
    [_htmlView stringByEvaluatingJavaScriptFromString:htmlString];
    
    
    filePath = [[NSBundle mainBundle] pathForResource:@"tooltip" ofType:@"txt"];
    htmlData = [NSData dataWithContentsOfFile:filePath];
    htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    [_htmlView stringByEvaluatingJavaScriptFromString:htmlString];
    
    
    filePath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"txt"];
    htmlData = [NSData dataWithContentsOfFile:filePath];
    htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    [_htmlView stringByEvaluatingJavaScriptFromString:htmlString];
    
    
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
