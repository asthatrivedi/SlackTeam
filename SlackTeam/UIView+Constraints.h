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
 * Adds the view as a subview and sets the child's top, right, bottom, and left constraints equal to the
 * receiver's top, right, bottom, and left.
 *
 * @param subview  The view to be added as a subview.
 */
- (void)addSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview;

/**
 * Inserts the view as a subview below the reference view and sets the child's top, right, bottom, and
 * left constraints equal to the receiver's top, right, bottom, and left.
 *
 * @param subview  The view to be added as a subview.
 * @param referenceView  The view below which the new view should be added.
 */
- (void)insertSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview belowView:(UIView *)referenceView;

/**
 * Inserts the view as a subview above the reference view and sets the child's top, right, bottom, and
 * left constraints equal to the receiver's top, right, bottom, and left.
 *
 * @param subview  The view to be added as a subview.
 * @param referenceView  The view below which the new view should be added.
 */
- (void)insertSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview aboveView:(UIView *)referenceView;

/**
 * Inserts the view as a subview at the indicated index and sets the child's top, right, bottom, and
 * left constraints equal to the receiver's top, right, bottom, and left.
 *
 * @param subview  The view to be added as a subview.
 * @param referenceView  The view below which the new view should be added.
 */
- (void)insertSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview atIndex:(NSInteger)index;

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
