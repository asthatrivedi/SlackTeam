//
//  UIView+MMConstraints.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sides.h"

@interface UIView (Constraints)

/**
 * Sets the child's top, right, bottom, and left constraints equal to the receiver's top, right,
 * bottom, and left.
 *
 * @param subview  The subview to which the constraints will be added.
 */
- (void)addBoundingConstraintsEqualToParentToSubview:(UIView *)subview;

/**
 * Sets the child's top, right, bottom, and left constraints with insets to the receiver's top, right,
 * bottom, and left.
 *
 * @param subview  The subview to which the constraints will be added.
 * @param sides   The sides to which the subview is supposed to be set up on the parent view.
 */
- (void)addBoundingConstraintsToParentForSubview:(UIView *)subview
									   withSides:(Sides *)sides;
/**
 * Adds a height constraint to the view.
 */
- (void)addHeightConstraintWithHeight:(CGFloat)height;

@end
