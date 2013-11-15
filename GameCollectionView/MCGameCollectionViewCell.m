//
//  MCGameCollectionViewCell.m
//  CollectionViewTime
//
//  Created by Mark on 9/10/13.
//  Copyright (c) 2013 Mark. All rights reserved.
//

#import "MCGameCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MCGameCollectionViewCell
{
    UIImageView *homeTeamImageView;
    UIImageView *awayTeamImageView;
    UILabel *homeTeamTextView;
    UILabel *awayTeamTextView;
    UILabel *gameDateLabel;
    UILabel *vsLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        CGRect awayTeamImageFrame = CGRectMake(10, 40, 125, 125);
        awayTeamImageView = [[UIImageView alloc] initWithFrame:awayTeamImageFrame];
        [self.contentView addSubview:awayTeamImageView];
        
        CGRect homeTeamImageFrame = CGRectMake(185, 40, 125, 125);
        homeTeamImageView = [[UIImageView alloc] initWithFrame:homeTeamImageFrame];
        [self.contentView addSubview:homeTeamImageView];
        
        /*
        UIImage *backgroundImage = [UIImage imageNamed:@"image_hose_parallax.png"];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
        self.backgroundView = backgroundImageView;
         */
        
        /*
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = selectedBackgroundView;
         */
        
        /*
        self.layer.cornerRadius = 10.0f;
        self.layer.masksToBounds = YES;
         */
        
        CGFloat teamTextHeight = 50.0f;
        
        CGRect awayTeamTextViewFrame = CGRectInset(awayTeamImageFrame,
                                                   0, (awayTeamImageFrame.size.height - teamTextHeight));
        //CGRect textViewRect = CGRectMake(0, self.bounds.size.height - textHeight, self.bounds.size.width, textHeight);
        awayTeamTextView = [[UILabel alloc] initWithFrame:awayTeamTextViewFrame];
        awayTeamTextView.text = @"";
        awayTeamTextView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
        awayTeamTextView.textColor = [UIColor whiteColor];
        awayTeamTextView.textAlignment = NSTextAlignmentCenter;
        awayTeamTextView.font = [UIFont fontWithName:@"ArialMT" size:12];
        awayTeamTextView.shadowColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        awayTeamTextView.shadowOffset = CGSizeMake(3.0, 3.0);
        [self.contentView addSubview:awayTeamTextView];
        
        CGRect homeTeamTextViewFrame = CGRectInset(homeTeamImageFrame,
                                                   0, (homeTeamImageFrame.size.height - teamTextHeight));
        //CGRect textViewRect = CGRectMake(0, self.bounds.size.height - textHeight, self.bounds.size.width, textHeight);
        homeTeamTextView = [[UILabel alloc] initWithFrame:homeTeamTextViewFrame];
        homeTeamTextView.text = @"";
        homeTeamTextView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        homeTeamTextView.textColor = [UIColor whiteColor];
        homeTeamTextView.textAlignment = NSTextAlignmentCenter;
        homeTeamTextView.font = [UIFont fontWithName:@"ArialMT" size:12];
        homeTeamTextView.shadowColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        homeTeamTextView.shadowOffset = CGSizeMake(3.0, 3.0);
        [self.contentView addSubview:homeTeamTextView];

        // setup the game date label
        NSInteger gameDateLabelHeight = 50;
        CGRect gameDateLabelFrame = CGRectMake(0, (frame.size.height - gameDateLabelHeight),
                                               frame.size.width,  gameDateLabelHeight);
        gameDateLabel = [[UILabel alloc] initWithFrame:gameDateLabelFrame];
        gameDateLabel.text = @"";
        //gameDateLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        gameDateLabel.backgroundColor = [UIColor clearColor];
        gameDateLabel.textColor = [UIColor whiteColor];
        gameDateLabel.textAlignment = NSTextAlignmentCenter;
        //NSArray *fontNames = [UIFont fontNamesForFamilyName:@"Arial Narrow"];
        //gameDateLabel.font = [UIFont fontWithName:@"ArialMT" size:20];
        //gameDateLabel.font = [UIFont fontWithName:@"ArialNarrow-Bold" size:20];
        gameDateLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        gameDateLabel.shadowColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        gameDateLabel.shadowOffset = CGSizeMake(3.0, 3.0);
        [self.contentView addSubview:gameDateLabel];
        
        // setup the 'vs' label
        NSInteger vsLabelHeight = 50;
        CGRect vsLabelFrame = CGRectMake(0,
                                         ((frame.size.height / 2.0) - vsLabelHeight) + 60,
                                         frame.size.width,
                                         vsLabelHeight);
        vsLabel = [[UILabel alloc] initWithFrame:vsLabelFrame];
        vsLabel.text = @"";
        //vsLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        vsLabel.backgroundColor = [UIColor clearColor];
        vsLabel.textColor = [UIColor whiteColor];
        vsLabel.textAlignment = NSTextAlignmentCenter;
        //NSArray *fontNames = [UIFont fontNamesForFamilyName:@"Arial Narrow"];
        //vsLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
        //vsLabel.font = [UIFont fontWithName:@"ArialNarrow-Bold" size:18];
        vsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        vsLabel.shadowColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        vsLabel.shadowOffset = CGSizeMake(3.0, 3.0);
        [self.contentView addSubview:vsLabel];
        
        self.homeTeamNameText = @"Home";
        self.awayTeamNameText = @"Away";
        self.gameDateText = @"Date";
        self.vsText = @"VS";
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

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    // reset the cell
    homeTeamImageView.image = nil;
    awayTeamImageView.image = nil;
    homeTeamImageView.frame = CGRectMake(homeTeamImageView.frame.origin.x,
                                         homeTeamImageView.frame.origin.y,
                                         125, 125);
    awayTeamImageView.frame = CGRectMake(awayTeamImageView.frame.origin.x,
                                         awayTeamImageView.frame.origin.y,
                                         125, 125);
    homeTeamTextView.text = @"";
    awayTeamTextView.text = @"";
    gameDateLabel.text = @"";
    vsLabel.text = @"";
    self.backgroundColor = [UIColor clearColor];
}

