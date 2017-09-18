//
//  AppointmentTableViewCell.h
//  Appointment
//
//  Created by Jeffrey Moran on 6/9/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentTableViewCell : UITableViewCell {
	UILabel *appointmentClientNameLabel;
	UILabel *appointmentAddressLabel;
	UILabel *appointmentTimeLabel;
	Appointment *appointment;
}

- (void)setAppointment:(Appointment *)anAppointment;

@end
