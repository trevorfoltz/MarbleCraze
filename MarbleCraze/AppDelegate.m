//
//  AppDelegate.m
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize savedGame, bannerView, bannerHidden;

- (void)updateSavedGame
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.savedGame = [NSMutableDictionary dictionaryWithDictionary:[defaults dictionaryForKey:@"MarbleCrazeSavedGame"]];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"15f18330-5323-4c7d-870f-db9a0de68989"];
    [self updateSavedGame];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHighScores) name:@"UpdateHighScoresNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSavedGame) name:@"UpdateSavedGameNotification" object:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    CGRect screen = [[UIScreen mainScreen] bounds];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
        self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, screen.size.height - 50, 320, 50)];
        
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, screen.size.height - 66, 768, 66)];
    }
    self.bannerView.alpha = 0.0;
    self.bannerView.delegate = self;
    [self.window.rootViewController.view addSubview:self.bannerView];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAdBanner:) name:@"HideAdBannerNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdBanner:) name:@"ShowAdBannerNotification" object:nil];
    return YES;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView animateWithDuration:1.0 animations:^{
        self.bannerView.alpha = 0.0;
        
        //        CGRect screen = [[UIScreen mainScreen] bounds];
        //        self.bannerView.center = CGPointMake(screen.size.width / 2, screen.size.height);
    }];
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerHidden) {
        [UIView animateWithDuration:1.5 animations:^{
            self.bannerView.alpha = 1.0;
        }];
    }
}


- (void)hideAdBanner:(NSNotification *) notice
{
    [UIView animateWithDuration:0.5 animations:^{
        self.bannerView.alpha = 0.0;
    }];
    [self setBannerHidden:YES];
}

- (void)showAdBanner:(NSNotification *) notice
{
    [self setBannerHidden:NO];
    
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
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
