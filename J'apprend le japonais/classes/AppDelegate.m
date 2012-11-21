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
    
    /*
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

    */
    
    
    
    //=======================
    
    //  HIRAGANA
    
    //=======================
    
    
    
    // gojûon
    
    [[Computer sharedInstance] createHiragana:@"a" japan:@"あ" position:1 col:1 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"i" japan:@"い" position:2 col:2 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"u" japan:@"う" position:3 col:3 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"e" japan:@"え" position:4 col:4 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"o" japan:@"お" position:5 col:5 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ka" japan:@"か" position:6 col:1 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ki" japan:@"き" position:7 col:2 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ku" japan:@"く" position:8 col:3 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ke" japan:@"け" position:9 col:4 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ko" japan:@"こ" position:10 col:5 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"sa" japan:@"さ" position:11 col:1 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"shi" japan:@"し" position:12 col:2 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"su" japan:@"す" position:13 col:3 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"se" japan:@"せ" position:14 col:4 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"so" japan:@"そ" position:15 col:5 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ta" japan:@"た" position:16 col:1 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"chi" japan:@"ち" position:17 col:2 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"tsu" japan:@"つ" position:18 col:3 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"te" japan:@"て" position:19 col:4 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"to" japan:@"と" position:20 col:5 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"na" japan:@"な" position:21 col:1 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ni" japan:@"に" position:22 col:2 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"nu" japan:@"ぬ" position:23 col:3 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ne" japan:@"ね" position:24 col:4 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"no" japan:@"の" position:25 col:5 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ha" japan:@"は" position:26 col:1 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"hi" japan:@"ひ" position:27 col:2 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"fu" japan:@"ふ" position:28 col:3 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"he" japan:@"へ" position:29 col:4 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ho" japan:@"ほ" position:30 col:5 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ma" japan:@"ま" position:31 col:1 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"mi" japan:@"み" position:32 col:2 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"mu" japan:@"む" position:33 col:3 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"me" japan:@"め" position:34 col:4 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"mo" japan:@"も" position:35 col:5 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ya" japan:@"や" position:36 col:1 row:8 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"yu" japan:@"ゆ" position:37 col:3 row:8 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"yo" japan:@"よ" position:38 col:5 row:8 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ra" japan:@"ら" position:39 col:1 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ri" japan:@"り" position:40 col:2 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ru" japan:@"る" position:41 col:3 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"re" japan:@"れ" position:42 col:4 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ro" japan:@"ろ" position:43 col:5 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"wa" japan:@"わ" position:44 col:1 row:10 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"(w)o" japan:@"を" position:45 col:5 row:10 section:1 type:0 ];
    [[Computer sharedInstance] createHiragana:@"n" japan:@"ん" position:46 col:5 row:11 section:1 type:0 ];
    
    // gojûon avec (han)dakuten
    
    [[Computer sharedInstance] createHiragana:@"ga" japan:@"が" position:47 col:1 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"gi" japan:@"ぎ" position:48 col:2 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"gu" japan:@"ぐ" position:49 col:3 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ge" japan:@"げ" position:50 col:4 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"go" japan:@"ご" position:51 col:5 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"za" japan:@"ざ" position:52 col:1 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ji" japan:@"じ" position:53 col:2 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"zu" japan:@"ず" position:54 col:3 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ze" japan:@"ぜ" position:55 col:4 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"zo" japan:@"ぞ" position:56 col:5 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"da" japan:@"だ" position:57 col:1 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ji" japan:@"ぢ" position:58 col:2 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"zu" japan:@"づ" position:59 col:3 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"de" japan:@"で" position:60 col:4 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"do" japan:@"ど" position:61 col:5 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ba" japan:@"ば" position:62 col:1 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"bi" japan:@"び" position:63 col:2 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"bu" japan:@"ぶ" position:64 col:3 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"be" japan:@"べ" position:65 col:4 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"bo" japan:@"ぼ" position:66 col:5 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pa" japan:@"ぱ" position:67 col:1 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pi" japan:@"ぴ" position:68 col:2 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pu" japan:@"ぷ" position:69 col:3 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pe" japan:@"ぺ" position:70 col:4 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createHiragana:@"po" japan:@"ぽ" position:71 col:5 row:5 section:2 type:0 ];
    
    // yôon
    
    [[Computer sharedInstance] createHiragana:@"kya" japan:@"きゃ" position:72 col:1 row:1 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"kyu" japan:@"きゅ" position:73 col:3 row:1 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"kyo" japan:@"きょ" position:74 col:5 row:1 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"sha" japan:@"しゃ" position:75 col:1 row:2 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"shu" japan:@"しゅ" position:76 col:3 row:2 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"sho" japan:@"しょ" position:77 col:5 row:2 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"cha" japan:@"ちゃ" position:78 col:1 row:3 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"chu" japan:@"ちゅ" position:79 col:3 row:3 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"cho" japan:@"ちょ" position:80 col:5 row:3 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"nya" japan:@"にゃ" position:81 col:1 row:4 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"nyu" japan:@"にゅ" position:82 col:3 row:4 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"nyo" japan:@"にょ" position:83 col:5 row:4 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"hya" japan:@"ひゃ" position:84 col:1 row:5 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"hyu" japan:@"ひゅ" position:85 col:3 row:5 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"hyo" japan:@"ひょ" position:86 col:5 row:5 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"mya" japan:@"みゃ" position:87 col:1 row:6 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"myu" japan:@"みゅ" position:88 col:3 row:6 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"myo" japan:@"みょ" position:89 col:5 row:6 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"rya" japan:@"りゃ" position:90 col:1 row:7 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ryu" japan:@"りゅ" position:91 col:3 row:7 section:3 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ryo" japan:@"りょ" position:92 col:5 row:7 section:3 type:0 ];
    
    // yôon avec (han)dakuten
    
    [[Computer sharedInstance] createHiragana:@"gya" japan:@"ぎゃ" position:93 col:1 row:1 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"gyu" japan:@"ぎゅ" position:94 col:3 row:1 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"gyo" japan:@"ぎょ" position:95 col:5 row:1 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ja" japan:@"じゃ" position:96 col:1 row:2 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ju" japan:@"じゅ" position:97 col:3 row:2 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"jo" japan:@"じょ" position:98 col:5 row:2 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ja" japan:@"ぢゃ" position:99 col:1 row:3 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"ju" japan:@"ぢゅ" position:100 col:3 row:3 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"jo" japan:@"ぢょ" position:101 col:5 row:3 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"bya" japan:@"びゃ" position:102 col:1 row:4 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"byu" japan:@"びゅ" position:103 col:3 row:4 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"byo" japan:@"びょ" position:104 col:5 row:4 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pya" japan:@"ぴゃ" position:105 col:1 row:5 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pyu" japan:@"ぴゅ" position:106 col:3 row:5 section:4 type:0 ];
    [[Computer sharedInstance] createHiragana:@"pyo" japan:@"ぴょ" position:107 col:5 row:5 section:4 type:0 ];
    

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
