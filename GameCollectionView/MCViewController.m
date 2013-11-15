//
//  MCViewController.m
//  CollectionViewTime
//
//  Created by Mark on 9/10/13.
//  Copyright (c) 2013 Mark. All rights reserved.
//

#import "MCViewController.h"
#import "MCGameCollectionViewCell.h"
#import "MCGameInfo.h"

@interface MCViewController ()

@end

static NSString *CellId = @"Cell-Id";

@implementation MCViewController
{
    NSMutableArray *gameInfoArray;
    UIScrollView *backgroundScrollView;
    CGPoint backgroundScrollviewOffset;
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        gameInfoArray = [[NSMutableArray alloc] init];
        backgroundScrollviewOffset = CGPointMake(100, 0);
    }
    return self;
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup the image model
    [self setupModel];
    
    // set background image view
    UIImage *backgroundImage = [UIImage imageNamed:@"dark_image_hose_parallax.png"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // change frame height
    CGRect backgroundImageViewFrame = backgroundImageView.frame;
    backgroundImageViewFrame.size.height = [[UIScreen mainScreen] bounds].size.height;
    backgroundImageView.frame = backgroundImageViewFrame;
    
    backgroundScrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [backgroundScrollView addSubview:backgroundImageView];
    backgroundScrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                             UIViewAutoresizingFlexibleHeight);
    backgroundScrollView.contentInset = UIEdgeInsetsMake(0, -(backgroundScrollviewOffset.x), 0, 0);
    [self.view addSubview:backgroundScrollView];
    [self.view sendSubviewToBack:backgroundScrollView];
    
    // configure the collection view layout
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flowLayout.minimumInteritemSpacing = 20.0f;
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 200);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // configure the collection view
    [self.collectionView registerClass:[MCGameCollectionViewCell class] forCellWithReuseIdentifier:CellId];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.frame = CGRectMake(0, 100,
                                           [[UIScreen mainScreen] bounds].size.width, 200);

    //self.collectionView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
}

-(void)scrollViewDidScroll:(UIScrollView *)scroller
{
    CGPoint offset = scroller.contentOffset;
    //NSLog(@"DID SCROLL: offset = %f, %f", offset.x, offset.y);
    
    CGFloat scaleFactor = 10.0f;
    CGPoint newBackgroundOffset = CGPointMake(backgroundScrollviewOffset.x + (offset.x / scaleFactor),
                                              backgroundScrollviewOffset.y + (offset.y / scaleFactor));
                                              
    [backgroundScrollView setContentOffset:CGPointMake(newBackgroundOffset.x, newBackgroundOffset.y) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // create timestamp string for custom event
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *timestampString  = [dateFormatter stringFromDate:now];
    
    for (MCGameCollectionViewCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        NSLog(@"VISIBLE CELL INDEX: %@", indexPath);
    }
}

- (MCGameInfo*)createGameWithHomeImagePath:(NSString *)homeImagePath
                             awayImagePath:(NSString *)awayImagePath
                                  gameDate:(NSString *)gameDate
                                  gameTime:(NSString *)gameTime
{
    MCGameInfo *gameInfo = [[MCGameInfo alloc] init];
    gameInfo.homeImagePath = homeImagePath;
    gameInfo.awayImagePath = awayImagePath;
    gameInfo.gameDate = gameDate;
    gameInfo.gameTime = gameTime;
    return gameInfo;
}

- (CGRect)getRect
{
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    
    float max = MAX(self.view.bounds.size.width, self.view.bounds.size.height);
    float min = MIN(self.view.bounds.size.width, self.view.bounds.size.height);
    
    return (isPortrait ?
            CGRectMake(0.0, 10, min, max) :
            CGRectMake(0, 50, max, min));
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        CGRect rect = self.collectionView.frame;
        rect.origin.y = 100;
        rect.size.width = self.view.bounds.size.width;
        rect.size.height = 200;
        self.collectionView.frame = rect;
    } else {
        CGRect rect = self.collectionView.frame;
        rect.origin.y = 50;
        rect.size.width = self.view.bounds.size.width;
        rect.size.height = 200;
        self.collectionView.frame = rect;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return gameInfoArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCGameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    
    MCGameInfo *gameInfo = [gameInfoArray objectAtIndex:indexPath.item];
    
    cell.awayTeamImage = [UIImage imageNamed:gameInfo.awayImagePath];
    cell.homeTeamImage = [UIImage imageNamed:gameInfo.homeImagePath];
    cell.gameDateText = gameInfo.gameDate;
    cell.vsText = @"VS";
    
    return cell;
}

- (void)setupModel
{
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"GB-away-130x115.png"
                                                      gameDate:@"SEPTEMBER 8, 2013"
                                                      gameTime:@"1:00 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SEA-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"SEPTEMBER 15, 2013"
                                                      gameTime:@"8:30 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"IND-away-130x115.png"
                                                      gameDate:@"SEPTEMBER 22, 2013"
                                                      gameTime:@"4:25 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"STL-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"SEPTEMBER 26, 2013"
                                                      gameTime:@"8:25 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"HOU-away-130x115.png"
                                                      gameDate:@"OCTOBER 6, 2013"
                                                      gameTime:@"8:20 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"ARI-away-130x115.png"
                                                      gameDate:@"OCTOBER 13, 2013"
                                                      gameTime:@"4:25 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"TEN-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"OCTOBER 20, 2013"
                                                      gameTime:@"4:05 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"JAC-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"OCTOBER 27, 2013"
                                                      gameTime:@"1:00 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"CAR-away-130x115.png"
                                                      gameDate:@"NOVEMBER 10, 2013"
                                                      gameTime:@"4:05 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"NO-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"NOVEMBER 17, 2013"
                                                      gameTime:@"4:25 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"WAS-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"NOVEMBER 25, 2013"
                                                      gameTime:@"8:40 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"STL-away-130x115.png"
                                                      gameDate:@"DECEMBER 1, 2013"
                                                      gameTime:@"4:05 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"SEA-away-130x115.png"
                                                      gameDate:@"DECEMBER 8, 2013"
                                                      gameTime:@"4:25 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"TB-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"DECEMBER 15, 2013"
                                                      gameTime:@"1:00 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"SF-home-130x115.png"
                                                 awayImagePath:@"ATL-away-130x115.png"
                                                      gameDate:@"DECEMBER 23, 2013"
                                                      gameTime:@"8:40 PM (EST)"]];
    [gameInfoArray addObject:[self createGameWithHomeImagePath:@"ARI-home-130x115.png"
                                                 awayImagePath:@"SF-away-130x115.png"
                                                      gameDate:@"DECEMBER 29, 2013"
                                                      gameTime:@"4:25 PM (EST)"]];
}

@end