/*
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (self.highlighted) {
        imageView.alpha = 0.8;
    } else {
        imageView.alpha = 1.0;
    }
}
*/

- (void)setHomeTeamNameText:(NSString *)text
{
    _homeTeamNameText = text;
    homeTeamTextView.text = text;

    UIImage *textGradient = [UIImage imageNamed:@"light_text_gradient.png"];
    homeTeamTextView.textColor = [UIColor colorWithPatternImage:textGradient];
    //nameTextView.backgroundColor = [UIColor colorWithPatternImage:textGradient];
    
    /* FOR UITextView
    CGFloat topCorrect = (nameTextView.bounds.size.height - nameTextView.contentSize.height * nameTextView.zoomScale)/2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    nameTextView.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    */
}

- (void)setAwayTeamNameText:(NSString *)text
{
    _awayTeamNameText = text;
    awayTeamTextView.text = text;
    
    UIImage *textGradient = [UIImage imageNamed:@"light_text_gradient.png"];
    awayTeamTextView.textColor = [UIColor colorWithPatternImage:textGradient];
    //nameTextView.backgroundColor = [UIColor colorWithPatternImage:textGradient];
    
    /* FOR UITextView
     CGFloat topCorrect = (nameTextView.bounds.size.height - nameTextView.contentSize.height * nameTextView.zoomScale)/2.0;
     topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
     nameTextView.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
     */
}

- (void)setGameDateText:(NSString *)text
{
    _gameDateText = text;
    gameDateLabel.text = text;
    UIImage *textGradient = [UIImage imageNamed:@"light_text_gradient.png"];
    gameDateLabel.textColor = [UIColor colorWithPatternImage:textGradient];
}

- (void)setVsText:(NSString *)text
{
    _vsText = text;
    vsLabel.text = text;
    UIImage *textGradient = [UIImage imageNamed:@"light_text_gradient.png"];
    vsLabel.textColor = [UIColor colorWithPatternImage:textGradient];
}

- (void)setHomeTeamImage:(UIImage *)image
{
    _homeTeamImage = image;
    homeTeamImageView.image = image;

    [self setImageSize:homeTeamImageView];
}

- (void)setAwayTeamImage:(UIImage *)image
{
    _awayTeamImage = image;
    awayTeamImageView.image = image;
    
    [self setImageSize:awayTeamImageView];
}

- (void)setImageSize:(UIImageView *)imageView
{
    // determine the size and aspect ratio of the image
    CGSize imageSize = imageView.image.size;
    CGFloat aspectRatio = imageSize.width / imageSize.height;
    
    CGSize imageViewSize;
    if (aspectRatio < 1) {
        // the photo is taller than it is wide, so constrain the width
        imageViewSize = CGSizeMake(CGRectGetWidth(imageView.bounds) * aspectRatio,
                                   CGRectGetHeight(imageView.bounds));
    } else if (aspectRatio > 1) {
        // the photo is wider than it is tall, so constrain the height
        imageViewSize = CGSizeMake(CGRectGetWidth(imageView.bounds),
                                   CGRectGetHeight(imageView.bounds) / aspectRatio);
    }
    
    // set the size of the image view
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,
                                 imageViewSize.width, imageViewSize.height);
    
    // center the image view
    imageView.center = CGPointMake(CGRectGetMidX(imageView.frame),
                                   CGRectGetMidY(imageView.frame));
}

@end
