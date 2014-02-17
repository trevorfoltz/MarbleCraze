//
//  AppDelegate.h
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) NSMutableDictionary *savedGame;

@property (strong, nonatomic) ADBannerView *bannerView;

@property (assign, nonatomic) BOOL bannerHidden;
@end
