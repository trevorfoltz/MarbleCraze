//
//  Marble.m
//  MarbleCrazy
//
//  Created by Trevlord on 10/15/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import "Marble.h"

@implementation Marble
@synthesize imageIdx;

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
