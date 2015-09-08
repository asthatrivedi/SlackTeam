//
//  DetailViewController.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "DetailViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "Utils.h"

CGFloat const kLabelHeight = 25;

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *profilePic;
@property (nonatomic, weak) IBOutlet UILabel *realName;
@property (nonatomic, weak) IBOutlet UILabel *jobTitle;
@property (nonatomic, weak) IBOutlet UILabel *emailAddress;

@property (nonatomic, strong) SlackMemberViewModel *viewModel;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.name;
    self.view.backgroundColor = kSystemTintColor;
    
    if (self.profilePic) {
        self.profilePic.layer.cornerRadius = 5.f;
        self.profilePic.clipsToBounds = YES;
    }
    
    [self _setupDataInView];
}

- (void)_setupDataInView {
    
    self.realName.text = self.viewModel.realName;
    self.jobTitle.text = self.viewModel.title;
    self.emailAddress.text = self.viewModel.email;
    
    if (self.viewModel.profilePic) {
        self.profilePic.image = self.viewModel.profilePic;
    }
}

- (void)setupSlackMember:(SlackMemberViewModel *)inViewModel {
    self.viewModel = inViewModel;
}


@end
