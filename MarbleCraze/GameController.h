//
//  GameController.h
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameController : UIViewController

@property (nonatomic, retain) NSMutableArray *stars;
@property (nonatomic, assign) BOOL starToggle;
@property (nonatomic, assign) NSInteger starIdx;
@property (nonatomic, retain) NSMutableDictionary *highScores;

- (IBAction)newGame:(id)sender;
- (IBAction)aboutGame:(id)sender;

@end
