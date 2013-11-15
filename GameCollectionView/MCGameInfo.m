//
//  MCGameInfo.m
//  GameCollectionView
//
//  Created by Mark on 9/12/13.
//  Copyright (c) 2013 Mark. All rights reserved.
//

#import "MCGameInfo.h"

@implementation MCGameInfo

@synthesize homeImagePath, awayImagePath, gameDate, gameTime;

- (id)init
{
    self = [super init];
    if (self) {
        self.homeImagePath = @"";
        self.awayImagePath = @"";
        self.gameDate = @"";
        self.gameTime = @"";
    }
    return self;
}

@end
