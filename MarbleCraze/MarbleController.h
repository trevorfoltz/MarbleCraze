//
//  MarbleController.h
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MarbleController : UIViewController <UIAlertViewDelegate, AVAudioPlayerDelegate>

@property (nonatomic, retain) NSMutableDictionary *columnDict0, *columnDict1, *columnDict2, *columnDict3, *columnDict4, *rowDict;
@property (nonatomic, assign) int numRows;

@property (nonatomic, assign) BOOL hasSwiped, addFaster, gridFull, betweenRounds, isPaused;
@property (nonatomic, assign) NSInteger scoreTotal, gameOverCnt, gameCount, gameLevel;
@property (nonatomic, retain) NSTimer *marbleTimer, *gameTimer;
@property (nonatomic, retain) IBOutlet UILabel *score0, *score1, *score2, *score3;
@property (nonatomic, retain) NSMutableDictionary *highScores, *savedGame;
@property (nonatomic, retain) AVAudioPlayer *firePlayer, *gameOverPlayer, *roundOverPlayer, *loopPlayer;

@property (nonatomic, retain) IBOutlet UIButton *pauseButton;

- (IBAction)back:(id)sender;
- (IBAction)pause:(id)sender;

@end
