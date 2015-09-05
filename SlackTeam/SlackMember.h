//
//  SlackMember.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SlackMember : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * realName;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imageThumbnail;
@property (nonatomic, retain) NSString * largeImage;

+ (NSArray *)parseSlackMembersJson:(NSArray *)membersJson manageContext:(NSManagedObjectContext *)context;

@end
