//
//  ContentViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 22/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMHTMLView.h"
#import "SVModalWebViewController.h"

@protocol ContentViewControllerDelegate <NSObject>

@optional
- (void) openExternWebView:(NSURL *)url;

@end

@interface ContentViewController : UIViewController <UIWebViewDelegate>
{
    CGFloat fontSize;
}

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) UIWebView * htmlView;
@property (strong, nonatomic) NSNumber * nbUpDown;

@property (weak) <ContentViewControllerDelegate> delegate;

-(void)sizeUp;
-(void)sizeDown;

@end
