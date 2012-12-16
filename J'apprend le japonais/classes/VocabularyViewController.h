//
//  VocabularyViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 16/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonControllerViewController.h"
#import "VocabularyDetailViewController.h"

@interface VocabularyViewController : LessonControllerViewController
{
    NSMutableArray * results;
}

@property (nonatomic, strong) IBOutlet UITableView * tableView;

@end
