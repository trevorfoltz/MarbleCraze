//
//  ViewController.m
//  MarbleCraze
//
//  Created by Trevlord on 10/27/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"

@interface ViewController ()

@end

@implementation ViewController

- (BOOL)shouldAutorotate
{
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    }
    return NO;
}

- (void)showGameController
{
    GameController *gc;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        gc = [[GameController alloc] initWithNibName:@"GameController_iPhone" bundle:nil];
    }
    else {
        gc = [[GameController alloc] initWithNibName:@"GameController_iPad" bundle:nil];
    }
    [self presentViewController:gc animated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(showGameController) withObject:nil afterDelay:3.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
