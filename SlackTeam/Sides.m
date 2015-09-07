//
//  Sides.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "Sides.h"

@implementation Sides

+ (Sides *)newWithTop:(NSNumber *)top
                 left:(NSNumber *)left
               bottom:(NSNumber *)bottom
                right:(NSNumber *)right
{
    Sides *sides = [Sides new];
    sides.top = top;
    sides.left = left;
    sides.right = right;
    sides.bottom = bottom;
    
    return sides;
}

- (NSString *)description
{
    NSString *customValues = [NSString stringWithFormat:@"top: %@, left: %@, bottom: %@, right: %@",
                              self.top, self.left, self.bottom, self.right];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, customValues];
}


@end
