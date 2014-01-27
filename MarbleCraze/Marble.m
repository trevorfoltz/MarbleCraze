//
//  Marble.m
//  MarbleCrazy
//
//  Created by Trevlord on 10/15/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "Marble.h"

@implementation Marble
@synthesize imageIdx, currentRotation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *) image
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setImage:image];
    }
    return self;
}

- (void)rotate:(NSInteger) multiplier
{
    self.currentRotation += (2.0 * multiplier);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeRotation(self.currentRotation);
    } completion:^(BOOL finished){
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
