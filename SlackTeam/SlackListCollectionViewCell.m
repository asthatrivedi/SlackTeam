//
//  SlackListCollectionViewCell.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "SlackListCollectionViewCell.h"

#import "UIView+Constraints.h"


CGFloat const kLabelDefaultHeight = 25;


@interface SlackListCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *profilePic;
@property (nonatomic, weak) IBOutlet UILabel *displayName;
@property (nonatomic, weak) IBOutlet UILabel *realName;
@property (nonatomic, weak) IBOutlet UILabel *title;
//@property (nonatomic, assign) BOOL constraintsAdded;

@end

@implementation SlackListCollectionViewCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        //[self _setupView];
//         //[self setNeedsUpdateConstraints];
//    }
//    return self;
//}

#pragma mark - Setup method

- (void)setupViewWithSlackViewModel:(SlackMemberViewModel *)model {
    
    self.displayName.text = model.name;
    self.realName.text = model.realName;
    self.title.text = model.title;
    if (model.profilePic) {
        self.profilePic.image = model.profilePic;
    }
}

#pragma mark - Private Helper Methods

//- (void)_setupView {
//    
//    NSAssert(self.constraintsAdded == NO, @"this method should not be called if constraints are already added");
//    
//    // Profile Picture
//    self.profilePic = [[UIImageView alloc] init];
//    self.profilePic.image = [UIImage imageNamed:@"slack-icon-logo.png"];
//    self.profilePic.contentMode = UIViewContentModeScaleToFill;
//    self.profilePic.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:self.profilePic];
//    
//    
//    // Display Name
//    self.displayName = [[UILabel alloc] init];
//    self.displayName.textColor = [UIColor blackColor];
//    self.displayName.textAlignment = NSTextAlignmentLeft;
//    self.displayName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
//    self.displayName.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.displayName.adjustsFontSizeToFitWidth = YES;
//    self.displayName.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:self.displayName];
//
//    // Real Name
//    self.realName = [[UILabel alloc] init];
//    self.realName.textColor = [UIColor blackColor];
//    self.realName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
//    self.realName.textAlignment = NSTextAlignmentRight;
//    self.realName.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.realName.adjustsFontSizeToFitWidth = YES;
//    self.realName.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:self.realName];
//
//    // Title
//    self.title = [[UILabel alloc] init];
//    self.title.textColor = [UIColor blackColor];
//    self.title.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
//    self.title.textAlignment = NSTextAlignmentRight;
//    self.title.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.title.adjustsFontSizeToFitWidth = YES;
//    self.title.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:self.title];
//    
//}
//
//- (void)updateConstraints {
//    
//    if (self.constraintsAdded == NO) {
//        
//        // Profile Picture
//        [self.contentView addBoundingConstraintsEqualToParentToSubview:self.profilePic];
//        
//        // Display Name
//        [self.displayName addHeightConstraintWithHeight:kLabelDefaultHeight];
//
//        [self.contentView addBoundingConstraintsToParentForSubview:self.displayName
//                                                         withSides:[Sides newWithTop:@(2)
//                                                                                left:@(5)
//                                                                              bottom:nil
//                                                                               right:@(0)]];
//
//        // Real Name
//        [self.contentView addBoundingConstraintsToParentForSubview:self.realName
//                                                         withSides:[Sides newWithTop:nil
//                                                                                left:@(0)
//                                                                              bottom:@(-25)
//                                                                               right:@(-5)]];
//        [self.realName addHeightConstraintWithHeight:kLabelDefaultHeight];
//        
//        // Title
//        [self.contentView addBoundingConstraintsToParentForSubview:self.title
//                                                         withSides:[Sides newWithTop:nil
//                                                                                left:@(0)
//                                                                              bottom:@(-5)
//                                                                               right:@(-5)]];
//        [self.realName addHeightConstraintWithHeight:kLabelDefaultHeight];
//        
//        self.constraintsAdded = YES;
//    }
//    
//    [super updateConstraints];
//}


@end
