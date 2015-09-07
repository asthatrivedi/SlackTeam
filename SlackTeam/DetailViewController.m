//
//  DetailViewController.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "DetailViewController.h"

#import "UIView+Constraints.h"
#import "Utils.h"

CGFloat const kLabelHeight = 25;

@interface DetailViewController ()

//@property (nonatomic, weak) IBOutlet UIImageView *profilePic;
//@property (nonatomic, weak) IBOutlet UILabel *realName;
//@property (nonatomic, weak) IBOutlet UILabel *jobTitle;
//@property (nonatomic, weak) IBOutlet UILabel *emailAddress;

@property (nonatomic, strong) UIImageView *profilePic;
@property (nonatomic, strong) UILabel *realName;
@property (nonatomic, strong) UILabel *jobTitle;
@property (nonatomic, strong) UILabel *emailAddress;

@property (nonatomic, assign) BOOL constraintsAdded;

@property (nonatomic, strong) SlackMemberViewModel *viewModel;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.name;
    self.view.backgroundColor = kSystemTintColor;
    
    [self _setupView];
    [self _setupDataInView];
}

- (void)_setupView {
    
    NSAssert(self.constraintsAdded == NO, @"this method should not be called if constraints are already added");
    
    if (self.constraintsAdded == NO) {
    
        // Profile Picture
        self.profilePic = [[UIImageView alloc] init];
        
        self.profilePic.image = [UIImage imageNamed:@"slack-icon-logo.png"];
        self.profilePic.contentMode = UIViewContentModeScaleToFill;
        self.profilePic.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.profilePic];
        
        [self.view addBoundingConstraintsToParentForSubview:self.profilePic
                                                  withSides:[Sides newWithTop:@(0)
                                                                         left:@(0)
                                                                       bottom:nil
                                                                        right:@(0)]];
        
        [self.profilePic addHeightConstraintWithHeight:250];
        
        // Real Name
        self.realName = [[UILabel alloc] init];
        self.realName.textColor = [UIColor whiteColor];
        //self.realName.backgroundColor = [UIColor blueColor];
        self.realName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
        self.realName.textAlignment = NSTextAlignmentCenter;
        self.realName.lineBreakMode = NSLineBreakByTruncatingTail;
        self.realName.adjustsFontSizeToFitWidth = YES;
        self.realName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.realName];
        
        [self.view addBoundingConstraintsToParentForSubview:self.realName
                                                  withSides:[Sides newWithTop:@(280)
                                                                         left:@(0)
                                                                       bottom:nil
                                                                        right:@(0)]];
        
        [self.realName addHeightConstraintWithHeight:kLabelHeight];

        
        // Title
        self.jobTitle = [[UILabel alloc] init];
        self.jobTitle.textColor = [UIColor whiteColor];
        //self.jobTitle.backgroundColor = [UIColor blueColor];
        self.jobTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        self.jobTitle.textAlignment = NSTextAlignmentCenter;
        self.jobTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        self.jobTitle.adjustsFontSizeToFitWidth = YES;
        self.jobTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.jobTitle];
        
        [self.view addBoundingConstraintsToParentForSubview:self.jobTitle
                                                  withSides:[Sides newWithTop:@(310)
                                                                         left:@(0)
                                                                       bottom:nil
                                                                        right:@(0)]];
        [self.jobTitle addHeightConstraintWithHeight:kLabelHeight];
        
        
        // Title
        self.emailAddress = [[UILabel alloc] init];
        self.emailAddress.textColor = [UIColor whiteColor];
        //self.emailAddress.backgroundColor = [UIColor blueColor];
        self.emailAddress.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        self.emailAddress.textAlignment = NSTextAlignmentCenter;
        self.emailAddress.lineBreakMode = NSLineBreakByTruncatingTail;
        self.emailAddress.adjustsFontSizeToFitWidth = YES;
        self.emailAddress.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.emailAddress];
        
        [self.view addBoundingConstraintsToParentForSubview:self.emailAddress
                                                  withSides:[Sides newWithTop:@(350)
                                                                         left:@(0)
                                                                       bottom:nil
                                                                        right:@(0)]];
        [self.emailAddress addHeightConstraintWithHeight:kLabelHeight];
        
        self.constraintsAdded = YES;
    }
}

- (void)_setupDataInView {
    
    self.realName.text = self.viewModel.realName;
    self.jobTitle.text = @"Engineer";//self.viewModel.title;
    self.emailAddress.text = self.viewModel.email;
    
    if (self.viewModel.profilePic) {
        self.profilePic.image = self.viewModel.profilePic;
    }
}

- (void)setupSlackMember:(SlackMemberViewModel *)inViewModel {
    self.viewModel = inViewModel;
}


@end
