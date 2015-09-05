//
//  SlackService.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackService.h"
#import <AFNetworking/AFNetworking.h>

#import "AppDelegate.h"
#import "SlackMember.h"


NSString * const kAppToken = @"xoxp-4698769766-4698769768-4898023905-7a1afa";
NSString * const kMembersKey = @"members";
NSString * const kUrl = @"https://slack.com/api/users.list?token=%@";

NSString * const kDisplayNameKey = @"name";
NSString * const kProfilePicOriginalKey = @"image_original";
NSString * const kProfilePicThumbnailKey = @"image_192";
NSString * const kRealNameKey = @"real_name";
NSString * const kTitleKey = @"title";


@implementation SlackService

#pragma mark - Singleton Initializer

+ (instancetype)sharedService {
    
    static dispatch_once_t dispatchOnce;
    static SlackService *sharedService;
    
    dispatch_once(&dispatchOnce, ^{
        sharedService = [[SlackService alloc] init];
    });
    
    return sharedService;
}

#pragma mark - Web Service Methods

- (void)getSlackTeamList
{
    NSString *preparedString = [NSString stringWithFormat:kUrl,kAppToken];
    NSURL *url = [NSURL URLWithString:preparedString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.allowsCellularAccess = YES;
    
    NSManagedObjectContext *managedContext =
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *members = [SlackMember parseSlackMembersJson:responseObject[kMembersKey]
                                                manageContext:managedContext];
        NSLog(@"parsed objects %@", members);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error!!");
    }];
    
    [operation start];
}

#pragma mark - Private Helper Methods

@end
