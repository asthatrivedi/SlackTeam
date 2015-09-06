//
//  SlackMemberViewModel.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackMemberViewModel.h"


@implementation SlackMemberViewModel

+ (SlackMemberViewModel *)viewModelWithSlackMember:(SlackMember *)slackMember {
    
    SlackMemberViewModel *viewModel = [[SlackMemberViewModel alloc] init];
    viewModel.name = slackMember.name;
    viewModel.realName = slackMember.realName;
    viewModel.title = slackMember.title;
    
    return viewModel;
}

@end
