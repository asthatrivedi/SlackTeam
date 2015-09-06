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
#import "Utils.h"


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

- (void)pollSlackTeamListFromServer
{
    NSString *preparedString = [NSString stringWithFormat:kUrl,kAppToken];
    NSURL *url = [NSURL URLWithString:preparedString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.allowsCellularAccess = YES;
    
    __weak NSManagedObjectContext *managedContext =
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SlackMember parseSlackMembersJson:responseObject[kMembersKey]
                             manageContext:managedContext];
        
        NSError *error = nil;
        
        [managedContext save:&error];
        
        if (error) {
            NSLog(@"error %@", error.description);
        }
        else {
            [self _contentAddedNotification];
            NSLog(@"success");
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error!!");
    }];
    
    [operation start];
}

- (NSArray *)getSlackList {
    
    __weak NSManagedObjectContext *managedContext =
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SlackMember"
                                              inManagedObjectContext:managedContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [managedContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

#pragma mark - Private Helper Methods

- (void)_contentAddedNotification {
    static NSNotification *notification = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notification = [NSNotification notificationWithName:kSlackServiceAddedContentNotification object:nil];
    });
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification
                                               postingStyle:NSPostASAP
                                               coalesceMask:NSNotificationCoalescingOnName
                                                   forModes:nil];
}

@end
