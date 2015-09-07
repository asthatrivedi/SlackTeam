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
#import "SlackMemberViewModel.h"
#import "Utils.h"


NSString * const kAppToken = @"xoxp-4698769766-4698769768-4898023905-7a1afa";
NSString * const kMembersKey = @"members";
NSString * const kUrl = @"https://slack.com/api/users.list?token=%@";

NSString * const kDisplayNameKey = @"name";
NSString * const kProfilePicOriginalKey = @"image_original";
NSString * const kProfilePicThumbnailKey = @"image_192";
NSString * const kRealNameKey = @"real_name";
NSString * const kTitleKey = @"title";

typedef void (^ProfilePictureDownloadingCompletionBlock)(UIImage *image, NSError *error);
typedef void (^BasicCompletionBlock)(NSError *error);

@interface SlackService ()

@property (nonatomic, strong) NSArray *slackTeamModelList;
@property (nonatomic, strong) SlackTeamViewModel *teamViewModel;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation SlackService

#pragma mark - Singleton Initializer

+ (instancetype)sharedService {
    
    static dispatch_once_t dispatchOnce;
    static SlackService *sharedService;
    
    dispatch_once(&dispatchOnce, ^{
        sharedService = [[SlackService alloc] init];
        sharedService.concurrentQueue = dispatch_queue_create("com.astha.SlackTeam.profilePicQueue",
                                                              DISPATCH_QUEUE_CONCURRENT);
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
        self.slackTeamModelList = [SlackMember parseSlackMembersJson:responseObject[kMembersKey]
                                                       manageContext:managedContext];
        
        NSError *error = nil;
        
        [managedContext save:&error];
        
        if (error) {
            NSLog(@"error %@", error.description);
        }
        else {
            self.teamViewModel = [SlackTeamViewModel viewModelWithSlackMemberFetchObjects:self.slackTeamModelList];
            [self _contentAddedNotification];
            [self _downloadImagesFromServer:^(NSError *error) {
                if (error)
                    NSLog(@"image download error");
                else {
                    [self _contentAddedNotification];
                }
            }];
            NSLog(@"success");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error!!");
    }];
    
    [operation start];
}

- (void)_downloadImagesFromServer:(BasicCompletionBlock)completionBlock {
    
    __block NSError *inError = nil;
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    __block UIImage *tempImage = nil;
    
    NSInteger index = 0;
    
    for (SlackMember *inMember in self.slackTeamModelList) {
        
        dispatch_group_enter(downloadGroup);
        
        [self _downloadProfilePictureUrl:inMember.largeImage withCompletion:^(UIImage *image, NSError *error) {
            if (!error) {
                tempImage = image;
                [self _setProfilePictureToViewModel:tempImage forKey:index];
            }
            else {
                dispatch_group_leave(downloadGroup);
            }
            
        }];
        index++;
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        if (completionBlock) {
            completionBlock(inError);
        }
    });
}

#pragma mark getter/setters

- (SlackTeamViewModel *)slackList {
    return self.teamViewModel;
}

- (void)_setProfilePictureToViewModel:(UIImage *)image forKey:(NSInteger)indexKey {
    if (image) {
        dispatch_barrier_async(self.concurrentQueue, ^{
            
            SlackMemberViewModel *inMember =
                [self.teamViewModel.slackMembers objectForKey:[NSString stringWithFormat:@"%ld",indexKey]];
            inMember.profilePic = image;
            
            if (inMember)
                [self.teamViewModel.slackMembers setObject:inMember
                                                    forKey:[NSString stringWithFormat:@"%ld",indexKey]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self _contentAddedNotification];
                NSLog(@"test");
            });
        });
    }

}


#pragma mark - Private Helper Methods


- (void)_downloadProfilePictureUrl:(NSString *)url
                    withCompletion:(ProfilePictureDownloadingCompletionBlock)completionBlock {
    
    __block NSError *error = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        completionBlock(responseObject, error);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
        completionBlock(nil, error);
    }];
    [requestOperation start];
}

- (void)_photoDownloadedNotification {
    static NSNotification *notification = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notification = [NSNotification notificationWithName:kPhotoDownloadedNotification object:nil];
    });
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification
                                               postingStyle:NSPostASAP
                                               coalesceMask:NSNotificationCoalescingOnName
                                                   forModes:nil];
}

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
