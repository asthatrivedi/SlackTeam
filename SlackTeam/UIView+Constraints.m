//
//  UIView+MMConstraints.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)

- (void)addSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview
{
	[self addSubview:subview];

	[self addBoundingConstraintsEqualToParentToSubview:subview];
}

- (void)insertSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview belowView:(UIView *)referenceView
{
	[self insertSubview:subview belowSubview:referenceView];

	[self addBoundingConstraintsEqualToParentToSubview:subview];
}

- (void)insertSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview aboveView:(UIView *)referenceView
{
	[self insertSubview:subview aboveSubview:referenceView];

	[self addBoundingConstraintsEqualToParentToSubview:subview];
}

- (void)insertSubviewAndSetBoundingConstraintsEqualToParent:(UIView *)subview atIndex:(NSInteger)index
{
	[self insertSubview:subview atIndex:index];

	[self addBoundingConstraintsEqualToParentToSubview:subview];
}

- (void)addBoundingConstraintsEqualToParentToSubview:(UIView *)subview
{
	[self addConstraints:@[
						   [NSLayoutConstraint constraintWithItem:subview
														attribute:NSLayoutAttributeLeft
														relatedBy:NSLayoutRelationEqual
														   toItem:self
														attribute:NSLayoutAttributeLeft
													   multiplier:1
														 constant:0],
						   [NSLayoutConstraint constraintWithItem:subview
														attribute:NSLayoutAttributeRight
														relatedBy:NSLayoutRelationEqual
														   toItem:self
														attribute:NSLayoutAttributeRight
													   multiplier:1
														 constant:0],
						   [NSLayoutConstraint constraintWithItem:subview
														attribute:NSLayoutAttributeTop
														relatedBy:NSLayoutRelationEqual
														   toItem:self
														attribute:NSLayoutAttributeTop
													   multiplier:1
														 constant:0],
						   [NSLayoutConstraint constraintWithItem:subview
														attribute:NSLayoutAttributeBottom
														relatedBy:NSLayoutRelationEqual
														   toItem:self
														attribute:NSLayoutAttributeBottom
													   multiplier:1
														 constant:0]]];
}

- (void)addBoundingConstraintsToParentForSubview:(UIView *)subview
								       withSides:(Sides *)sides
{
	if (subview)
	{
		NSLayoutConstraint *constraints;
		if (sides.left)
		{
			constraints = [NSLayoutConstraint constraintWithItem:subview
													   attribute:NSLayoutAttributeLeft
													   relatedBy:NSLayoutRelationEqual
														  toItem:self
													   attribute:NSLayoutAttributeLeft
													  multiplier:1
														constant:sides.left.floatValue];
			[self addConstraint:constraints];
		}
		if (sides.right)
		{
			constraints = [NSLayoutConstraint constraintWithItem:subview
													   attribute:NSLayoutAttributeRight
													   relatedBy:NSLayoutRelationEqual
														  toItem:self
													   attribute:NSLayoutAttributeRight
													  multiplier:1
														constant:sides.right.floatValue];
			[self addConstraint:constraints];
		}
		if (sides.top)
		{
			constraints = [NSLayoutConstraint constraintWithItem:subview
													   attribute:NSLayoutAttributeTop
													   relatedBy:NSLayoutRelationEqual
														  toItem:self
													   attribute:NSLayoutAttributeTop
													  multiplier:1
														constant:sides.top.floatValue];
			[self addConstraint:constraints];
		}
		if (sides.bottom)
		{
			constraints = [NSLayoutConstraint constraintWithItem:subview
													   attribute:NSLayoutAttributeBottom
													   relatedBy:NSLayoutRelationEqual
														  toItem:self
													   attribute:NSLayoutAttributeBottom
													  multiplier:1
														constant:sides.bottom.floatValue];
			[self addConstraint:constraints];
		}
	}
}

- (void)addHeightConstraintWithHeight:(CGFloat)height
{
	NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self
																		attribute:NSLayoutAttributeHeight
																		relatedBy:NSLayoutRelationEqual
																		   toItem:nil
																		attribute:NSLayoutAttributeNotAnAttribute
																	   multiplier:1
																		 constant:height];

	[self _assertConstraintDoesNotExist:heightConstraint];

	[self addConstraint:heightConstraint];
}

- (void)_assertConstraintDoesNotExist:(NSLayoutConstraint *)constraint
{
#if INTERNAL_BUILD
	for (NSLayoutConstraint *curConstraint in self.constraints)
	{
		BOOL equal = curConstraint.firstItem == constraint.firstItem &&
		curConstraint.firstAttribute == constraint.firstAttribute &&
		curConstraint.relation == constraint.relation &&
		curConstraint.secondItem == constraint.secondItem &&
		curConstraint.secondAttribute == constraint.secondAttribute &&
		curConstraint.multiplier == constraint.multiplier;

		NSAssert(equal == NO, @"View %@ already has constraint", self);
	}
#endif
}

- (NSLayoutConstraint *)_boundingConstraintToSuperviewWithAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant
{
	return [NSLayoutConstraint constraintWithItem:self
										attribute:attribute
										relatedBy:NSLayoutRelationEqual
										   toItem:self.superview
										attribute:attribute
									   multiplier:1
										 constant:constant];
}

@end
