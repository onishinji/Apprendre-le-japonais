//
//  KanaStatsController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 13/01/13.
//  Copyright (c) 2013 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseController.h"

@interface KanaStatsController : ExerciseController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableDictionary * allResult;
    NSMutableArray * allKanas;
    
    UIImage * smileyImgYes;
    UIImage * smileyImgNo;
    UIImage * smileyImgMedium;
    
    UIImage * smileyImgYesHeader;
    UIImage * smileyImgNoHeader;
    UIImage * smileyImgMediumHeader;
    
    
}

@property (nonatomic, weak) IBOutlet UILabel * msg;
@property (nonatomic, weak) IBOutlet UILabel * nekoMsg;
@property (nonatomic, weak) IBOutlet UIImageView * globalScoreImg;


@end
