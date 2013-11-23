//
//  HighScoresController.h
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StarTwinkler.h"

@interface HighScoresController : UIViewController <UITextFieldDelegate>


@property (nonatomic, assign) NSInteger newHighScore, touchCount, score2Edit;

@property (nonatomic, retain) NSMutableDictionary *highScores;

@property (nonatomic, assign) BOOL justViewing;

@property (nonatomic, retain) IBOutlet UITextField *txtPlayer;

@property (nonatomic, retain) CALayer *theLayer;

@property (nonatomic, retain) UIView *shiftView;

@property (nonatomic, retain) StarTwinkler *twinkler;

@end
