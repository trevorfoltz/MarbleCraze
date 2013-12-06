//
//  MarbleController.m
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "MarbleController.h"
#import "HighScoresController.h"
#import "Marble.h"

@interface MarbleController ()

@end

@implementation MarbleController

@synthesize columnDict0, columnDict1, columnDict2, columnDict3, columnDict4;
@synthesize gridFull, gameLevel, betweenRounds, savedGame, isPaused;
@synthesize numRows, hasSwiped, marbleTimer, rowDict;
@synthesize score0, score1, score2, score3, scoreTotal;
@synthesize gameOverCnt, gameTimer, gameCount;
@synthesize firePlayer, gameOverPlayer, roundOverPlayer, loopPlayer;
@synthesize pauseButton, twinkler;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotate
{
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    }
    return NO;
}

- (int)getRandomMarble
{
    return (arc4random() %(8)) + 1;
}

- (void)populateColumn:(NSInteger) column withMarbles:(NSInteger) count
{
    CGFloat cWidth = 40;
    CGFloat mWidth = 40;
    CGFloat startY = 210;
    CGFloat startX = 60;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cWidth = 80;
        mWidth = 80;
        startY = 500;
        startX = 200;
    }
    for (int j = 1; j<count; j++) {
        int marbleIdx = [self getRandomMarble];
        Marble *aMarble = [[Marble alloc] initWithFrame:CGRectMake((column * cWidth) + startX, startY - (j * cWidth), mWidth, mWidth) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        aMarble.imageIdx = marbleIdx;
        aMarble.alpha = 0.6;
        [self.view addSubview:aMarble];
        marbleIdx = [self getRandomMarble];
        Marble *bMarble = [[Marble alloc] initWithFrame:CGRectMake((column * cWidth) + startX, (j * cWidth) + startY, mWidth, mWidth) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        bMarble.imageIdx = marbleIdx;
        bMarble.alpha = 0.6;
        [self.view addSubview:bMarble];
        switch (column) {
            case 0:
                [self.columnDict0 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", j*-1]];
                [self.columnDict0 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", j]];
                break;
            case 1:
                [self.columnDict1 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", j*-1]];
                [self.columnDict1 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", j]];
                break;
            case 2:
                [self.columnDict2 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", j*-1]];
                [self.columnDict2 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", j]];
                break;
            case 3:
                [self.columnDict3 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", j*-1]];
                [self.columnDict3 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", j]];
                break;
            case 4:
                [self.columnDict4 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", j*-1]];
                [self.columnDict4 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", j]];
                break;
        }
    }
}

- (void)setupIphone
{
    // Left and right borders
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(60, 6, 1, 444)];
    hView.backgroundColor = [UIColor redColor];
    hView.alpha = 0.5;
    [self.view addSubview:hView];
    
    UIView *iView = [[UIView alloc] initWithFrame:CGRectMake(260, 6, 1, 443)];
    iView.backgroundColor = [UIColor redColor];
    iView.alpha = 0.5;
    [self.view addSubview:iView];
    
    //  Top border
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 320, 5)];
    bView.backgroundColor = [UIColor redColor];
    bView.alpha = 0.8;
    [self.view addSubview:bView];
    
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 320, 1)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.alpha = 0.8;
    [self.view addSubview:dView];
    
    //  Middle row
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, 320, 40)];
    aView.backgroundColor = [UIColor redColor];
    aView.alpha = 0.3;
    [self.view addSubview:aView];
    
    UIView *fView = [[UIView alloc] initWithFrame:CGRectMake(0, 209, 320, 1)];
    fView.backgroundColor = [UIColor whiteColor];
    fView.alpha = 0.8;
    [self.view addSubview:fView];
    
    UIView *gView = [[UIView alloc] initWithFrame:CGRectMake(0, 251, 320, 1)];
    gView.backgroundColor = [UIColor whiteColor];
    gView.alpha = 0.8;
    [self.view addSubview:gView];
    
    //  Bottom border
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(0, 452, 320, 5)];
    cView.backgroundColor = [UIColor redColor];
    cView.alpha = 0.8;
    [self.view addSubview:cView];
    
    UIView *eView = [[UIView alloc] initWithFrame:CGRectMake(0, 451, 320, 1)];
    eView.backgroundColor = [UIColor whiteColor];
    eView.alpha = 0.8;
    [self.view addSubview:eView];
}

- (void)setupIpad
{
    
    // Left and right borders
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(198, 94, 2, 884)];
    hView.backgroundColor = [UIColor redColor];
    hView.alpha = 0.5;
    [self.view addSubview:hView];
    UIView *iView = [[UIView alloc] initWithFrame:CGRectMake(598, 94, 2, 884)];
    iView.backgroundColor = [UIColor redColor];
    iView.alpha = 0.5;
    [self.view addSubview:iView];
    
    //  Top border
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, 768, 10)];
    bView.backgroundColor = [UIColor redColor];
    bView.alpha = 0.8;
    [self.view addSubview:bView];
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, 768, 2)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.alpha = 0.8;
    [self.view addSubview:dView];
    
    //  Middle row
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 768, 80)];
    aView.backgroundColor = [UIColor redColor];
    aView.alpha = 0.3;
    [self.view addSubview:aView];
    
    UIView *fView = [[UIView alloc] initWithFrame:CGRectMake(0, 498, 768, 2)];
    fView.backgroundColor = [UIColor whiteColor];
    fView.alpha = 0.8;
    [self.view addSubview:fView];
    
    UIView *gView = [[UIView alloc] initWithFrame:CGRectMake(0, 580, 768, 2)];
    gView.backgroundColor = [UIColor whiteColor];
    gView.alpha = 0.8;
    [self.view addSubview:gView];
    
    
    //  Bottom border
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(0, 982, 768, 10)];
    cView.backgroundColor = [UIColor redColor];
    cView.alpha = 0.8;
    [self.view addSubview:cView];
    UIView *eView = [[UIView alloc] initWithFrame:CGRectMake(0, 980, 768, 2)];
    eView.backgroundColor = [UIColor whiteColor];
    eView.alpha = 0.8;
    [self.view addSubview:eView];

}

- (void)updateGameTime
{
    self.gameCount++;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.gameCount = 0;
    if (self.loopPlayer != nil) {
        [self.loopPlayer prepareToPlay];
        [self.loopPlayer play];
    }
    [self setIsPaused:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.loopPlayer stop];
    [self setIsPaused:YES];
    
}

