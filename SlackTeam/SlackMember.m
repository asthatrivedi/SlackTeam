//
//  SlackTeam.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackMember.h"

// Slack Member JSON Keys

NSString * const kMemberID = @"id";
NSString * const kDisplayName = @"name";
NSString * const kProfile = @"profile";
NSString * const kProfilePicOriginal = @"image_original";
NSString * const kProfilePicThumbnail = @"image_192";
NSString * const kRealName = @"real_name";
NSString * const kTitle = @"title";
NSString * const kEmail = @"email";

@implementation SlackMember

@dynamic memberId;
@dynamic name;
@dynamic realName;
@dynamic title;
@dynamic largeImage;
@dynamic email;

#pragma mark Public Methods

+ (NSArray *)parseSlackMembersJson:(NSArray *)membersJson manageContext:(NSManagedObjectContext *)context {
    
    NSMutableArray *members = [NSMutableArray array];
    for (NSDictionary *member in membersJson) {
        [members addObject:[SlackMember _parseIndividualSlackMemberJson:member manageContext:context]];
    }
    
    return members;
}

#pragma mark - Private Helper Methods

+ (SlackMember *)_parseIndividualSlackMemberJson:(NSDictionary *)memberJson
                                   manageContext:(NSManagedObjectContext *)context {
    
    // Fetch first to ensure there are no duplicate entries.
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"SlackMember"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"memberId == %@", memberJson[kMemberID]];
    [fetch setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:fetch error:&error];
    
    SlackMember *member;
    
    if ([results count] == 0) {
        
        // Add a new entry.
        member =
            (SlackMember *)[NSEntityDescription insertNewObjectForEntityForName:@"SlackMember"
                                                         inManagedObjectContext:context];
        
        member.memberId = memberJson[kMemberID];
        member.name = memberJson[kDisplayName];
        member.realName = memberJson[kRealName];
        member.title = memberJson[kTitle];
        
        NSDictionary *profileDict = memberJson[kProfile];
        
        member.largeImage = profileDict[kProfilePicOriginal];
        member.email = profileDict[kEmail];
    }
    else {
        member = [results firstObject];
    }
    
    return member;
}


@end
