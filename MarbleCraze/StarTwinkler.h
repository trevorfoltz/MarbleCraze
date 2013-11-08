//
//  StarTwinkler.h
//  MarbleCraze
//
//  Created by Trevlord on 11/2/13.
//  Copyright (c) 2013 forevorware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StarTwinkler : NSObject

@property (nonatomic, retain) NSMutableArray *stars;
@property (nonatomic, assign) BOOL starToggle;
@property (nonatomic, assign) NSInteger starIdx;
@property (nonatomic, retain) UIView *parentView;


- (id)initWithParentView:(UIView *) parent;

@end
