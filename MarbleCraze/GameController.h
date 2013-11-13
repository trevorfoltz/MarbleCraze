//
//  GameController.h
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarTwinkler.h"

@interface GameController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableDictionary *highScores, *savedGame;
@property (nonatomic, retain) StarTwinkler *twinkler;

- (IBAction)newGame:(id)sender;
- (IBAction)aboutGame:(id)sender;

@end
