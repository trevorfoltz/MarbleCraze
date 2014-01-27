//
//  Marble.h
//  MarbleCrazy
//
//  Created by Trevlord on 10/15/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Marble : UIImageView

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *) image;

@property (nonatomic, assign) NSInteger imageIdx;
@property (nonatomic, assign) CGFloat currentRotation;

- (void)rotate:(NSInteger) multiplier;

@end
