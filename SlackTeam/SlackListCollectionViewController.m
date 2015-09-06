//
//  SlackListCollectionViewController.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackListCollectionViewController.h"

#import "SlackListCollectionViewCell.h"
#import "SlackService.h"
#import "Utils.h"

@interface SlackListCollectionViewController ()

@property (nonatomic, strong) NSArray *slackTeamMembers;

@end

@implementation SlackListCollectionViewController

static NSString * const reuseIdentifier = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Slack Team";
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:42.f/255.f blue:59.f/255.f alpha:1.f];

    // Register cell classes
    [self.collectionView registerClass:[SlackListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCoreDataChangeNotification)
                                                 name:kSlackServiceAddedContentNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCoreDataChangeNotification)
                                                 name:kPhotoManagerContentUpdateNotification
                                               object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self slackTeamMembers] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SlackListCollectionViewCell *cell = (SlackListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell setupCurvyView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    return CGSizeMake(width - 40, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20, 20, 30, 20);
}

#pragma mark Notification Handlers

- (void)handleCoreDataChangeNotification {
    self.slackTeamMembers = [[SlackService sharedService] getSlackList];
    [self.collectionView reloadData];
}

@end
