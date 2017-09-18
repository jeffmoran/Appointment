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

- (void)setAppointment:(Appointment *)anAppointment with:(NSIndexPath *)indexPath;

@end
