//
//  RandomHiragana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "LessonControllerViewController.h"

@interface LessonContainerController : UIViewController <UIScrollViewDelegate>
{
}

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSMutableDictionary * parameters;
@property (strong, nonatomic) Lesson * lesson;

@property (strong, nonatomic) LessonControllerViewController * currentController;

@end
