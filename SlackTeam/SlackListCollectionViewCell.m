//
//  SlackListCollectionViewCell.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackListCollectionViewCell.h"


CGFloat const kLabelDefaultHeight = 25;


@interface SlackListCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *profilePic;
@property (nonatomic, weak) IBOutlet UILabel *displayName;
@property (nonatomic, weak) IBOutlet UILabel *realName;
@property (nonatomic, weak) IBOutlet UILabel *title;

@end

@implementation SlackListCollectionViewCell

#pragma mark - Setup method

- (void)setupViewWithSlackViewModel:(SlackMemberViewModel *)model {
    
    self.displayName.text = model.name;
    self.realName.text = model.realName;
    self.title.text = model.title;
    if (model.profilePic) {
        self.profilePic.image = model.profilePic;
    }
}

@end
