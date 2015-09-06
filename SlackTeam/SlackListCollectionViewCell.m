//
//  SlackListCollectionViewCell.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackListCollectionViewCell.h"

@implementation SlackListCollectionViewCell

- (void)setupCurvyView {
    self.layer.cornerRadius = 5.f;
    [self setNeedsDisplay];
}

@end
