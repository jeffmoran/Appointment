//
//  AppointmentDetailTableViewCell.h
//  Appointment
//
//  Created by Jeffrey Moran on 6/8/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentDetailTableViewCell : UITableViewCell {
	UILabel *appointmentHeaderLabel;
	UILabel *appointmentValueLabel;
}

@property (nonatomic, strong) UILabel *appointmentHeaderLabel;
@property (nonatomic, strong) UILabel *appointmentValueLabel;

@end
