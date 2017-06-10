//
//  AppointmentTableViewCell.h
//  Appointment
//
//  Created by Jeffrey Moran on 6/9/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"

@interface AppointmentTableViewCell : UITableViewCell {
	UILabel *appointmentClientNameLabel;
	UILabel *appointmentAddressLabel;
	UILabel *appointmentTimeLabel;
	Appointment *appointment;
}

@property (nonatomic, strong) Appointment *appointment;

- (void)setUpAppointmentValues;

@end
