//
//  AppointmentTableViewCell.m
//  Appointment
//
//  Created by Jeffrey Moran on 6/9/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "AppointmentTableViewCell.h"

@implementation AppointmentTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void)setAppointment:(Appointment *)anAppointment {
	appointment = anAppointment;
	
	[self setUpAppointmentValues];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		[self addSubviews];
		[self setUpConstraints];
	}
	
	return self;
}

- (void)addSubviews {
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	appointmentClientNameLabel = [[UILabel alloc] init];
	appointmentClientNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	appointmentTimeLabel = [[UILabel alloc] init];
	appointmentTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	appointmentAddressLabel = [[UILabel alloc] init];
	appointmentAddressLabel.translatesAutoresizingMaskIntoConstraints = NO;
	appointmentAddressLabel.textColor = [UIColor darkGrayColor];
	appointmentAddressLabel.font = [UIFont systemFontOfSize:15];
	
	[self.contentView addSubview:appointmentClientNameLabel];
	[self.contentView addSubview:appointmentAddressLabel];
	[self.contentView addSubview:appointmentTimeLabel];
}

- (void)setUpConstraints {
	[NSLayoutConstraint
	 activateConstraints:@[
						   [appointmentClientNameLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant: 15],
						   [appointmentClientNameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant: 5],
						   [appointmentClientNameLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant: -15],
						   
						   [appointmentTimeLabel.leftAnchor constraintEqualToAnchor:appointmentClientNameLabel.leftAnchor],
						   [appointmentTimeLabel.topAnchor constraintEqualToAnchor:appointmentClientNameLabel.bottomAnchor constant: 5],
						   [appointmentTimeLabel.rightAnchor constraintEqualToAnchor:appointmentClientNameLabel.rightAnchor],
						   
						   [appointmentAddressLabel.leftAnchor constraintEqualToAnchor:appointmentClientNameLabel.leftAnchor],
						   [appointmentAddressLabel.topAnchor constraintEqualToAnchor:appointmentTimeLabel.bottomAnchor constant: 5],
						   [appointmentAddressLabel.rightAnchor constraintEqualToAnchor:appointmentClientNameLabel.rightAnchor],
						   [appointmentAddressLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -5],
						   ]];
}

- (void)setUpAppointmentValues {
	appointmentClientNameLabel.text = !([appointment.clientName isEqualToString:@""]) ? appointment.clientName : @"Client name unavailable";
	
	appointmentAddressLabel.text = !([appointment.address isEqualToString:@""]) ? [NSString stringWithFormat:@"%@ %@", appointment.address, appointment.zipCode] : @"Property address unavailable";
	
	appointmentTimeLabel.text = appointment.appointmentTime ? appointment.appointmentDateString : @"Appointment time unavailable";
	
	self.backgroundColor = appointment.appointmentTime.timeIntervalSinceNow < 0.0 ? [UIColor colorWithRed:255.0 / 255.0 green:0.0 blue:0.0 alpha:0.1] : [UIColor whiteColor];
}

@end
