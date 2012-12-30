//
//  VocabularyViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 16/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseController.h"
#import "VocabularyDetailViewController.h"
#import "UITableView+NXEmptyView.h"

@interface VocabularyViewController : ExerciseController
{
    NSMutableArray * results;
    NSString * idSpreadsheet;
    NSData *dataTmp;
}

@property (nonatomic, strong) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSURL * url; 
@property (nonatomic, strong) NSString * mode;

- (id)kownUrl:(NSString *)url;

@end
