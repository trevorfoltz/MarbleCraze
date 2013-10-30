//
//  MarbleController.h
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarbleController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableDictionary *columnDict0, *columnDict1, *columnDict2, *columnDict3, *columnDict4, *rowDict;
@property (nonatomic, assign) int numRows;

@property (nonatomic, retain) NSMutableArray *stars;
@property (nonatomic, assign) BOOL starToggle, hasSwiped, addFaster, gridFull;
@property (nonatomic, assign) NSInteger starIdx, scoreTotal, gameOverCnt;
@property (nonatomic, retain) NSTimer *marbleTimer;
@property (nonatomic, retain) IBOutlet UILabel *score0, *score1, *score2, *score3;
@property (nonatomic, retain) NSMutableDictionary *highScores;

- (IBAction)back:(id)sender;

@end
