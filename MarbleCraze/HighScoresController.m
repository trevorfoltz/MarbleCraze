//
//  HighScoresController.m
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "HighScoresController.h"
#import "StarTwinkler.h"

@interface HighScoresController ()

@end

@implementation HighScoresController

@synthesize highScores, newHighScore, justViewing, txtPlayer, touchCount, shiftView;
@synthesize score2Edit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)saveHighScore:(NSString *) player
{
    for (int i = 0; i < [[self.highScores allKeys] count]; i++) {
        NSMutableDictionary *tempDict = [self.highScores objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSString *name = [tempDict objectForKey:@"name"];
        if (name.length == 0) {
            [tempDict setObject:player forKey:@"name"];
            [self.highScores setObject:tempDict forKey:[NSString stringWithFormat:@"%d", i]];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:self.highScores] forKey:@"MarbleCrazeHighScores"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateHighScoresNotification" object:self userInfo:nil];
            return;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touchCount > 0 || self.justViewing) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        self.touchCount++;
        [self.txtPlayer resignFirstResponder];
        [self becomeFirstResponder];
    }
}

- (void)setupIpad
{
    UIView *separator1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 768, 10)];
    separator1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:separator1];
    UIView *separator2 = [[UIView alloc] initWithFrame:CGRectMake(0, 103, 768, 7)];
    separator2.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:separator2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 850, 370, 60)];
    label3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:18];
    label3.backgroundColor = [UIColor clearColor];
    label3.textColor = [UIColor whiteColor];
    label3.numberOfLines = 1;
    label3.text = @"Tap anywhere to return to the game.";
    [self.view addSubview:label3];
    
    if (self.highScores == nil || [[self.highScores allKeys] count] == 0) {
        return;
    }
    
    self.shiftView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 768, 800)];
    [self.view addSubview:self.shiftView];
    
    for (int i = 0; i < [[self.highScores allKeys] count]; i++) {
        NSDictionary *tempDict = (NSDictionary *) [self.highScores objectForKey:[NSString stringWithFormat:@"%d", i]];
        UILabel *lblPos = [[UILabel alloc] initWithFrame:CGRectMake(70, 60+(i*60), 70, 50)];
        lblPos.backgroundColor = [UIColor clearColor];
        lblPos.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        lblPos.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
        lblPos.shadowOffset = CGSizeMake(1, 1);
        lblPos.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:44];
        lblPos.textAlignment = NSTextAlignmentRight;
        lblPos.text = [NSString stringWithFormat:@"%d", i+1];
        [self.shiftView addSubview:lblPos];
        NSString *player = [tempDict objectForKey:@"name"];
        if (player.length == 0) {
            self.score2Edit = i;
            self.txtPlayer = [[UITextField alloc] initWithFrame:CGRectMake(160, 60+(i*60), 320, 50)];
            self.txtPlayer.delegate = self;
            self.txtPlayer.backgroundColor = [UIColor clearColor];
            self.txtPlayer.textColor = [UIColor lightGrayColor];
            self.txtPlayer.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:44];
            [self.shiftView addSubview:self.txtPlayer];
            [self.txtPlayer becomeFirstResponder];
            self.justViewing = NO;
        }
        else {
            UILabel *lblPlayer = [[UILabel alloc] initWithFrame:CGRectMake(160, 60+(i*60), 320, 50)];
            lblPlayer.backgroundColor = [UIColor clearColor];
            lblPlayer.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            lblPlayer.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
            lblPlayer.shadowOffset = CGSizeMake(1, 1);
            lblPlayer.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:44];
            lblPlayer.text = [tempDict objectForKey:@"name"];
            [self.shiftView addSubview:lblPlayer];
        }
        
        UILabel *lblScore = [[UILabel alloc] initWithFrame:CGRectMake(490, 60+(i*60), 140, 50)];
        lblScore.backgroundColor = [UIColor clearColor];
        lblScore.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        lblScore.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
        lblScore.shadowOffset = CGSizeMake(1, 1);
        lblScore.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:44];
        lblScore.textAlignment = NSTextAlignmentRight;
        lblScore.text = [tempDict objectForKey:@"score"];
        [self.shiftView addSubview:lblScore];
    }
    
    if (self.score2Edit > 5) {
        self.shiftView.center = CGPointMake(self.shiftView.center.x, self.shiftView.center.y - 280);
    }
}

