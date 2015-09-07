//
//  Sides.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sides : NSObject

@property (nonatomic, strong) NSNumber *top;
@property (nonatomic, strong) NSNumber *left;
@property (nonatomic, strong) NSNumber *right;
@property (nonatomic, strong) NSNumber *bottom;

+ (Sides *)newWithTop:(NSNumber *)top
                 left:(NSNumber *)left
               bottom:(NSNumber *)bottom
                right:(NSNumber *)right;

@end
