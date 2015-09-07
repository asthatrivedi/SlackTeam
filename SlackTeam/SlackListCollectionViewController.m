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
#import "SlackTeamViewModel.h"
#import "Utils.h"

@interface SlackListCollectionViewController ()

@property (nonatomic, strong) SlackTeamViewModel *slackTeamViewModel;

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
                                             selector:@selector(_handlePhotoDownlaodedNotification:)
                                                 name:kPhotoDownloadedNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.slackTeamViewModel.slackMembers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SlackListCollectionViewCell *cell = (SlackListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 5.f;
    
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    [cell setupViewWithSlackViewModel:[self.slackTeamViewModel.slackMembers objectForKey:key]];
    
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

- (void)_handlePhotoDownlaodedNotification:(NSNotification *)notif {
    NSDictionary *userInfo = [notif userInfo];
    
    NSString *key = userInfo[@"key"];
    
    NSLog(@"key: %@", key);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[key integerValue] inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)handleCoreDataChangeNotification {
    self.slackTeamViewModel = [[SlackService sharedService] slackList];
    [self.collectionView reloadData];
}

@end
