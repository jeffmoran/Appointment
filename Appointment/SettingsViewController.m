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
	self.view.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0];

	self.title = @"Settings";

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

@end
