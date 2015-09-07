//
//  DetailViewController.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *realName;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;

@property (nonatomic, strong) SlackMemberViewModel *viewModel;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.name;
    
    [self _setupView];
}

- (void)_setupView {
    self.profilePic.image = self.viewModel.profilePic;
    self.displayName.text = self.viewModel.name;
    self.realName.text = self.viewModel.realName;
    self.jobTitle.text = self.viewModel.title;
}

- (void)setupSlackMember:(SlackMemberViewModel *)inViewModel {
    self.viewModel = inViewModel;
}


@end
