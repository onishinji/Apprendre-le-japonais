//
//  AppDelegate.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "Computer.h"
#import "UIColor+RGB.h"

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
    HomeViewController * main = (HomeViewController *)[[rootViewController viewControllers] objectAtIndex:0];
    main.managedObjectContext = context;
    
    [[Computer sharedInstance] setManagedObjectContext:context];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"firstLaunch",nil]];

    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [self initKana];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return YES;
}

- (void) initKana
{   
    //=======================
    
    //  HIRAGANA
    
    //=======================
    
    
    
    // gojûon
    
    [[Computer sharedInstance] createKana:@"a" japan:@"あ" position:1 col:1 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"i" japan:@"い" position:2 col:2 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"u" japan:@"う" position:3 col:3 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"e" japan:@"え" position:4 col:4 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"o" japan:@"お" position:5 col:5 row:1 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ka" japan:@"か" position:6 col:1 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ki" japan:@"き" position:7 col:2 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ku" japan:@"く" position:8 col:3 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ke" japan:@"け" position:9 col:4 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ko" japan:@"こ" position:10 col:5 row:2 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"sa" japan:@"さ" position:11 col:1 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"shi" japan:@"し" position:12 col:2 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"su" japan:@"す" position:13 col:3 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"se" japan:@"せ" position:14 col:4 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"so" japan:@"そ" position:15 col:5 row:3 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ta" japan:@"た" position:16 col:1 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"chi" japan:@"ち" position:17 col:2 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"tsu" japan:@"つ" position:18 col:3 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"te" japan:@"て" position:19 col:4 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"to" japan:@"と" position:20 col:5 row:4 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"na" japan:@"な" position:21 col:1 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ni" japan:@"に" position:22 col:2 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"nu" japan:@"ぬ" position:23 col:3 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ne" japan:@"ね" position:24 col:4 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"no" japan:@"の" position:25 col:5 row:5 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ha" japan:@"は" position:26 col:1 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"hi" japan:@"ひ" position:27 col:2 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"fu" japan:@"ふ" position:28 col:3 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"he" japan:@"へ" position:29 col:4 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ho" japan:@"ほ" position:30 col:5 row:6 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ma" japan:@"ま" position:31 col:1 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"mi" japan:@"み" position:32 col:2 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"mu" japan:@"む" position:33 col:3 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"me" japan:@"め" position:34 col:4 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"mo" japan:@"も" position:35 col:5 row:7 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ya" japan:@"や" position:36 col:1 row:8 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"yu" japan:@"ゆ" position:37 col:3 row:8 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"yo" japan:@"よ" position:38 col:5 row:8 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ra" japan:@"ら" position:39 col:1 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ri" japan:@"り" position:40 col:2 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ru" japan:@"る" position:41 col:3 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"re" japan:@"れ" position:42 col:4 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"ro" japan:@"ろ" position:43 col:5 row:9 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"wa" japan:@"わ" position:44 col:1 row:10 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"(w)o" japan:@"を" position:45 col:5 row:10 section:1 type:0 ];
    [[Computer sharedInstance] createKana:@"n" japan:@"ん" position:46 col:5 row:11 section:1 type:0 ];
    
    // gojûon avec (han)dakuten
    
    [[Computer sharedInstance] createKana:@"ga" japan:@"が" position:47 col:1 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"gi" japan:@"ぎ" position:48 col:2 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"gu" japan:@"ぐ" position:49 col:3 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"ge" japan:@"げ" position:50 col:4 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"go" japan:@"ご" position:51 col:5 row:1 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"za" japan:@"ざ" position:52 col:1 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"ji" japan:@"じ" position:53 col:2 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"zu" japan:@"ず" position:54 col:3 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"ze" japan:@"ぜ" position:55 col:4 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"zo" japan:@"ぞ" position:56 col:5 row:2 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"da" japan:@"だ" position:57 col:1 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"ji" japan:@"ぢ" position:58 col:2 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"zu" japan:@"づ" position:59 col:3 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"de" japan:@"で" position:60 col:4 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"do" japan:@"ど" position:61 col:5 row:3 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"ba" japan:@"ば" position:62 col:1 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"bi" japan:@"び" position:63 col:2 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"bu" japan:@"ぶ" position:64 col:3 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"be" japan:@"べ" position:65 col:4 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"bo" japan:@"ぼ" position:66 col:5 row:4 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"pa" japan:@"ぱ" position:67 col:1 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"pi" japan:@"ぴ" position:68 col:2 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"pu" japan:@"ぷ" position:69 col:3 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"pe" japan:@"ぺ" position:70 col:4 row:5 section:2 type:0 ];
    [[Computer sharedInstance] createKana:@"po" japan:@"ぽ" position:71 col:5 row:5 section:2 type:0 ];
    
    // yôon
    
    [[Computer sharedInstance] createKana:@"kya" japan:@"きゃ" position:72 col:1 row:1 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"kyu" japan:@"きゅ" position:73 col:3 row:1 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"kyo" japan:@"きょ" position:74 col:5 row:1 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"sha" japan:@"しゃ" position:75 col:1 row:2 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"shu" japan:@"しゅ" position:76 col:3 row:2 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"sho" japan:@"しょ" position:77 col:5 row:2 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"cha" japan:@"ちゃ" position:78 col:1 row:3 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"chu" japan:@"ちゅ" position:79 col:3 row:3 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"cho" japan:@"ちょ" position:80 col:5 row:3 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"nya" japan:@"にゃ" position:81 col:1 row:4 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"nyu" japan:@"にゅ" position:82 col:3 row:4 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"nyo" japan:@"にょ" position:83 col:5 row:4 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"hya" japan:@"ひゃ" position:84 col:1 row:5 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"hyu" japan:@"ひゅ" position:85 col:3 row:5 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"hyo" japan:@"ひょ" position:86 col:5 row:5 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"mya" japan:@"みゃ" position:87 col:1 row:6 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"myu" japan:@"みゅ" position:88 col:3 row:6 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"myo" japan:@"みょ" position:89 col:5 row:6 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"rya" japan:@"りゃ" position:90 col:1 row:7 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"ryu" japan:@"りゅ" position:91 col:3 row:7 section:3 type:0 ];
    [[Computer sharedInstance] createKana:@"ryo" japan:@"りょ" position:92 col:5 row:7 section:3 type:0 ];
    
    // yôon avec (han)dakuten
    
    [[Computer sharedInstance] createKana:@"gya" japan:@"ぎゃ" position:93 col:1 row:1 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"gyu" japan:@"ぎゅ" position:94 col:3 row:1 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"gyo" japan:@"ぎょ" position:95 col:5 row:1 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"ja" japan:@"じゃ" position:96 col:1 row:2 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"ju" japan:@"じゅ" position:97 col:3 row:2 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"jo" japan:@"じょ" position:98 col:5 row:2 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"ja" japan:@"ぢゃ" position:99 col:1 row:3 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"ju" japan:@"ぢゅ" position:100 col:3 row:3 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"jo" japan:@"ぢょ" position:101 col:5 row:3 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"bya" japan:@"びゃ" position:102 col:1 row:4 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"byu" japan:@"びゅ" position:103 col:3 row:4 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"byo" japan:@"びょ" position:104 col:5 row:4 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"pya" japan:@"ぴゃ" position:105 col:1 row:5 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"pyu" japan:@"ぴゅ" position:106 col:3 row:5 section:4 type:0 ];
    [[Computer sharedInstance] createKana:@"pyo" japan:@"ぴょ" position:107 col:5 row:5 section:4 type:0 ];
    
    //=======================
    
    //  KATAKANA
    
    //=======================
    
    
    
    // gojûon
    
    [[Computer sharedInstance] createKana:@"a" japan:@"ア" position:1 col:1 row:1 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"i" japan:@"イ" position:2 col:2 row:1 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"u" japan:@"ウ" position:3 col:3 row:1 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"e" japan:@"エ" position:4 col:4 row:1 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"o" japan:@"オ" position:5 col:5 row:1 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ka" japan:@"カ" position:6 col:1 row:2 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"ki" japan:@"キ" position:7 col:2 row:2 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"ku" japan:@"ク" position:8 col:3 row:2 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"ke" japan:@"ケ" position:9 col:4 row:2 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"ko" japan:@"コ" position:10 col:5 row:2 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"sa" japan:@"サ" position:11 col:1 row:3 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"shi" japan:@"シ" position:12 col:2 row:3 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"su" japan:@"ス" position:13 col:3 row:3 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"se" japan:@"セ" position:14 col:4 row:3 section:1 type:1 ];
    [[Computer sharedInstance] createKana:@"so" japan:@"ソ" position:15 col:5 row:3 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ta" japan:@"タ" position:16 col:1 row:4 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"chi" japan:@"チ" position:17 col:2 row:4 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"tsu" japan:@"ツ" position:18 col:3 row:4 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"te" japan:@"テ" position:19 col:4 row:4 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"to" japan:@"ヨ" position:20 col:5 row:4 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"na" japan:@"ナ" position:21 col:1 row:5 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ni" japan:@"ニ" position:22 col:2 row:5 section:1 type:1 ];
    
    // gojûon
    
    [[Computer sharedInstance] createKana:@"nu" japan:@"ヌ" position:23 col:3 row:5 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ne" japan:@"ネ" position:24 col:4 row:5 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"no" japan:@"ノ" position:25 col:5 row:5 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ha" japan:@"ハ" position:26 col:1 row:6 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"hi" japan:@"ヒ" position:27 col:2 row:6 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"fu" japan:@"フ" position:28 col:3 row:6 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"he" japan:@"ヘ" position:29 col:4 row:6 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ho" japan:@"ホ" position:30 col:5 row:6 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ma" japan:@"マ" position:31 col:1 row:7 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"mi" japan:@"ミ" position:32 col:2 row:7 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"mu" japan:@"ム" position:33 col:3 row:7 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"me" japan:@"メ" position:34 col:4 row:7 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"mo" japan:@"モ" position:35 col:5 row:7 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ya" japan:@"ヤ" position:36 col:1 row:8 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"yu" japan:@"ユ" position:37 col:3 row:8 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"yo" japan:@"ヨ" position:38 col:5 row:8 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ra" japan:@"ラ" position:39 col:1 row:9 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ri" japan:@"リ" position:40 col:2 row:9 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ru" japan:@"ル" position:41 col:3 row:9 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"re" japan:@"レ" position:42 col:4 row:9 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ro" japan:@"ロ" position:43 col:5 row:9 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"wa" japan:@"ワ" position:44 col:1 row:10 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"(w)o" japan:@"ヲ" position:45 col:5 row:10 section:1 type:1 ];
    
    [[Computer sharedInstance] createKana:@"n" japan:@"ン" position:46 col:5 row:11 section:1 type:1 ];
    
    // gojûon avec (han)dakuten
    
    [[Computer sharedInstance] createKana:@"ga" japan:@"ガ" position:47 col:1 row:1 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"gi" japan:@"ギ" position:48 col:2 row:1 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"gu" japan:@"グ" position:49 col:3 row:1 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ge" japan:@"ゲ" position:50 col:4 row:1 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"go" japan:@"ゴ" position:51 col:5 row:1 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"za" japan:@"ザ" position:52 col:1 row:2 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ji" japan:@"ジ" position:53 col:2 row:2 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"zu" japan:@"ズ" position:54 col:3 row:2 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ze" japan:@"ゼ" position:55 col:4 row:2 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"zo" japan:@"ゾ" position:56 col:5 row:2 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"da" japan:@"ダ" position:57 col:1 row:3 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ji" japan:@"ジ" position:58 col:2 row:3 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"zu" japan:@"ヅ" position:59 col:3 row:3 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"de" japan:@"デ" position:60 col:4 row:3 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"do" japan:@"ド" position:61 col:5 row:3 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ba" japan:@"バ" position:62 col:1 row:4 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"bi" japan:@"ビ" position:63 col:2 row:4 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"bu" japan:@"ブ" position:64 col:3 row:4 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"be" japan:@"ベ" position:65 col:4 row:4 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"bo" japan:@"ボ" position:66 col:5 row:4 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pa" japan:@"パ" position:67 col:1 row:5 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pi" japan:@"ピ" position:68 col:2 row:5 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pu" japan:@"プ" position:69 col:3 row:5 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pe" japan:@"ペ" position:70 col:4 row:5 section:2 type:1 ];
    
    [[Computer sharedInstance] createKana:@"po" japan:@"ポ" position:71 col:5 row:5 section:2 type:1 ];
    
    // yôon
    
    [[Computer sharedInstance] createKana:@"kya" japan:@"キャ" position:72 col:1 row:1 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"kyu" japan:@"キュ" position:73 col:3 row:1 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"kyo" japan:@"キョ" position:74 col:5 row:1 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"sha" japan:@"シャ" position:75 col:1 row:2 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"shu" japan:@"シュ" position:76 col:3 row:2 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"sho" japan:@"ショ" position:77 col:5 row:2 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"cha" japan:@"チャ" position:78 col:1 row:3 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"chu" japan:@"チュ" position:79 col:3 row:3 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"cho" japan:@"チョ" position:80 col:5 row:3 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"nya" japan:@"ニャ" position:81 col:1 row:4 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"nyu" japan:@"ニュ" position:82 col:3 row:4 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"nyo" japan:@"ニョ" position:83 col:5 row:4 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"hya" japan:@"ヒャ" position:84 col:1 row:5 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"hyu" japan:@"ヒュ" position:85 col:3 row:5 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"hyo" japan:@"ヒョ" position:86 col:5 row:5 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"mya" japan:@"ミャ" position:87 col:1 row:6 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"myu" japan:@"ミュ" position:88 col:3 row:6 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"myo" japan:@"ミョ" position:89 col:5 row:6 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"rya" japan:@"リャ" position:90 col:1 row:7 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ryu" japan:@"リュ" position:91 col:3 row:7 section:3 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ryo" japan:@"リョ" position:92 col:5 row:7 section:3 type:1 ];
    
    // yôon avec (han)dakuten
    
    [[Computer sharedInstance] createKana:@"gya" japan:@"ギャ" position:93 col:1 row:1 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"gyu" japan:@"ギュ" position:94 col:3 row:1 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"gyo" japan:@"ギョ" position:95 col:5 row:1 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ja" japan:@"ジャ" position:96 col:1 row:2 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ju" japan:@"ジュ" position:97 col:3 row:2 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"jo" japan:@"ジョ" position:98 col:5 row:2 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ja" japan:@"ヂャ" position:99 col:1 row:3 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"ju" japan:@"ヂュ" position:100 col:3 row:3 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"jo" japan:@"ヂョ" position:101 col:5 row:3 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"bya" japan:@"ビャ" position:102 col:1 row:4 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"byu" japan:@"ビュ" position:103 col:3 row:4 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"byo" japan:@"ビョ" position:104 col:5 row:4 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pya" japan:@"ピャ" position:105 col:1 row:5 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pyu" japan:@"ピュ" position:106 col:3 row:5 section:4 type:1 ];
    
    [[Computer sharedInstance] createKana:@"pyo" japan:@"ピョ" position:107 col:5 row:5 section:4 type:1 ];
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
