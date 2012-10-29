//
//  RandomHiragana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson.h"

@interface LessonController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) Lesson * lesson;

@property (strong, nonatomic) UIViewController * currentController;

@end
