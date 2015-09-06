//
//  SlackTeamViewModel.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackTeamViewModel.h"
#import "SlackMember.h"
#import "SlackMemberViewModel.h"

@implementation SlackTeamViewModel

+ (SlackTeamViewModel *)viewModelWithSlackMemberFetchObjects:(NSArray *)inFetchedObjects {
    SlackTeamViewModel *viewModel = [[SlackTeamViewModel alloc] init];
    viewModel.slackMembers = [SlackTeamViewModel _parseFetchObjectsIntoViewModel:inFetchedObjects];
    
    return viewModel;
}

#pragma mark - Private Helper Methods

+ (NSArray *)_parseFetchObjectsIntoViewModel:(NSArray *)fetchObjects {
    
    NSMutableArray *viewModelObjects = [NSMutableArray array];
    for (SlackMember *inMember in fetchObjects) {
        [viewModelObjects addObject:[SlackMemberViewModel viewModelWithSlackMember:inMember]];
    }
    
    return viewModelObjects;
}

@end
