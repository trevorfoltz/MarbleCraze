//
//  GameController.m
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "GameController.h"
#import "MarbleController.h"
#import "AboutController.h"
#import "HighScoresController.h"

@interface GameController ()

@end

@implementation GameController

@synthesize starToggle, stars, starIdx, highScores;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)aboutGame:(id)sender
{
    AboutController *ab;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        ab = [[AboutController alloc] initWithNibName:@"AboutController_iPad" bundle:nil];
    }
    else {
        ab = [[AboutController alloc] initWithNibName:@"AboutController_iPhone" bundle:nil];
    }
    [self presentViewController:ab animated:NO completion:nil];
}

- (IBAction)newGame:(id)sender
{
    MarbleController *mb;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        mb = [[MarbleController alloc] initWithNibName:@"MarbleController_iPad" bundle:nil];
    }
    else {
        mb = [[MarbleController alloc] initWithNibName:@"MarbleController_iPhone" bundle:nil];
    }
    [self presentViewController:mb animated:NO completion:nil];
    [mb setHighScores:self.highScores];
}

- (IBAction)showHighScores:(id) sender
{
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


- (int)getRandomX
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return arc4random() %(650);
    }
	return arc4random() %(280);
}

- (int)getRandomY
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return arc4random() %(1000);
    }
	return arc4random() %(360);
}

- (int)getStarIndex
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return arc4random() %(200);
    }
    return arc4random() %(100);
    
}

- (void)twinkleStarOff:(UIView *) star
{
    [UIView animateWithDuration:0.2 animations:^{
        [star setAlpha:0.7];
    } completion:^(BOOL completed){
    }];
}

- (void)twinkleStarBright:(UIView *) star
{
    
    [UIView animateWithDuration:0.2 animations:^{
        [star setAlpha:1.0];
    } completion:^(BOOL completed){
        [self performSelector:@selector(twinkleStarOff:) withObject:star afterDelay:0.4];
        [self performSelector:@selector(twinkleStarDim) withObject:nil afterDelay:0.4];
    }];
}

- (void)twinkleStarDim
{
    if (self.starIdx == 0) {
        [self setStarIdx:[self.stars count] - 1];
    }
    UIView *star = (UIView *) [self.stars objectAtIndex:self.starIdx];
    self.starIdx--;
    [UIView animateWithDuration:0.1 animations:^{
        [star setAlpha:0.3];
    } completion:^(BOOL completed){
        [self twinkleStarBright:star];
        
    }];
}

- (BOOL)starTooClose:(CGPoint) origin
{
    for (UIView *star in self.stars) {
        CGFloat starX = star.frame.origin.x;
        CGFloat starY = star.frame.origin.y;
        
        CGFloat diffX = origin.x - starX;
        if (diffX < 0) {
            diffX *= -1;
        }
        CGFloat diffY = origin.y - starY;
        if (diffY < 0) {
            diffY *= -1;
        }
        if (diffX < 20 && diffY < 20) {
            return YES;
        }
    }
    return NO;
}

-(CGPoint)newStarLocation
{
    int xVal = [self getRandomX];
    xVal += 20;
    int yVal = [self getRandomY];
    yVal += 60;
    
    CGFloat x = (CGFloat) xVal;
    CGFloat y = (CGFloat) yVal;
    while ([self starTooClose:CGPointMake(x, y)]) {
        xVal = [self getRandomX];
        xVal += 20;
        yVal = [self getRandomY];
        yVal += 60;
        
        x = (CGFloat) xVal;
        y = (CGFloat) yVal;
    }
    return CGPointMake(x, y);
}

- (void)scatterStars
{
    self.stars = [NSMutableArray arrayWithCapacity:50];
    int j = 100;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        j = 200;
    }
    for (int i = 0; i < j;i++) {
        CGPoint origin = [self newStarLocation];
        CGFloat size = 3.0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            size = 5.0;
        }
        if (!self.starToggle) {
            size = 2.0;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                size = 3.0;
            }
            [self setStarToggle:YES];
        }
        else {
            [self setStarToggle:NO];
        }
        __block UIView *star = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, size, size)];
        star.backgroundColor = [UIColor whiteColor];
        star.alpha = 0.7;
        [self.view addSubview:star];
        [self.stars addObject:star];
    }
    [self setStarIdx:[self.stars count] - 1];
    [self twinkleStarDim];
}


- (void)updateHighScores
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.highScores = [NSMutableDictionary dictionaryWithDictionary:[defaults dictionaryForKey:@"MarbleCrazeHighScores"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self scatterStars];
    [self updateHighScores];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHighScores) name:@"UpdateHighScoresNotification" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