- (void)populateMarbles
{
    CGFloat cWidth = 40;
    CGFloat mWidth = 40;
    CGFloat xVal = 60;
    CGFloat yVal = 210;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self setupIpad];
        cWidth = 80;
        mWidth = 80;
        xVal = 200;
        yVal = 500;
    }
    else {
        [self setupIphone];
    }
    //  Populate columnDicts...
    if (self.gameLevel >= 0 && !self.betweenRounds && [[self.savedGame allKeys] containsObject:@"col0"]) {
        NSNumber *colCount = (NSNumber *)[self.savedGame objectForKey:@"col0"];
        [self populateColumn:0 withMarbles:[colCount integerValue] + 1];
    }
    else {
        [self populateColumn:0 withMarbles:self.numRows];
    }
    
    if (self.gameLevel >= 0 && !self.betweenRounds && [[self.savedGame allKeys] containsObject:@"col1"]) {
        NSNumber *colCount = (NSNumber *)[self.savedGame objectForKey:@"col1"];
        [self populateColumn:1 withMarbles:[colCount integerValue] + 1];
    }
    else {
        [self populateColumn:1 withMarbles:self.numRows];
    }
    if (self.gameLevel >= 0 && !self.betweenRounds && [[self.savedGame allKeys] containsObject:@"col2"]) {
        NSNumber *colCount = (NSNumber *)[self.savedGame objectForKey:@"col2"];
        [self populateColumn:2 withMarbles:[colCount integerValue] + 1];
    }
    else {
        [self populateColumn:2 withMarbles:self.numRows];
    }
    if (self.gameLevel >= 0 && !self.betweenRounds && [[self.savedGame allKeys] containsObject:@"col3"]) {
        NSNumber *colCount = (NSNumber *)[self.savedGame objectForKey:@"col3"];
        [self populateColumn:3 withMarbles:[colCount integerValue] + 1];
    }
    else {
        [self populateColumn:3 withMarbles:self.numRows];
    }
    if (self.gameLevel >= 0 && !self.betweenRounds && [[self.savedGame allKeys] containsObject:@"col4"]) {
        NSNumber *colCount = (NSNumber *)[self.savedGame objectForKey:@"col4"];
        [self populateColumn:4 withMarbles:[colCount integerValue] + 1];
    }
    else {
        [self populateColumn:4 withMarbles:self.numRows];
    }
    
    for (int i = -3; i<8; i++) {
        int marbleIdx = [self getRandomMarble];
        Marble *aMarble = [[Marble alloc] initWithFrame:CGRectMake((i * cWidth) + xVal, yVal, mWidth, mWidth) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        aMarble.imageIdx = marbleIdx;
        aMarble.alpha = 1.0;
        [self.view addSubview:aMarble];
        [self.rowDict setObject:aMarble forKey:[NSString stringWithFormat:@"%d", i]];
    }
    [self setBetweenRounds:NO];
    if (self.gameLevel < 0) {
        self.gameLevel = 0;
    }
    if (self.scoreTotal < 0) {
        self.scoreTotal = 0;
    }
    [self updateScoreLabel];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == self.loopPlayer) {
//        [self.loopPlayer prepareToPlay];
        [self.loopPlayer play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.twinkler = [StarTwinkler initWithParentView:self.view];
    
    NSURL *roundOverURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"LevelComplete" ofType:@"mp3"]];
	NSError *error;
	self.roundOverPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:roundOverURL error:&error];
    [self.roundOverPlayer prepareToPlay];
    
    NSURL *gameOverURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"GameOver" ofType:@"mp3"]];
	self.gameOverPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:gameOverURL error:&error];
    [self.gameOverPlayer prepareToPlay];
    
    NSURL *loopURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loop" ofType:@"mp3"]];
	self.loopPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:loopURL error:&error];
    self.loopPlayer.delegate = self;
    [self.loopPlayer prepareToPlay];
    [self.loopPlayer play];
    
    NSURL *fireURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"fireEffect" ofType:@"mp3"]];
	self.firePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fireURL error:&error];
    [self.firePlayer prepareToPlay];
    
    self.columnDict0 = [NSMutableDictionary dictionaryWithCapacity:1];
    self.columnDict1 = [NSMutableDictionary dictionaryWithCapacity:1];
    self.columnDict2 = [NSMutableDictionary dictionaryWithCapacity:1];
    self.columnDict3 = [NSMutableDictionary dictionaryWithCapacity:1];
    self.columnDict4 = [NSMutableDictionary dictionaryWithCapacity:1];
    
    self.score0.text = @"";
    self.score1.text = @"";
    self.score2.text = @"";
    self.score3.text = @"";
    self.scoreTotal = 0;
    
    self.rowDict = [NSMutableDictionary dictionaryWithCapacity:1];
    
    self.numRows = 3;
    
    if ([[self.savedGame allKeys] count] > 0) {
        self.gameLevel = [[self.savedGame objectForKey:@"level"] integerValue];
        self.scoreTotal = [[self.savedGame objectForKey:@"score"] integerValue];
    }
    [self updateScoreLabel];
    
    [self populateMarbles];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeDown];
    [self.view addGestureRecognizer:swipeUp];
    
    [self performSelector:@selector(addMarble) withObject:nil afterDelay:3.0];
}

//  Determines how many marbles are above the middle row for a column.
- (NSInteger)lowestColumnKey:(NSDictionary *) columnDict
{
    NSInteger retVal = 0;
    for (NSString *key in [columnDict allKeys]) {
        if ([key integerValue] < retVal) {
            retVal = [key integerValue];
        }
    }
    return retVal;
}

//  Determines how many marbles are below the middle row for a column.
- (NSInteger)highestColumnKey:(NSDictionary *) columnDict
{
    NSInteger retVal = 0;
    for (NSString *key in [columnDict allKeys]) {
        if ([key integerValue] > retVal) {
            retVal = [key integerValue];
        }
    }
    return retVal;
}

- (NSInteger)lowestRowKey
{
    NSInteger retVal = 10;
    for (NSString *key in [self.rowDict allKeys]) {
        if ([key integerValue] < retVal) {
            retVal = [key integerValue];
        }
    }
    return retVal;
}

- (NSInteger)highestRowKey
{
    NSInteger retVal = -10;
    for (NSString *key in [self.rowDict allKeys]) {
        if ([key integerValue] > retVal) {
            retVal = [key integerValue];
        }
    }
    return retVal;
}

- (NSInteger)getHighestColumn
{
    NSInteger retVal1 = [self highestColumnKey:self.columnDict0];
    NSInteger retVal2 = [self highestColumnKey:self.columnDict1];
    if (retVal2 > retVal1) {
        retVal1 = retVal2;
    }
    retVal2 = [self highestColumnKey:self.columnDict2];
    if (retVal2 > retVal1) {
        retVal1 = retVal2;
    }
    retVal2 = [self highestColumnKey:self.columnDict3];
    if (retVal2 > retVal1) {
        retVal1 = retVal2;
    }
    retVal2 = [self highestColumnKey:self.columnDict4];
    if (retVal2 > retVal1) {
        retVal1 = retVal2;
    }
    return retVal1;
}

- (NSInteger)getLowestColumn
{
    NSInteger retVal1 = [self lowestColumnKey:self.columnDict0];
    NSInteger retVal2 = [self lowestColumnKey:self.columnDict1];
    if (retVal2 < retVal1) {
        retVal1 = retVal2;
    }
    retVal2 = [self lowestColumnKey:self.columnDict2];
    if (retVal2 < retVal1) {
        retVal1 = retVal2;
    }
    retVal2 = [self lowestColumnKey:self.columnDict3];
    if (retVal2 < retVal1) {
        retVal1 = retVal2;
    }
    retVal2 = [self lowestColumnKey:self.columnDict4];
    if (retVal2 < retVal1) {
        retVal1 = retVal2;
    }
    return retVal1;
}

- (NSInteger)getImageIndexForMarble:(NSInteger) marbleIdx
{
    Marble *aMarble = (Marble *)[self.rowDict objectForKey:[NSString stringWithFormat:@"%d", marbleIdx]];
    return aMarble.imageIdx;
}

- (BOOL)checkForMatchedMarblesFromStart:(NSInteger) idx ofLength:(NSInteger) length
{
    NSInteger firstImgIdx = [self getImageIndexForMarble:idx];
    for (int i = (idx + 1);i < (idx + length);i++) {
        NSInteger currentIdx = [self getImageIndexForMarble:i];
        if (currentIdx != firstImgIdx) {
            return NO;
        }
    }
    return YES;
}

