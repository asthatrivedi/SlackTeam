//
//  TeamTableViewController.m
//  SlackTeam
//
//  Created by Trivedi, Astha on 05/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "TeamTableViewController.h"

@interface TeamTableViewController ()

@end

NSString * const kTeamMemberCellIdentifier = @"teamMemberCell";
NSString * const kSegueDetailIdentifier = @"pushDetail";

@implementation TeamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Slack Team";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamMemberCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"test";
    
    return cell;
}

#pragma mark - Table view delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kSegueDetailIdentifier sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
