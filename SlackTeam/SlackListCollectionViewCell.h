//
//  SlackListCollectionViewCell.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SlackMemberViewModel.h"

@interface SlackListCollectionViewCell : UICollectionViewCell

- (void)setupViewWithSlackViewModel:(SlackMemberViewModel *)model;

@end
