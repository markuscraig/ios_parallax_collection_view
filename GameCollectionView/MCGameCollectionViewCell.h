//
//  MCGameCollectionViewCell.h
//  CollectionViewTime
//
//  Created by Mark on 9/10/13.
//  Copyright (c) 2013 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCGameCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *homeTeamImage;
@property (nonatomic, strong) UIImage *awayTeamImage;
@property (nonatomic, strong) NSString *homeTeamNameText;
@property (nonatomic, strong) NSString *awayTeamNameText;
@property (nonatomic, strong) NSString *gameDateText;
@property (nonatomic, strong) NSString *vsText;

@end
