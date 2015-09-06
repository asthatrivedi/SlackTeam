//
//  SlackTeamViewModel.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlackTeamViewModel : NSObject

@property (nonatomic, strong) NSArray *slackMembers;

+ (SlackTeamViewModel *)viewModelWithSlackMemberFetchObjects:(NSArray *)inFetchedObjects;

@end