- (Marble *)getRandomMarbleForRowWithKey:(NSInteger) key
{
    Marble *aMarble;
    int marbleIdx = [self getRandomMarble];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        aMarble = [[Marble alloc] initWithFrame:CGRectMake((key * 80) + 200, 500, 80, 80) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
    }
    else {
        aMarble = [[Marble alloc] initWithFrame:CGRectMake((key * 40) + 60, 210, 40, 40) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
    }
    
    aMarble.imageIdx = marbleIdx;
    return aMarble;
}

- (void)moveColumnUp:(NSInteger) column
{
    NSInteger hiIdx = 100;
    Marble *aMarble;
    switch (column) {
        case 0:
            hiIdx = [self highestColumnKey:self.columnDict0];
            if ([[self.columnDict0 allKeys] containsObject:@"1"]) {
                aMarble = (Marble *)[self.columnDict0 objectForKey:@"1"];
                [self moveMarbleUp:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict0 removeObjectForKey:@"1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:0];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"0"];
            
            for (int i = 2;i < (hiIdx + 1);i++) {
                Marble *bMarble = (Marble *)[self.columnDict0 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleUp:bMarble];
                    [self.columnDict0 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict0 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 1:
            hiIdx = [self highestColumnKey:self.columnDict1];
            if ([[self.columnDict1 allKeys] containsObject:@"1"]) {
                aMarble = (Marble *)[self.columnDict1 objectForKey:@"1"];
                [self moveMarbleUp:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict1 removeObjectForKey:@"1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:1];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"1"];
            
            for (int i = 2;i < (hiIdx + 1);i++) {
                Marble *bMarble = (Marble *)[self.columnDict1 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleUp:bMarble];
                    [self.columnDict1 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict1 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 2:
            hiIdx = [self highestColumnKey:self.columnDict2];
            if ([[self.columnDict2 allKeys] containsObject:@"1"]) {
                aMarble = (Marble *)[self.columnDict2 objectForKey:@"1"];
                [self moveMarbleUp:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict2 removeObjectForKey:@"1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:2];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"2"];
            
            for (int i = 2;i < (hiIdx + 1);i++) {
                Marble *bMarble = (Marble *)[self.columnDict2 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleUp:bMarble];
                    [self.columnDict2 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict2 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 3:
            hiIdx = [self highestColumnKey:self.columnDict3];
            if ([[self.columnDict3 allKeys] containsObject:@"1"]) {
                aMarble = (Marble *)[self.columnDict3 objectForKey:@"1"];
                [self moveMarbleUp:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict3 removeObjectForKey:@"1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:3];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"3"];
            
            for (int i = 2;i < (hiIdx + 1);i++) {
                Marble *bMarble = (Marble *)[self.columnDict3 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleUp:bMarble];
                    [self.columnDict3 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict3 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 4:
            hiIdx = [self highestColumnKey:self.columnDict4];
            if ([[self.columnDict4 allKeys] containsObject:@"1"]) {
                aMarble = (Marble *)[self.columnDict4 objectForKey:@"1"];
                [self moveMarbleUp:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict4 removeObjectForKey:@"1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:4];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"4"];
            
            for (int i = 2;i < (hiIdx + 1);i++) {
                Marble *bMarble = (Marble *)[self.columnDict4 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleUp:bMarble];
                    [self.columnDict4 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict4 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
    }
}

- (void)moveColumnDown:(NSInteger) column
{
    NSInteger loIdx = 100;
    Marble *aMarble;
    int marbleIdx;
    
    switch (column) {
        case 0:
            loIdx = [self lowestColumnKey:self.columnDict0];
            if ([[self.columnDict0 allKeys] containsObject:@"-1"]) {
                aMarble = (Marble *)[self.columnDict0 objectForKey:@"-1"];
                [self moveMarbleDown:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict0 removeObjectForKey:@"-1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:0];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"0"];
            for (int i = -2;i > (loIdx - 1);i--) {
                Marble *bMarble = (Marble *)[self.columnDict0 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleDown:bMarble];
                    [self.columnDict0 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict0 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 1:
            loIdx = [self lowestColumnKey:self.columnDict1];
            if ([[self.columnDict1 allKeys] containsObject:@"-1"]) {
                aMarble = (Marble *)[self.columnDict1 objectForKey:@"-1"];
                [self moveMarbleDown:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict1 removeObjectForKey:@"-1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:1];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"1"];
            for (int i = -2;i > (loIdx - 1);i--) {
                Marble *bMarble = (Marble *)[self.columnDict1 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleDown:bMarble];
                    [self.columnDict1 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict1 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 2:
            loIdx = [self lowestColumnKey:self.columnDict2];
            if ([[self.columnDict2 allKeys] containsObject:@"-1"]) {
                aMarble = (Marble *)[self.columnDict2 objectForKey:@"-1"];
                [self moveMarbleDown:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict2 removeObjectForKey:@"-1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:2];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"2"];
            for (int i = -2;i > (loIdx - 1);i--) {
                Marble *bMarble = (Marble *)[self.columnDict2 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleDown:bMarble];
                    [self.columnDict2 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict2 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 3:
            loIdx = [self lowestColumnKey:self.columnDict3];
            if ([[self.columnDict3 allKeys] containsObject:@"-1"]) {
                aMarble = (Marble *)[self.columnDict3 objectForKey:@"-1"];
                [self moveMarbleDown:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict3 removeObjectForKey:@"-1"];
            }
            else {
                marbleIdx = [self getRandomMarble];
                aMarble = [self getRandomMarbleForRowWithKey:3];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"3"];
            for (int i = -2;i > (loIdx - 1);i--) {
                Marble *bMarble = (Marble *)[self.columnDict3 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleDown:bMarble];
                    [self.columnDict3 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict3 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
        case 4:
            loIdx = [self lowestColumnKey:self.columnDict4];
            if ([[self.columnDict4 allKeys] containsObject:@"-1"]) {
                aMarble = (Marble *)[self.columnDict4 objectForKey:@"-1"];
                [self moveMarbleDown:aMarble];
                aMarble.alpha = 1.0;
                [self.columnDict4 removeObjectForKey:@"-1"];
            }
            else {
                aMarble = [self getRandomMarbleForRowWithKey:4];
                [self.view addSubview:aMarble];
            }
            [self.rowDict setObject:aMarble forKey:@"4"];
            for (int i = -2;i > (loIdx - 1);i--) {
                Marble *bMarble = (Marble *)[self.columnDict4 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (bMarble) {
                    [self moveMarbleDown:bMarble];
                    [self.columnDict4 setObject:bMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict4 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            break;
    }
}

- (int)getRandomColumn
{
    return (arc4random() %(5));
    
}

- (NSInteger)getShortestColumnAbove
{
    NSInteger retVal = 0;
    NSInteger tempInt = 10;
    NSInteger colCount = 0;
    for (NSString *key in [self.columnDict0 allKeys]) {
        if ([key integerValue] < 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 0;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict1 allKeys]) {
        if ([key integerValue] < 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 1;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict2 allKeys]) {
        if ([key integerValue] < 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 2;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict3 allKeys]) {
        if ([key integerValue] < 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 3;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict4 allKeys]) {
        if ([key integerValue] < 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 4;
    }
    return retVal;
}

- (NSInteger)getShortestColumnBelow
{
    NSInteger retVal = 0;
    NSInteger tempInt = 10;
    NSInteger colCount = 0;
    for (NSString *key in [self.columnDict0 allKeys]) {
        if ([key integerValue] > 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 0;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict1 allKeys]) {
        if ([key integerValue] > 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 1;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict2 allKeys]) {
        if ([key integerValue] > 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 2;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict3 allKeys]) {
        if ([key integerValue] > 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 3;
    }
    colCount = 0;
    for (NSString *key in [self.columnDict4 allKeys]) {
        if ([key integerValue] > 0) {
            colCount++;
        }
    }
    if (colCount < tempInt) {
        tempInt = colCount;
        retVal = 4;
    }
    return retVal;
}

- (int)getShortColumn
{
    int defaultColumn = [self getRandomColumn];
    NSInteger lowCount = 100;
    switch (defaultColumn) {
        case 0:
            lowCount = [[self.columnDict0 allKeys] count];
            break;
        case 1:
            lowCount = [[self.columnDict1 allKeys] count];
            break;
        case 2:
            lowCount = [[self.columnDict2 allKeys] count];
            break;
        case 3:
            lowCount = [[self.columnDict3 allKeys] count];
            break;
        case 4:
            lowCount = [[self.columnDict4 allKeys] count];
            break;
        default:
            break;
    }
    if ([[self.columnDict0 allKeys] count] < lowCount) {
        lowCount = [[self.columnDict0 allKeys] count];
        defaultColumn = 0;
    }
    if ([[self.columnDict1 allKeys] count] < lowCount) {
        lowCount = [[self.columnDict1 allKeys] count];
        defaultColumn = 1;
    }
    if ([[self.columnDict2 allKeys] count] < lowCount) {
        lowCount = [[self.columnDict2 allKeys] count];
        defaultColumn = 2;
    }
    if ([[self.columnDict3 allKeys] count] < lowCount) {
        lowCount = [[self.columnDict3 allKeys] count];
        defaultColumn = 3;
    }
    if ([[self.columnDict4 allKeys] count] < lowCount) {
        lowCount = [[self.columnDict4 allKeys] count];
        defaultColumn = 4;
    }
    return defaultColumn;
}

- (NSInteger)marblesBelowForColumn:(NSMutableDictionary *) column
{
    NSInteger retVal = 0;
    for (NSString *key in [column allKeys]) {
        if ([key integerValue] > 0) {
            retVal++;
        }
    }
    return retVal;
}

- (NSInteger)marblesAboveForColumn:(NSMutableDictionary *) column
{
    NSInteger retVal = 0;
    for (NSString *key in [column allKeys]) {
        if ([key integerValue] < 0) {
            retVal++;
        }
    }
    return retVal;
}

- (void)addRandomMarbleToColumn:(NSInteger) column withKey:(NSInteger) key
{
    int marbleIdx = [self getRandomMarble];
    Marble *aMarble;
    if (key < 0) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            aMarble = [[Marble alloc] initWithFrame:CGRectMake((column * 80) + 200, 500 - (key * -80), 80, 80) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        }
        else {
            aMarble = [[Marble alloc] initWithFrame:CGRectMake((column * 40) + 60, 210 - (key * -40), 40, 40) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        }
    }
    else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            aMarble = [[Marble alloc] initWithFrame:CGRectMake((column * 80) + 200, 500 + (key * 80), 80, 80) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        }
        else {
            aMarble = [[Marble alloc] initWithFrame:CGRectMake((column * 40) + 60, 210 + (key * 40), 40, 40) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marbleIdx]]];
        }
    }
    aMarble.imageIdx = marbleIdx;
    aMarble.alpha = 0.6;
    [self.view addSubview:aMarble];
    switch (column) {
        case 0:
            [self.columnDict0 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", key]];
            break;
        case 1:
            [self.columnDict1 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", key]];
            break;
        case 2:
            [self.columnDict2 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", key]];
            break;
        case 3:
            [self.columnDict3 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", key]];
            break;
        case 4:
            [self.columnDict4 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", key]];
            break;
    }
}

- (NSInteger)countMarbles
{
    NSInteger retVal = [[self.columnDict0 allKeys] count];
    retVal += [[self.columnDict1 allKeys] count];
    retVal += [[self.columnDict2 allKeys] count];
    retVal += [[self.columnDict3 allKeys] count];
    retVal += [[self.columnDict4 allKeys] count];
    return retVal;
}

- (IBAction)showHighScores:(id) sender
{
    self.scoreTotal = -1;
    self.gameLevel = -1;
    HighScoresController *hs;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        hs = [[HighScoresController alloc] initWithNibName:@"HighScoresController_iPad" bundle:nil];
    }
    else {
        hs = [[HighScoresController alloc] initWithNibName:@"HighScoresController_iPhone" bundle:nil];
    }
    
    [hs setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];

    hs.highScores = self.highScores;
    [self presentViewController:hs animated:YES completion:NULL];
}

- (NSInteger)currentScore
{
    return self.scoreTotal;
}

- (BOOL)addHighScore
{
    BOOL scoreIsHigher = NO;
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithCapacity:1];
    NSInteger currentScore = [self currentScore];
    [newDict setObject:[NSString stringWithFormat:@"%d", currentScore] forKey:@"score"];
    [self.highScores setObject:newDict forKey:[NSString stringWithFormat:@"%d", [[self.highScores allKeys] count]]];
    for (int i=[[self.highScores allKeys] count] -1; i>-1; i--) {
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:[self.highScores objectForKey:[NSString stringWithFormat:@"%d", i]]];
        NSString *scoreStr = [tempDict objectForKey:@"score"];
        if (currentScore > [scoreStr integerValue]) {
            [self.highScores setObject:tempDict forKey:[NSString stringWithFormat:@"%d", i+1]];
            [self.highScores setObject:newDict forKey:[NSString stringWithFormat:@"%d", i]];
            scoreIsHigher = YES;
        }
    }
    if (self.highScores.count < 11) {
        scoreIsHigher = YES;
    }
    else {
        [self.highScores removeObjectForKey:@"10"];
    }
    return scoreIsHigher;
}

- (void)gameMaybeOver
{
    self.gameOverCnt++;
    if (self.gameOverCnt > 3) {
        [self.marbleTimer invalidate];
        [self.loopPlayer stop];
        [self.gameOverPlayer play];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"You scored %d!", [self currentScore]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        av.delegate = self;
        [av show];
    }
}

- (void)saveGame:(NSInteger) level andScore:(NSInteger) score
{
    self.savedGame = [NSMutableDictionary dictionaryWithCapacity:1];
    if (self.gridFull) {
        [self.savedGame setObject:[NSNumber numberWithInteger:-1] forKey:@"level"];
        [self.savedGame setObject:[NSNumber numberWithInteger:-1] forKey:@"score"];
    }
    else {
        [self.savedGame setObject:[NSNumber numberWithInteger:level] forKey:@"level"];
        [self.savedGame setObject:[NSNumber numberWithInteger:score] forKey:@"score"];
    }
    if (!self.gridFull) {
        if ([self.columnDict0 count] / 2 > 0) {
            [self.savedGame setObject:[NSNumber numberWithInteger:[self.columnDict0 count] / 2] forKey:@"col0"];
        }
        else {
            [self.savedGame setObject:[NSNumber numberWithInteger:1] forKey:@"col0"];
        }
        if ([self.columnDict1 count] / 2 > 0) {
            [self.savedGame setObject:[NSNumber numberWithInteger:[self.columnDict1 count] / 2] forKey:@"col1"];
        }
        else {
            [self.savedGame setObject:[NSNumber numberWithInteger:1] forKey:@"col1"];
        }
        if ([self.columnDict2 count] / 2 > 0) {
            [self.savedGame setObject:[NSNumber numberWithInteger:[self.columnDict2 count] / 2] forKey:@"col2"];
        }
        else {
            [self.savedGame setObject:[NSNumber numberWithInteger:1] forKey:@"col2"];
        }
        if ([self.columnDict3 count] / 2 > 0) {
            [self.savedGame setObject:[NSNumber numberWithInteger:[self.columnDict3 count] / 2] forKey:@"col3"];
        }
        else {
            [self.savedGame setObject:[NSNumber numberWithInteger:1] forKey:@"col3"];
        }
        if ([self.columnDict4 count] / 2 > 0) {
            [self.savedGame setObject:[NSNumber numberWithInteger:[self.columnDict4 count] / 2] forKey:@"col4"];
        }
        else {
            [self.savedGame setObject:[NSNumber numberWithInteger:1] forKey:@"col4"];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:self.savedGame] forKey:@"MarbleCrazeSavedGame"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateSavedGameNotification" object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex
{
    if (!self.gridFull) {
        if (buttonIndex == 0) {  // Continue.
            [self clearMarbles];
            [self setAddFaster:NO];
            [self setGameCount:0];
            [self performSelector:@selector(addMarble) withObject:nil afterDelay:3.0];
            return;
        }
        else {  //  Save
            [self saveGame:self.gameLevel andScore:self.scoreTotal];
            [self dismissViewControllerAnimated:NO completion:nil];
            return;
        }
    }
    else {
        if ([self addHighScore]) {
            [self showHighScores:self];
            return;
        }
        else {
            self.gameLevel = -1;
            self.scoreTotal = -1;
        }
    }
}

- (void)addMarbles
{
    NSInteger loCol;
    NSInteger hiCol;
    NSInteger hiColumnKey, loColumnKey;
    hiCol = [self getShortestColumnBelow];
    loCol = [self getShortestColumnAbove];
    switch (hiCol) {
        case 0:
            hiColumnKey = [self highestColumnKey:self.columnDict0] + 1;
            [self addRandomMarbleToColumn:0 withKey:hiColumnKey];
            break;
        case 1:
            hiColumnKey = [self highestColumnKey:self.columnDict1] + 1;
            [self addRandomMarbleToColumn:1 withKey:hiColumnKey];
            break;
        case 2:
            hiColumnKey = [self highestColumnKey:self.columnDict2] + 1;
            [self addRandomMarbleToColumn:2 withKey:hiColumnKey];
            break;
        case 3:
            hiColumnKey = [self highestColumnKey:self.columnDict3] + 1;
            [self addRandomMarbleToColumn:3 withKey:hiColumnKey];
            break;
        case 4:
            hiColumnKey = [self highestColumnKey:self.columnDict4] + 1;
            [self addRandomMarbleToColumn:4 withKey:hiColumnKey];
            break;
    }
    
    switch (loCol) {
        case 0:
            loColumnKey = [self lowestColumnKey:self.columnDict0] - 1;
            [self addRandomMarbleToColumn:0 withKey:loColumnKey];
            break;
        case 1:
            loColumnKey = [self lowestColumnKey:self.columnDict1] - 1;
            [self addRandomMarbleToColumn:1 withKey:loColumnKey];
            break;
        case 2:
            loColumnKey = [self lowestColumnKey:self.columnDict2] - 1;
            [self addRandomMarbleToColumn:2 withKey:loColumnKey];
            break;
        case 3:
            loColumnKey = [self lowestColumnKey:self.columnDict3] - 1;
            [self addRandomMarbleToColumn:3 withKey:loColumnKey];
            break;
        case 4:
            loColumnKey = [self lowestColumnKey:self.columnDict4] - 1;
            [self addRandomMarbleToColumn:4 withKey:loColumnKey];
            break;
    }
}

- (void)addMarble
{
    if (!self.hasSwiped && !self.betweenRounds && !self.isPaused && !self.gridFull) {
        int shortColumn = [self getShortColumn];
        NSInteger columnKey;
        NSInteger marblesAbove;
        NSInteger marblesBelow;
        
        if (self.addFaster) {
            [self addMarbles];
        }
        else {
            switch (shortColumn) {
                case 0:
                    marblesAbove = [self marblesAboveForColumn:self.columnDict0];
                    marblesBelow = [self marblesBelowForColumn:self.columnDict0];
                    
                    if ([self marblesBelowForColumn:self.columnDict0] < [self marblesAboveForColumn:self.columnDict0]) {
                        columnKey = [self highestColumnKey:self.columnDict0] + 1;
                    }
                    else {
                        columnKey = [self lowestColumnKey:self.columnDict0] - 1;
                    }
                    [self addRandomMarbleToColumn:0 withKey:columnKey];
                    break;
                case 1:
                    marblesAbove = [self marblesAboveForColumn:self.columnDict1];
                    marblesBelow = [self marblesBelowForColumn:self.columnDict1];
                    if ([self marblesBelowForColumn:self.columnDict1] < [self marblesAboveForColumn:self.columnDict1]) {
                        columnKey = [self highestColumnKey:self.columnDict1] + 1;
                    }
                    else {
                        columnKey = [self lowestColumnKey:self.columnDict1] - 1;
                    }
                    [self addRandomMarbleToColumn:1 withKey:columnKey];
                    break;
                case 2:
                    marblesAbove = [self marblesAboveForColumn:self.columnDict2];
                    marblesBelow = [self marblesBelowForColumn:self.columnDict2];
                    if ([self marblesBelowForColumn:self.columnDict2] < [self marblesAboveForColumn:self.columnDict2]) {
                        columnKey = [self highestColumnKey:self.columnDict2] + 1;
                    }
                    else {
                        columnKey = [self lowestColumnKey:self.columnDict2] - 1;
                    }
                    [self addRandomMarbleToColumn:2 withKey:columnKey];
                    break;
                case 3:
                    marblesAbove = [self marblesAboveForColumn:self.columnDict3];
                    marblesBelow = [self marblesBelowForColumn:self.columnDict3];
                    if ([self marblesBelowForColumn:self.columnDict3] < [self marblesAboveForColumn:self.columnDict3]) {
                        columnKey = [self highestColumnKey:self.columnDict3] + 1;
                    }
                    else {
                        columnKey = [self lowestColumnKey:self.columnDict3] - 1;
                    }
                    [self addRandomMarbleToColumn:3 withKey:columnKey];
                    break;
                case 4:
                    marblesAbove = [self marblesAboveForColumn:self.columnDict4];
                    marblesBelow = [self marblesBelowForColumn:self.columnDict4];
                    if ([self marblesBelowForColumn:self.columnDict4] < [self marblesAboveForColumn:self.columnDict4]) {
                        columnKey = [self highestColumnKey:self.columnDict4] + 1;
                    }
                    else {
                        columnKey = [self lowestColumnKey:self.columnDict4] - 1;
                    }
                    [self addRandomMarbleToColumn:4 withKey:columnKey];
                    break;
            }
        }
    }
    
    NSInteger marbleCount = [self countMarbles];
    
    if (marbleCount < 20) {
        [self setAddFaster:YES];
    }
    else if (marbleCount > 35) {
        [self setAddFaster:NO];
    }
    
    if (marbleCount > 49) {
        [self setGridFull:YES];
        self.marbleTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(gameMaybeOver) userInfo:nil repeats:YES];
    }
    
    if (!self.gridFull && !self.betweenRounds && !self.isPaused) {
        float gameMulti = self.gameLevel * 0.1;
        if (self.gameLevel > 15) {
            gameMulti = 1.5;
        }
        if (self.addFaster) {
            [self performSelector:@selector(addMarble) withObject:nil afterDelay:3.0 - gameMulti];
        }
        else {
            [self performSelector:@selector(addMarble) withObject:nil afterDelay:3.0 - gameMulti];
        }
    }
}

- (void)replaceMarbles
{
    NSInteger aboveCount;
    NSInteger belowCount;
    
    if (![[self.rowDict allKeys] containsObject:@"0"]) {
        aboveCount = [self marblesAboveForColumn:self.columnDict0];
        belowCount = [self marblesBelowForColumn:self.columnDict0];
        if (aboveCount >= belowCount) {
            [self moveColumnDown:0];
        }
        else {
            [self moveColumnUp:0];
        }
    }
    if (![[self.rowDict allKeys] containsObject:@"1"]) {
        aboveCount = [self marblesAboveForColumn:self.columnDict1];
        belowCount = [self marblesBelowForColumn:self.columnDict1];
        if (aboveCount >= belowCount) {
            [self moveColumnDown:1];
        }
        else {
            [self moveColumnUp:1];
        }
    }
    if (![[self.rowDict allKeys] containsObject:@"2"]) {
        aboveCount = [self marblesAboveForColumn:self.columnDict2];
        belowCount = [self marblesBelowForColumn:self.columnDict2];
        if (aboveCount >= belowCount) {
            [self moveColumnDown:2];
        }
        else {
            [self moveColumnUp:2];
        }
    }
    if (![[self.rowDict allKeys] containsObject:@"3"]) {
        aboveCount = [self marblesAboveForColumn:self.columnDict3];
        belowCount = [self marblesBelowForColumn:self.columnDict3];
        if (aboveCount >= belowCount) {
            [self moveColumnDown:3];
        }
        else {
            [self moveColumnUp:3];
        }
    }
    if (![[self.rowDict allKeys] containsObject:@"4"]) {
        aboveCount = [self marblesAboveForColumn:self.columnDict4];
        belowCount = [self marblesBelowForColumn:self.columnDict4];
        if (aboveCount >= belowCount) {
            [self moveColumnDown:4];
        }
        else {
            [self moveColumnUp:4];
        }
    }
    [self performSelector:@selector(checkAllMatchedMarbles) withObject:nil afterDelay:0.2];
}

- (void)revertMarble:(Marble *) marble
{
    [UIView animateWithDuration:0.2 animations:^{
        [marble setImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%d.png", marble.imageIdx]]];
    } completion:^(BOOL finished) {
        
        [marble performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
    }];
}

- (void)invertMarble:(Marble *) marble
{
    [UIView animateWithDuration:0.2 animations:^{
        [marble setImage:[UIImage imageNamed:[NSString stringWithFormat:@"marblea%di.png", marble.imageIdx]]];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(revertMarble:) withObject:marble afterDelay:0.2];
    }];
}

- (void)updateScoreLabel
{
    if (self.scoreTotal < 0) {
        self.scoreTotal = 0;
    }
    NSString *scoreStr = [NSString stringWithFormat:@"%d", self.scoreTotal];
    NSString *tempStr;
    switch ([scoreStr length]) {
        case 1:
            self.score3.text = scoreStr;
            break;
        case 2:
            self.score3.text = [scoreStr substringFromIndex:1];
            self.score2.text = [scoreStr substringToIndex:1];
            break;
        case 3:
            self.score3.text = [scoreStr substringFromIndex:2];
            self.score1.text = [scoreStr substringToIndex:1];
            tempStr = [scoreStr substringToIndex:2];
            self.score2.text = [tempStr substringFromIndex:1];
            break;
        case 4:
            self.score3.text = [scoreStr substringFromIndex:3];
            self.score0.text = [scoreStr substringToIndex:1];
            tempStr = [scoreStr substringFromIndex:1];
            self.score1.text = [tempStr substringToIndex:1];
            tempStr = [tempStr substringFromIndex:1];
            self.score2.text = [tempStr substringToIndex:1];
            break;
        default:
            break;
    }    
}

- (void)moveMarbleToCenter:(Marble *) marble
{
    [UIView animateWithDuration:2.0 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(400, 540);
        }
        else {
            marble.center = CGPointMake(160, 230);
        }
    } completion:^(BOOL completed){
        [marble removeFromSuperview];
    }];
}

- (void)clearMarbles
{
    for (NSString *key0 in [self.columnDict0 allKeys]) {
        Marble *aMarble = (Marble *)[self.columnDict0 objectForKey:key0];
        [self moveMarbleToCenter:aMarble];
    }
    for (NSString *key1 in [self.columnDict1 allKeys]) {
        Marble *bMarble = (Marble *)[self.columnDict1 objectForKey:key1];
        [self moveMarbleToCenter:bMarble];
    }
    for (NSString *key2 in [self.columnDict2 allKeys]) {
        Marble *cMarble = (Marble *)[self.columnDict2 objectForKey:key2];
        [self moveMarbleToCenter:cMarble];

    }
    for (NSString *key3 in [self.columnDict3 allKeys]) {
        Marble *dMarble = (Marble *)[self.columnDict3 objectForKey:key3];
        [self moveMarbleToCenter:dMarble];
    }
    for (NSString *key4 in [self.columnDict4 allKeys]) {
        Marble *eMarble = (Marble *)[self.columnDict4 objectForKey:key4];
        [self moveMarbleToCenter:eMarble];
    }
    for (NSString *rowKey in [self.rowDict allKeys]) {
        Marble *rowMarble = (Marble *)[self.rowDict objectForKey:rowKey];
        [self moveMarbleToCenter:rowMarble];
    }
    [self.columnDict0 performSelector:@selector(removeAllObjects) withObject:nil afterDelay:2.4];
    [self.columnDict1 performSelector:@selector(removeAllObjects) withObject:nil afterDelay:2.4];
    [self.columnDict2 performSelector:@selector(removeAllObjects) withObject:nil afterDelay:2.4];
    [self.columnDict3 performSelector:@selector(removeAllObjects) withObject:nil afterDelay:2.4];
    [self.columnDict4 performSelector:@selector(removeAllObjects) withObject:nil afterDelay:2.4];
    [self.rowDict performSelector:@selector(removeAllObjects) withObject:nil afterDelay:2.4];
    [self performSelector:@selector(populateMarbles) withObject:nil afterDelay:2.5];
}

- (void)removeMarblesFromStart:(NSInteger) idx ofLength:(NSInteger) length
{
    [self.firePlayer play];
    
    if (self.gridFull) {
        [self setGridFull:NO];
        [self performSelector:@selector(addMarble) withObject:nil afterDelay:3.0];
    }
    
    for (int i = idx;i < (idx + length);i++) {
        Marble *aMarble = (Marble *)[self.rowDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        [self invertMarble:aMarble];
        [self.rowDict removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
    }
    [self performSelector:@selector(replaceMarbles) withObject:nil afterDelay:0.5];
    self.scoreTotal += length;
    self.gameCount++;
    
    if (self.gameCount >= 50) {
        [self setGameCount:0];
        self.gameLevel++;
        [self.marbleTimer invalidate];
        [self setBetweenRounds:YES];
        [self.roundOverPlayer play];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Round Complete" message:[NSString stringWithFormat:@"You finished round %d! Click 'Continue' to play the next level or 'Save' to exit and save the game.", self.gameLevel] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Save", nil];
        av.delegate = self;
        [av show];
    }
    [self updateScoreLabel];
}

- (void)checkAllMatchedMarbles
{
    if ([self checkForMatchedMarblesFromStart:0 ofLength:5]) {
        [self removeMarblesFromStart:0 ofLength:5];
    }
    else if ([self checkForMatchedMarblesFromStart:0 ofLength:4]) {
        [self removeMarblesFromStart:0 ofLength:4];
    }
    else if ([self checkForMatchedMarblesFromStart:1 ofLength:4]) {
        [self removeMarblesFromStart:1 ofLength:4];
    }
    else if ([self checkForMatchedMarblesFromStart:0 ofLength:3]) {
        [self removeMarblesFromStart:0 ofLength:3];
    }
    else if ([self checkForMatchedMarblesFromStart:1 ofLength:3]) {
        [self removeMarblesFromStart:1 ofLength:3];
    }
    else if ([self checkForMatchedMarblesFromStart:2 ofLength:3]) {
        [self removeMarblesFromStart:2 ofLength:3];
    }
    else {
        [self setHasSwiped:NO];
    }
    if (self.gridFull) {
        self.marbleTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(gameMaybeOver) userInfo:nil repeats:YES];
    }
}

- (void)moveMarbleLeft:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x - 80, marble.center.y);
        }
        else {
            marble.center = CGPointMake(marble.center.x - 40, marble.center.y);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleRight:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x + 80, marble.center.y);
        }
        else {
            marble.center = CGPointMake(marble.center.x + 40, marble.center.y);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleLeftAndRight:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x - 20, marble.center.y);
        }
        else {
            marble.center = CGPointMake(marble.center.x - 10, marble.center.y);
        }
    } completion:^(BOOL completed){
        [self moveMarbleRightSlightly:marble];
    }];
}

- (void)moveMarbleRightAndLeft:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x + 20, marble.center.y);
        }
        else {
            marble.center = CGPointMake(marble.center.x + 10, marble.center.y);
        }
    } completion:^(BOOL completed){
        [self moveMarbleLeftSlightly:marble];
    }];
}

- (void)moveMarbleLeftSlightly:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x - 20, marble.center.y);
        }
        else {
            marble.center = CGPointMake(marble.center.x - 10, marble.center.y);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleRightSlightly:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x + 20, marble.center.y);
        }
        else {
            marble.center = CGPointMake(marble.center.x + 10, marble.center.y);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleUp:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x, marble.center.y - 80);
        }
        else {
            marble.center = CGPointMake(marble.center.x, marble.center.y - 40);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleDown:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x, marble.center.y + 80);
        }
        else {
            marble.center = CGPointMake(marble.center.x, marble.center.y + 40);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleUpAndDown:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x, marble.center.y - 20);
        }
        else {
            marble.center = CGPointMake(marble.center.x, marble.center.y - 10);
        }
    } completion:^(BOOL completed){
        [self moveMarbleDownSlightly:marble];
    }];
}

- (void)moveMarbleDownAndUp:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x, marble.center.y + 20);
        }
        else {
            marble.center = CGPointMake(marble.center.x, marble.center.y + 10);
        }
    } completion:^(BOOL completed){
        [self moveMarbleUpSlightly:marble];
    }];
}

- (void)moveMarbleUpSlightly:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x, marble.center.y - 20);
        }
        else {
            marble.center = CGPointMake(marble.center.x, marble.center.y - 10);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)moveMarbleDownSlightly:(Marble *) marble
{
    [UIView animateWithDuration:0.1 animations:^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            marble.center = CGPointMake(marble.center.x, marble.center.y + 20);
        }
        else {
            marble.center = CGPointMake(marble.center.x, marble.center.y + 10);
        }
    } completion:^(BOOL completed){
    }];
}

- (void)swipedLeft:(UISwipeGestureRecognizer *) swipe
{
    if (self.hasSwiped || self.betweenRounds || self.isPaused) {
        return;
    }
    [self setHasSwiped:YES];
    if (self.marbleTimer && [self.marbleTimer isValid]) {
        [self.marbleTimer invalidate];
    }
    CGPoint touchPt = [swipe locationInView:self.view];
    if (touchPt.y > 100 && touchPt.y < 760) {
        NSInteger rowIdx = [self lowestRowKey];
        if (rowIdx == -6) {
            for (int i = rowIdx;i < (rowIdx + 11);i++) {
                Marble *aMarble = (Marble *)[self.rowDict objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleLeftAndRight:aMarble];
                }
            }
            [self setHasSwiped:NO];
            return;
        }
        for (int i = rowIdx;i < (rowIdx + 11);i++) {
            Marble *aMarble = (Marble *)[self.rowDict objectForKey:[NSString stringWithFormat:@"%d", i]];
            if (aMarble) {
                [self moveMarbleLeft:aMarble];
                [self.rowDict setObject:aMarble forKey:[NSString stringWithFormat:@"%d", i - 1]];
            }
        }
        [self.rowDict removeObjectForKey:[NSString stringWithFormat:@"%d", (rowIdx + 10)]];
    }
    [self performSelector:@selector(checkAllMatchedMarbles) withObject:nil afterDelay:0.1];
}

- (void)swipedRight:(UISwipeGestureRecognizer *) swipe
{
    if (self.hasSwiped || self.betweenRounds || self.isPaused) {
        return;
    }
    [self setHasSwiped:YES];
    if (self.marbleTimer && [self.marbleTimer isValid]) {
       [self.marbleTimer invalidate];
    }
    
    CGPoint touchPt = [swipe locationInView:self.view];
    if (touchPt.y > 100 && touchPt.y < 760) {
        NSInteger rowIdx = [self highestRowKey];
        if (rowIdx == 10) {
            for (int i = rowIdx;i > (rowIdx - 11);i--) {
                Marble *aMarble = (Marble *)[self.rowDict objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleRightAndLeft:aMarble];
                }
            }
            [self setHasSwiped:NO];
            return;
        }
        for (int i = rowIdx;i > (rowIdx - 11);i--) {
            Marble *aMarble = (Marble *)[self.rowDict objectForKey:[NSString stringWithFormat:@"%d", i]];
            if (aMarble) {
                [self moveMarbleRight:aMarble];
                [self.rowDict setObject:aMarble forKey:[NSString stringWithFormat:@"%d", i + 1]];
            }
        }
        [self.rowDict removeObjectForKey:[NSString stringWithFormat:@"%d", (rowIdx - 10)]];
    }
    [self performSelector:@selector(checkAllMatchedMarbles) withObject:nil afterDelay:0.1];
}

- (void)swipedDown:(UISwipeGestureRecognizer *) swipe
{
    if (self.hasSwiped || self.betweenRounds || self.isPaused) {
        return;
    }
    [self setHasSwiped:YES];
    int colIdx = -1;
    CGPoint touchPt = [swipe locationInView:self.view];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (touchPt.x > 200 && touchPt.x < 280) {
            colIdx = 0;
        }
        else if (touchPt.x > 280 && touchPt.x < 360) {
            colIdx = 1;
        }
        else if (touchPt.x > 360 && touchPt.x < 440) {
            colIdx = 2;
        }
        else if (touchPt.x > 440 && touchPt.x < 520) {
            colIdx = 3;
        }
        else if (touchPt.x > 520 && touchPt.x < 600) {
            colIdx = 4;
        }
    }
    else {
        if (touchPt.x > 60 && touchPt.x < 100) {
            colIdx = 0;
        }
        else if (touchPt.x > 100 && touchPt.x < 140) {
            colIdx = 1;
        }
        else if (touchPt.x > 140 && touchPt.x < 180) {
            colIdx = 2;
        }
        else if (touchPt.x > 180 && touchPt.x < 220) {
            colIdx = 3;
        }
        else if (touchPt.x > 220 && touchPt.x < 260) {
            colIdx = 4;
        }
    }
    
    if (colIdx >= 0) {
        NSInteger loIdx = 0;
        NSInteger hiIdx = 0;
        if (colIdx == 0) {
            loIdx = [self lowestColumnKey:self.columnDict0];
            hiIdx = [self highestColumnKey:self.columnDict0];
            // Don't move anything without at least 1 marble above the center row...
            if (loIdx > -1) {
                [self setHasSwiped:NO];
                return;
            }
            if (hiIdx > 4) {
                for (NSString *aKey in [self.columnDict0 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict0 objectForKey:aKey];
                    [self moveMarbleDownAndUp:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"0"];
                [self moveMarbleDownAndUp:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            //  Move marbles below the center row down...
            for (int i = hiIdx; i > 0; i--) {
                Marble *aMarble = (Marble *)[self.columnDict0 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleDown:aMarble];
                    [self.columnDict0 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict0 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            //  Move the marble in the center row down...
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"0"];
            if (bMarble != nil) {
                [self moveMarbleDown:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict0 setObject:bMarble forKey:@"1"];
            }
            //  Move the marble above the center row into the center row...
            if ([[self.columnDict0 allKeys] containsObject:@"-1"]) {
                Marble *cMarble = (Marble *)[self.columnDict0 objectForKey:@"-1"];
                if (cMarble) {
                    [self moveMarbleDown:cMarble];
                    cMarble.alpha = 1.0;
                    [self.rowDict removeObjectForKey:@"0"];
                    [self.rowDict setObject:cMarble forKey:@"0"];
                    [self.columnDict0 removeObjectForKey:@"-1"];
                }
            }
            //  Move additional marbles above the center row down...
            for (int j = -2; j > (loIdx - 1); j--) {
                Marble *dMarble = (Marble *)[self.columnDict0 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleDown:dMarble];
                    [self.columnDict0 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j + 1)]];
                    [self.columnDict0 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 1) {
            loIdx = [self lowestColumnKey:self.columnDict1];
            hiIdx = [self highestColumnKey:self.columnDict1];
            // Don't move anything without at least 1 marble above the center row...
            if (loIdx > -1) {
                [self setHasSwiped:NO];
                return;
            }
            if (hiIdx > 4) {
                for (NSString *aKey in [self.columnDict1 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict1 objectForKey:aKey];
                    [self moveMarbleDownAndUp:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"1"];
                [self moveMarbleDownAndUp:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            //  Move marbles below the center row down...
            for (int i = hiIdx; i > 0; i--) {
                Marble *aMarble = (Marble *)[self.columnDict1 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleDown:aMarble];
                    [self.columnDict1 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict1 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            //  Move the marble in the center row down...
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"1"];
            if (bMarble != nil) {
                [self moveMarbleDown:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict1 setObject:bMarble forKey:@"1"];
            }
            
            //  Move the marble above the center row into the center row...
            if ([[self.columnDict1 allKeys] containsObject:@"-1"]) {
                Marble *cMarble = (Marble *)[self.columnDict1 objectForKey:@"-1"];
                if (cMarble) {
                    [self moveMarbleDown:cMarble];
                    cMarble.alpha = 1.0;
                    [self.rowDict removeObjectForKey:@"1"];
                    [self.rowDict setObject:cMarble forKey:@"1"];
                    [self.columnDict1 removeObjectForKey:@"-1"];
                }
            }
            
            //  Move additional marbles above the center row down...
            for (int j = -2; j > (loIdx - 1); j--) {
                Marble *dMarble = (Marble *)[self.columnDict1 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleDown:dMarble];
                    [self.columnDict1 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j + 1)]];
                    [self.columnDict1 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 2) {
            loIdx = [self lowestColumnKey:self.columnDict2];
            hiIdx = [self highestColumnKey:self.columnDict2];
            // Don't move anything without at least 1 marble above the center row...
            if (loIdx > -1) {
                [self setHasSwiped:NO];
                return;
            }
            if (hiIdx > 4) {
                for (NSString *aKey in [self.columnDict2 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict2 objectForKey:aKey];
                    [self moveMarbleDownAndUp:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"2"];
                [self moveMarbleDownAndUp:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            //  Move marbles below the center row down...
            for (int i = hiIdx; i > 0; i--) {
                Marble *aMarble = (Marble *)[self.columnDict2 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleDown:aMarble];
                    [self.columnDict2 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict2 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            //  Move the marble in the center row down...
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"2"];
            if (bMarble != nil) {
                [self moveMarbleDown:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict2 setObject:bMarble forKey:@"1"];
            }
            
            //  Move the marble above the center row into the center row...
            if ([[self.columnDict2 allKeys] containsObject:@"-1"]) {
                Marble *cMarble = (Marble *)[self.columnDict2 objectForKey:@"-1"];
                if (cMarble) {
                    [self moveMarbleDown:cMarble];
                    cMarble.alpha = 1.0;
                    [self.rowDict removeObjectForKey:@"2"];
                    [self.rowDict setObject:cMarble forKey:@"2"];
                    [self.columnDict2 removeObjectForKey:@"-1"];
                }
            }
            
            //  Move additional marbles above the center row down...
            for (int j = -2; j > (loIdx - 1); j--) {
                Marble *dMarble = (Marble *)[self.columnDict2 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleDown:dMarble];
                    [self.columnDict2 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j + 1)]];
                    [self.columnDict2 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 3) {
            loIdx = [self lowestColumnKey:self.columnDict3];
            hiIdx = [self highestColumnKey:self.columnDict3];
            // Don't move anything without at least 1 marble above the center row...
            if (loIdx > -1) {
                [self setHasSwiped:NO];
                return;
            }
            if (hiIdx > 4) {
                for (NSString *aKey in [self.columnDict3 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict3 objectForKey:aKey];
                    [self moveMarbleDownAndUp:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"3"];
                [self moveMarbleDownAndUp:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            //  Move marbles below the center row down...
            for (int i = hiIdx; i > 0; i--) {
                Marble *aMarble = (Marble *)[self.columnDict3 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleDown:aMarble];
                    [self.columnDict3 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict3 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            //  Move the marble in the center row down...
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"3"];
            if (bMarble != nil) {
                [self moveMarbleDown:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict3 setObject:bMarble forKey:@"1"];
            }
            
            //  Move the marble above the center row into the center row...
            if ([[self.columnDict3 allKeys] containsObject:@"-1"]) {
                Marble *cMarble = (Marble *)[self.columnDict3 objectForKey:@"-1"];
                if (cMarble) {
                    [self moveMarbleDown:cMarble];
                    cMarble.alpha = 1.0;
                    [self.rowDict removeObjectForKey:@"3"];
                    [self.rowDict setObject:cMarble forKey:@"3"];
                    [self.columnDict3 removeObjectForKey:@"-1"];
                }
            }
            
            //  Move additional marbles above the center row down...
            for (int j = -2; j > (loIdx - 1); j--) {
                Marble *dMarble = (Marble *)[self.columnDict3 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleDown:dMarble];
                    [self.columnDict3 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j + 1)]];
                    [self.columnDict3 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 4) {
            loIdx = [self lowestColumnKey:self.columnDict4];
            hiIdx = [self highestColumnKey:self.columnDict4];
            // Don't move anything without at least 1 marble above the center row...
            if (loIdx > -1) {
                [self setHasSwiped:NO];
                return;
            }
            if (hiIdx > 4) {
                for (NSString *aKey in [self.columnDict4 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict4 objectForKey:aKey];
                    [self moveMarbleDownAndUp:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"4"];
                [self moveMarbleDownAndUp:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            //  Move marbles below the center row down...
            for (int i = hiIdx; i > 0; i--) {
                Marble *aMarble = (Marble *)[self.columnDict4 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleDown:aMarble];
                    [self.columnDict4 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i + 1)]];
                    [self.columnDict4 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            //  Move the marble in the center row down...
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"4"];
            if (bMarble != nil) {
                [self moveMarbleDown:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict4 setObject:bMarble forKey:@"1"];
            }
            
            //  Move the marble above the center row into the center row...
            if ([[self.columnDict4 allKeys] containsObject:@"-1"]) {
                Marble *cMarble = (Marble *)[self.columnDict4 objectForKey:@"-1"];
                if (cMarble) {
                    [self moveMarbleDown:cMarble];
                    cMarble.alpha = 1.0;
                    [self.rowDict removeObjectForKey:@"4"];
                    [self.rowDict setObject:cMarble forKey:@"4"];
                    [self.columnDict4 removeObjectForKey:@"-1"];
                }
            }
            
            //  Move additional marbles above the center row down...
            for (int j = -2; j > (loIdx - 1); j--) {
                Marble *dMarble = (Marble *)[self.columnDict4 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleDown:dMarble];
                    [self.columnDict4 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j + 1)]];
                    [self.columnDict4 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
    }
    [self performSelector:@selector(checkAllMatchedMarbles) withObject:nil afterDelay:0.1];
}

- (void)swipedUp:(UISwipeGestureRecognizer *) swipe
{
    if (self.hasSwiped || self.betweenRounds || self.isPaused) {
        return;
    }
    [self setHasSwiped:YES];
    int colIdx = -1;
    CGPoint touchPt = [swipe locationInView:self.view];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (touchPt.x > 200 && touchPt.x < 280) {
            colIdx = 0;
        }
        else if (touchPt.x > 280 && touchPt.x < 360) {
            colIdx = 1;
        }
        else if (touchPt.x > 360 && touchPt.x < 440) {
            colIdx = 2;
        }
        else if (touchPt.x > 440 && touchPt.x < 520) {
            colIdx = 3;
        }
        else if (touchPt.x > 520 && touchPt.x < 600) {
            colIdx = 4;
        }
    }
    else {
        if (touchPt.x > 60 && touchPt.x < 100) {
            colIdx = 0;
        }
        else if (touchPt.x > 100 && touchPt.x < 140) {
            colIdx = 1;
        }
        else if (touchPt.x > 140 && touchPt.x < 180) {
            colIdx = 2;
        }
        else if (touchPt.x > 180 && touchPt.x < 220) {
            colIdx = 3;
        }
        else if (touchPt.x > 220 && touchPt.x < 260) {
            colIdx = 4;
        }
    }
    
    if (colIdx >= 0) {
        NSInteger loIdx = 0;
        NSInteger hiIdx = 0;
        if (colIdx == 0) {
            loIdx = [self lowestColumnKey:self.columnDict0];
            hiIdx = [self highestColumnKey:self.columnDict0];
            if (hiIdx < 1) {
                [self setHasSwiped:NO];
                return;
            }
            if (loIdx < -4) {
                for (NSString *aKey in [self.columnDict0 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict0 objectForKey:aKey];
                    [self moveMarbleUpAndDown:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"0"];
                [self moveMarbleUpAndDown:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            for (int i = loIdx; i < 0; i++) {
                Marble *aMarble = (Marble *)[self.columnDict0 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleUp:aMarble];
                    [self.columnDict0 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict0 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"0"];
            if (bMarble) {
                [self moveMarbleUp:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict0 setObject:bMarble forKey:@"-1"];
            }
            
            Marble *cMarble = (Marble *)[self.columnDict0 objectForKey:@"1"];
            if (cMarble) {
                [self moveMarbleUp:cMarble];
                cMarble.alpha = 1.0;
                [self.rowDict removeObjectForKey:@"0"];
                [self.rowDict setObject:cMarble forKey:@"0"];
                [self.columnDict0 removeObjectForKey:@"1"];
            }
            
            for (int j = 2; j < (hiIdx + 1); j++) {
                Marble *dMarble = (Marble *)[self.columnDict0 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleUp:dMarble];
                    [self.columnDict0 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j - 1)]];
                    [self.columnDict0 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 1) {
            loIdx = [self lowestColumnKey:self.columnDict1];
            hiIdx = [self highestColumnKey:self.columnDict1];
            if (hiIdx < 1) {
                [self setHasSwiped:NO];
                return;
            }
            if (loIdx < -4) {
                for (NSString *aKey in [self.columnDict1 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict1 objectForKey:aKey];
                    [self moveMarbleUpAndDown:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"1"];
                [self moveMarbleUpAndDown:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            for (int i = loIdx; i < 0; i++) {
                Marble *aMarble = (Marble *)[self.columnDict1 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleUp:aMarble];
                    [self.columnDict1 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict1 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"1"];
            [self moveMarbleUp:bMarble];
            bMarble.alpha = 0.6;
            [self.columnDict1 setObject:bMarble forKey:@"-1"];
            
            Marble *cMarble = (Marble *)[self.columnDict1 objectForKey:@"1"];
            [self moveMarbleUp:cMarble];
            cMarble.alpha = 1.0;
            [self.rowDict removeObjectForKey:@"1"];
            [self.rowDict setObject:cMarble forKey:@"1"];
            [self.columnDict1 removeObjectForKey:@"1"];
            
            for (int j = 2; j < (hiIdx + 1); j++) {
                Marble *dMarble = (Marble *)[self.columnDict1 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleUp:dMarble];
                    [self.columnDict1 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j - 1)]];
                    [self.columnDict1 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 2) {
            loIdx = [self lowestColumnKey:self.columnDict2];
            hiIdx = [self highestColumnKey:self.columnDict2];
            if (hiIdx < 1) {
                [self setHasSwiped:NO];
                return;
            }
            if (loIdx < -4) {
                for (NSString *aKey in [self.columnDict2 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict2 objectForKey:aKey];
                    [self moveMarbleUpAndDown:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"2"];
                [self moveMarbleUpAndDown:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            for (int i = loIdx; i < 0; i++) {
                Marble *aMarble = (Marble *)[self.columnDict2 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleUp:aMarble];
                    [self.columnDict2 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict2 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            //  Move the marble in middle row up...
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"2"];
            if (bMarble) {
                [self moveMarbleUp:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict2 setObject:bMarble forKey:@"-1"];
            }
            
            Marble *cMarble = (Marble *)[self.columnDict2 objectForKey:@"1"];
            if (cMarble) {
                [self moveMarbleUp:cMarble];
                cMarble.alpha = 1.0;
                [self.rowDict removeObjectForKey:@"2"];
                [self.rowDict setObject:cMarble forKey:@"2"];
                [self.columnDict2 removeObjectForKey:@"1"];
            }
            
            for (int j = 2; j < (hiIdx + 1); j++) {
                Marble *dMarble = (Marble *)[self.columnDict2 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleUp:dMarble];
                    [self.columnDict2 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j - 1)]];
                    [self.columnDict2 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 3) {
            loIdx = [self lowestColumnKey:self.columnDict3];
            hiIdx = [self highestColumnKey:self.columnDict3];
            if (hiIdx < 1) {
                [self setHasSwiped:NO];
                return;
            }
            if (loIdx < -4) {
                for (NSString *aKey in [self.columnDict3 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict3 objectForKey:aKey];
                    [self moveMarbleUpAndDown:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"3"];
                [self moveMarbleUpAndDown:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            for (int i = loIdx; i < 0; i++) {
                Marble *aMarble = (Marble *)[self.columnDict3 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleUp:aMarble];
                    [self.columnDict3 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict3 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"3"];
            if (bMarble) {
                [self moveMarbleUp:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict3 setObject:bMarble forKey:@"-1"];
            }
            
            Marble *cMarble = (Marble *)[self.columnDict3 objectForKey:@"1"];
            if (cMarble) {
                [self moveMarbleUp:cMarble];
                cMarble.alpha = 1.0;
                [self.rowDict removeObjectForKey:@"3"];
                [self.rowDict setObject:cMarble forKey:@"3"];
                [self.columnDict3 removeObjectForKey:@"1"];
            }
            
            for (int j = 2; j < (hiIdx + 1); j++) {
                Marble *dMarble = (Marble *)[self.columnDict3 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleUp:dMarble];
                    [self.columnDict3 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j - 1)]];
                    [self.columnDict3 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
        else if (colIdx == 4) {
            loIdx = [self lowestColumnKey:self.columnDict4];
            hiIdx = [self highestColumnKey:self.columnDict4];
            if (hiIdx < 1) {
                [self setHasSwiped:NO];
                return;
            }
            if (loIdx < -4) {
                for (NSString *aKey in [self.columnDict4 allKeys]) {
                    Marble *aMarble = (Marble *)[self.columnDict4 objectForKey:aKey];
                    [self moveMarbleUpAndDown:aMarble];
                }
                Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"4"];
                [self moveMarbleUpAndDown:bMarble];
                [self setHasSwiped:NO];
                return;
            }
            for (int i = loIdx; i < 0; i++) {
                Marble *aMarble = (Marble *)[self.columnDict4 objectForKey:[NSString stringWithFormat:@"%d", i]];
                if (aMarble) {
                    [self moveMarbleUp:aMarble];
                    [self.columnDict4 setObject:aMarble forKey:[NSString stringWithFormat:@"%d", (i - 1)]];
                    [self.columnDict4 removeObjectForKey:[NSString stringWithFormat:@"%d", i]];
                }
            }
            Marble *bMarble = (Marble *)[self.rowDict objectForKey:@"4"];
            if (bMarble) {
                [self moveMarbleUp:bMarble];
                bMarble.alpha = 0.6;
                [self.columnDict4 setObject:bMarble forKey:@"-1"];
            }
            
            Marble *cMarble = (Marble *)[self.columnDict4 objectForKey:@"1"];
            if (cMarble) {
                [self moveMarbleUp:cMarble];
                cMarble.alpha = 1.0;
                [self.rowDict removeObjectForKey:@"4"];
                [self.rowDict setObject:cMarble forKey:@"4"];
                [self.columnDict4 removeObjectForKey:@"1"];
            }
            
            for (int j = 2; j < (hiIdx + 1); j++) {
                Marble *dMarble = (Marble *)[self.columnDict4 objectForKey:[NSString stringWithFormat:@"%d", j]];
                if (dMarble) {
                    [self moveMarbleUp:dMarble];
                    [self.columnDict4 setObject:dMarble forKey:[NSString stringWithFormat:@"%d", (j - 1)]];
                    [self.columnDict4 removeObjectForKey:[NSString stringWithFormat:@"%d", j]];
                }
            }
        }
    }
    [self performSelector:@selector(checkAllMatchedMarbles) withObject:nil afterDelay:0.1];
}

- (IBAction)back:(id)sender
{
    [self saveGame:self.gameLevel andScore:self.scoreTotal];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)pause:(id)sender
{
    if (self.isPaused) {
        [self setIsPaused:NO];
        [self.loopPlayer play];
        [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self performSelector:@selector(addMarble) withObject:nil afterDelay:3.0];
        return;
    }
    [self setIsPaused:YES];
    [self.loopPlayer pause];
    [self.pauseButton setTitle:@"Play" forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