- (void)setupIphone
{
    UIView *separator1 = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 5)];
    separator1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:separator1];
    UIView *separator2 = [[UIView alloc] initWithFrame:CGRectMake(0, 61, 320, 4)];
    separator2.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:separator2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 430, 270, 20)];
    label3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:14];
    label3.backgroundColor = [UIColor clearColor];
    label3.textColor = [UIColor whiteColor];
    label3.numberOfLines = 1;
    label3.text = @"Tap anywhere to return to the game.";
    [self.view addSubview:label3];
    
    if (self.highScores == nil || [[self.highScores allKeys] count] == 0) {
        return;
    }
    self.shiftView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 400)];
    [self.view addSubview:self.shiftView];
    
    for (int i = 0; i < [[self.highScores allKeys] count]; i++) {
        NSDictionary *tempDict = (NSDictionary *) [self.highScores objectForKey:[NSString stringWithFormat:@"%d", i]];
        UILabel *lblPos = [[UILabel alloc] initWithFrame:CGRectMake(25, 30+(i*30), 35, 25)];
        lblPos.backgroundColor = [UIColor clearColor];
        lblPos.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        lblPos.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
        lblPos.shadowOffset = CGSizeMake(1, 1);
        lblPos.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:22];
        lblPos.textAlignment = NSTextAlignmentRight;
        lblPos.text = [NSString stringWithFormat:@"%d", i+1];
        [self.shiftView addSubview:lblPos];
        NSString *player = [tempDict objectForKey:@"name"];
        if (player.length == 0) {
            self.score2Edit = i;
            self.txtPlayer = [[UITextField alloc] initWithFrame:CGRectMake(70, 30+(i*30), 160, 25)];
            self.txtPlayer.delegate = self;
            self.txtPlayer.backgroundColor = [UIColor clearColor];
            self.txtPlayer.textColor = [UIColor lightGrayColor];
            self.txtPlayer.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:22];
            [self.shiftView addSubview:self.txtPlayer];
            [self.txtPlayer becomeFirstResponder];
            self.justViewing = NO;
        }
        else {
            UILabel *lblPlayer = [[UILabel alloc] initWithFrame:CGRectMake(70, 30+(i*30), 160, 25)];
            lblPlayer.backgroundColor = [UIColor clearColor];
            lblPlayer.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            lblPlayer.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
            lblPlayer.shadowOffset = CGSizeMake(1, 1);
            lblPlayer.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:22];
            lblPlayer.text = [tempDict objectForKey:@"name"];
            [self.shiftView addSubview:lblPlayer];
        }
        
        UILabel *lblScore = [[UILabel alloc] initWithFrame:CGRectMake(230, 30+(i*30), 60, 25)];
        lblScore.backgroundColor = [UIColor clearColor];
        lblScore.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        lblScore.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
        lblScore.shadowOffset = CGSizeMake(1, 1);
        lblScore.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:22];
        lblScore.textAlignment = NSTextAlignmentRight;
        lblScore.text = [tempDict objectForKey:@"score"];
        [self.shiftView addSubview:lblScore];
    }
    
    if (self.score2Edit > 5) {
        self.shiftView.center = CGPointMake(self.shiftView.center.x, self.shiftView.center.y - 140);
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    StarTwinkler *twinkler = [[StarTwinkler alloc] initWithParentView:self.view];
    self.justViewing = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self setupIpad];
    }
    else {
        [self setupIphone];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UILabel *lblPlayer;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        lblPlayer = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, 320, 50)];
        lblPlayer.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:44];
    }
    else {
        lblPlayer = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, 160, 25)];
        lblPlayer.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:22];
    }
    
    lblPlayer.backgroundColor = [UIColor clearColor];
    lblPlayer.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    lblPlayer.shadowColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
    lblPlayer.shadowOffset = CGSizeMake(1, 1);
    
    lblPlayer.text = textField.text;
    [self.shiftView addSubview:lblPlayer];
    [self saveHighScore:textField.text];
    [textField removeFromSuperview];
    [self becomeFirstResponder];
    if (self.score2Edit > 5) {
        self.shiftView.center = CGPointMake(self.shiftView.center.x, self.shiftView.center.y + 140);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
