//
//  UIView+MMConstraints.h
//  SlackTeam
//
//  Created by Trivedi, Astha on 06/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)


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


	[self addConstraint:heightConstraint];
}


@end
