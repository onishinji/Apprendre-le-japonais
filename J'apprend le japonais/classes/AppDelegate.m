//
//  AppDelegate.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Computer.h"

@implementation AppDelegate

//Explicitly write Core Data accessors
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"model.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UINavigationController *rootViewController = (UINavigationController *)self.window.rootViewController;
    MainViewController * main = (MainViewController *)[[rootViewController viewControllers] objectAtIndex:0];
    main.managedObjectContext = context;
    
    [[Computer sharedInstance] setManagedObjectContext:context];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"firstLaunch",nil]];

    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [self initHiragana];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return YES;
}

- (void) initHiragana
{
   // [[Computer sharedInstance] createHiragana:<#(NSString *)#> japan:<#(NSString *)#> position:<#(int)#> col:<#(int)#> row:<#(int)#> section:<#(int)#>];
    
    [[Computer sharedInstance] createHiragana:@"a" japan:@"あ" position:1 col:1 row:1 section:1];
    [[Computer sharedInstance] createHiragana:@"i" japan:@"い" position:2 col:2 row:1 section:1];
    [[Computer sharedInstance] createHiragana:@"u" japan:@"う" position:3 col:3 row:1 section:1];
    [[Computer sharedInstance] createHiragana:@"e" japan:@"え" position:4 col:4 row:1 section:1];
    [[Computer sharedInstance] createHiragana:@"o" japan:@"お" position:5 col:5 row:1 section:1];
    
    [[Computer sharedInstance] createHiragana:@"ka" japan:@"か" position:6 col:1 row:2 section:1];
    [[Computer sharedInstance] createHiragana:@"ki" japan:@"き" position:7 col:2 row:2 section:1];
    [[Computer sharedInstance] createHiragana:@"ku" japan:@"く" position:8 col:3 row:2 section:1];
    [[Computer sharedInstance] createHiragana:@"ke" japan:@"け" position:9 col:4 row:2 section:1];
    [[Computer sharedInstance] createHiragana:@"ko" japan:@"こ" position:10 col:5 row:2 section:1];
    
    [[Computer sharedInstance] createHiragana:@"sa" japan:@"さ"  position:11 col:1 row:3 section:1];
    [[Computer sharedInstance] createHiragana:@"shi" japan:@"し" position:12 col:2 row:3 section:1];
    [[Computer sharedInstance] createHiragana:@"su" japan:@"す"  position:13 col:3 row:3 section:1];
    [[Computer sharedInstance] createHiragana:@"se" japan:@"せ"  position:14 col:4 row:3 section:1];
    [[Computer sharedInstance] createHiragana:@"so" japan:@"そ"  position:15 col:5 row:3 section:1];
    
    [[Computer sharedInstance] createHiragana:@"ta" japan:@"た" position:16  col:1  row:4 section:1];
    [[Computer sharedInstance] createHiragana:@"chi" japan:@"ち" position:17 col:2  row:4 section:1];
    [[Computer sharedInstance] createHiragana:@"tsu" japan:@"つ" position:18 col:3  row:4 section:1];
    [[Computer sharedInstance] createHiragana:@"te" japan:@"て" position:19  col:4  row:4 section:1];
    [[Computer sharedInstance] createHiragana:@"to" japan:@"と" position:20  col:5  row:4 section:1];
    
    [[Computer sharedInstance] createHiragana:@"na" japan:@"な" position:21 col:1  row:5 section:1];
    [[Computer sharedInstance] createHiragana:@"ni" japan:@"に" position:22 col:2  row:5 section:1];
    [[Computer sharedInstance] createHiragana:@"nu" japan:@"ぬ" position:23 col:3  row:5 section:1];
    [[Computer sharedInstance] createHiragana:@"ne" japan:@"ね" position:24 col:4  row:5 section:1];
    [[Computer sharedInstance] createHiragana:@"no" japan:@"の" position:25 col:5  row:5 section:1];
    
    [[Computer sharedInstance] createHiragana:@"ha" japan:@"は" position:26 col:1  row:6 section:1];
    [[Computer sharedInstance] createHiragana:@"hi" japan:@"ひ" position:27 col:2  row:6 section:1];
    [[Computer sharedInstance] createHiragana:@"fu" japan:@"ふ" position:28 col:3  row:6 section:1];
    [[Computer sharedInstance] createHiragana:@"he" japan:@"へ" position:29 col:4  row:6 section:1];
    [[Computer sharedInstance] createHiragana:@"ho" japan:@"ほ" position:30 col:5  row:6 section:1];
    
    [[Computer sharedInstance] createHiragana:@"ma" japan:@"ま" position:31 col:1  row:7 section:1];
    [[Computer sharedInstance] createHiragana:@"mi" japan:@"み" position:32 col:2  row:7 section:1];
    [[Computer sharedInstance] createHiragana:@"mu" japan:@"む" position:33 col:3  row:7 section:1];
    [[Computer sharedInstance] createHiragana:@"me" japan:@"め" position:34 col:4  row:7 section:1];
    [[Computer sharedInstance] createHiragana:@"mo" japan:@"も" position:35 col:5  row:7 section:1];
    
    [[Computer sharedInstance] createHiragana:@"ya" japan:@"や" position:36 col:1  row:8 section:1];
    [[Computer sharedInstance] createHiragana:@"yu" japan:@"ゆ" position:37 col:3  row:8 section:1];
    [[Computer sharedInstance] createHiragana:@"yo" japan:@"よ" position:38 col:5  row:8 section:1];
    
    [[Computer sharedInstance] createHiragana:@"ra" japan:@"ら" position:39 col:1  row:9 section:1];
    [[Computer sharedInstance] createHiragana:@"ri" japan:@"り" position:40 col:2  row:9 section:1];
    [[Computer sharedInstance] createHiragana:@"ru" japan:@"る" position:41 col:3  row:9 section:1];
    [[Computer sharedInstance] createHiragana:@"re" japan:@"れ" position:42 col:4  row:9 section:1];
    [[Computer sharedInstance] createHiragana:@"ro" japan:@"ろ" position:43 col:5  row:9 section:1];
    
    [[Computer sharedInstance] createHiragana:@"wa" japan:@"わ" position:44 col:1  row:10 section:1];
    [[Computer sharedInstance] createHiragana:@"wo" japan:@"を" position:45 col:5  row:10 section:1];
    
    [[Computer sharedInstance] createHiragana:@"n" japan:@"ん" position:46 col:5  row:11 section:1];

    [[Computer sharedInstance] flush];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
