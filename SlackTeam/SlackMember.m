//
//  SlackTeam.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackMember.h"

// Slack Member JSON Keys

NSString * const kDisplayName = @"name";
NSString * const kProfile = @"profile";
NSString * const kProfilePicOriginal = @"image_original";
NSString * const kProfilePicThumbnail = @"image_192";
NSString * const kRealName = @"real_name";
NSString * const kTitle = @"title";

@implementation SlackMember

@dynamic name;
@dynamic realName;
@dynamic title;
@dynamic imageThumbnail;
@dynamic largeImage;

#pragma mark Public Methods

+ (void)parseSlackMembersJson:(NSArray *)membersJson manageContext:(NSManagedObjectContext *)context {
    
    NSMutableArray *parsedMembers = [NSMutableArray array];
    for (NSDictionary *member in membersJson) {
        [parsedMembers addObject:[SlackMember _parseIndividualSlackMemberJson:member manageContext:context]];
    }
}

#pragma mark - Private Helper Methods

+ (SlackMember *)_parseIndividualSlackMemberJson:(NSDictionary *)memberJson
                                   manageContext:(NSManagedObjectContext *)context {
    
    SlackMember *member =
         (SlackMember *)[NSEntityDescription insertNewObjectForEntityForName:@"SlackMember"
                                                      inManagedObjectContext:context];
    
    member.name = memberJson[kDisplayName];
    member.realName = memberJson[kRealName];
    member.title = memberJson[kTitle];
    
    NSDictionary *profileDict = memberJson[kProfile];
    
    member.imageThumbnail = profileDict[kProfilePicThumbnail];
    member.largeImage = profileDict[kProfilePicOriginal];
    
    return member;
}


@end
