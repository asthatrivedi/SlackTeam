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

+ (NSMutableDictionary *)_parseFetchObjectsIntoViewModel:(NSArray *)fetchObjects {
    
    NSMutableDictionary *viewModelObjects = [NSMutableDictionary dictionary];
    NSInteger index = 0;
    for (SlackMember *inMember in fetchObjects) {
        [viewModelObjects setObject:[SlackMemberViewModel viewModelWithSlackMember:inMember]
                             forKey:[NSString stringWithFormat:@"%ld",index]];
        index++;
    }
    
    return viewModelObjects;
}

@end
