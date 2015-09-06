//
//  SlackListCollectionViewCell.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackListCollectionViewCell.h"

@implementation SlackListCollectionViewCell

#pragma mark - Setup method

- (void)setupViewWithSlackViewModel:(SlackMemberViewModel *)model {
    self.dispayName.text = model.name;
    self.realName.text = model.realName;
    self.title.text = model.title;
    
    [self _setupView];
}

#pragma mark - Private Helper Methods

- (void)_setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.f;
    [self setNeedsDisplay];
}

@end
