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
	
    self.navigationController.navigationBar.prefersLargeTitles = YES;
	
	self.title = @"Settings";
	
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
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
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 1;
		case 1:
			return 1;
		default:
			return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"appointmentDetailCellIdentifier";
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = @"Delete all appointments";
					break;
				default:
					break;
			}
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = @"Sorting";
					cell.detailTextLabel.text = @"Date";
				default:
					break;
			}
			break;
		default:
			break;
	}
	
	return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//	return @"Settings";
//}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0:
					[self removeAllAppointments];
					break;
				default:
					break;
			}
			break;
		case 1:
			switch (indexPath.row) {
				case 0: {
					UIAlertController *alertController = [UIAlertController
														  alertControllerWithTitle:nil
														  message:@"The ascending order in which appointments are sorted."
														  preferredStyle:UIAlertControllerStyleActionSheet];
					
					UIAlertAction *dateAction = [UIAlertAction actionWithTitle:@"Date" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
						
					}];
					
					UIAlertAction *nameAction = [UIAlertAction actionWithTitle:@"Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
						
					}];
					
					UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
					
					[alertController addAction:dateAction];
					[alertController addAction:nameAction];
					[alertController addAction:cancelAction];
					
					[self presentViewController:alertController animated:YES completion:nil];
					break;
				}
				default:
					break;
			}
			break;
		default:
			break;
	}
}

// MARK: - Functions

- (void)removeAllAppointments {
	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:@"Are you sure?"
										  message:@"All your appointments will be removed."
										  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
		[AppointmentStore.shared removeAllAppointments];
	}];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	
	[alertController addAction:yesAction];
	[alertController addAction:cancelAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

@end
