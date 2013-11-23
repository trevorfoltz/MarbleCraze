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

@synthesize highScores, savedGame, twinkler;

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

- (void)showMarbleController
{
    MarbleController *mb;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        mb = [[MarbleController alloc] initWithNibName:@"MarbleController_iPad" bundle:nil];
    }
    else {
        mb = [[MarbleController alloc] initWithNibName:@"MarbleController_iPhone" bundle:nil];
    }
    [mb setHighScores:self.highScores];
    [mb setSavedGame:self.savedGame];
    
    [self presentViewController:mb animated:NO completion:nil];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex
{
    if (buttonIndex > 0) {
        [self.savedGame setObject:[NSNumber numberWithInteger:0] forKey:@"level"];
        [self.savedGame setObject:[NSNumber numberWithInteger:0] forKey:@"score"];
        [self.savedGame removeObjectForKey:@"col0"];
        [self.savedGame removeObjectForKey:@"col1"];
        [self.savedGame removeObjectForKey:@"col2"];
        [self.savedGame removeObjectForKey:@"col3"];
        [self.savedGame removeObjectForKey:@"col4"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:self.savedGame] forKey:@"MarbleCrazeSavedGame"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self showMarbleController];
}

- (IBAction)newGame:(id)sender
{
    if ([[self.savedGame allKeys] count] > 0) {
        NSInteger level = [[self.savedGame objectForKey:@"level"] integerValue];
        if (level >= 0) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Play Marble Craze" message:@"Continue saved game or start a new game?" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"New Game", nil];
            [av show];
            return;
        }
        else {
            [self showMarbleController];
        }
    }
    else {
        [self showMarbleController];
    }
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


- (void)updateHighScores
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.highScores = [NSMutableDictionary dictionaryWithDictionary:[defaults dictionaryForKey:@"MarbleCrazeHighScores"]];
}

- (void)updateSavedGame
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.savedGame = [NSMutableDictionary dictionaryWithDictionary:[defaults dictionaryForKey:@"MarbleCrazeSavedGame"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.twinkler = [StarTwinkler initWithParentView:self.view];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self updateSavedGame];
    [self updateHighScores];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHighScores) name:@"UpdateHighScoresNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSavedGame) name:@"UpdateSavedGameNotification" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
