//
//  SettingsViewController.m
//  Appointment
//
//  Created by Jeff Moran on 6/9/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"Settings";

	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
																			  style:UIBarButtonItemStyleDone
																			 target:self
																			 action:@selector(dismissVC)];
}

- (void)dismissVC {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"appointmentDetailCellIdentifier";

	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	cell.textLabel.text = @"Delete all appointments";

	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Settings";
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	[self removeAllAppointments];
}

// MARK: - Functions

- (void)removeAllAppointments {
	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:@"Are you sure?"
										  message:@"All your appointments will be removed."
										  preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
		[[AppointmentStore shared] removeAllAppointments];
	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:yesAction];
	[alertController addAction:cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];
}

@end
