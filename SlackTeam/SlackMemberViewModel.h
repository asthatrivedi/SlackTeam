//
//  SlackMemberViewModel.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SlackMember.h"

@interface SlackMemberViewModel : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * realName;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIImage *profilePic;
@property (nonatomic, strong) NSString *email;

+ (SlackMemberViewModel *)viewModelWithSlackMember:(SlackMember *)slackMember;

@end
