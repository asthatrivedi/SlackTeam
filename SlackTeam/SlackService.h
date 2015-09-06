//
//  SlackService.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SlackService : NSObject

+ (instancetype)sharedService;

- (void)pollSlackTeamListFromServer;
- (NSArray *)getSlackList;

@end
