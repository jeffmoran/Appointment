//
//  AppointmentTableViewCell.m
//  Appointment
//
//  Created by Jeffrey Moran on 6/9/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "AppointmentTableViewCell.h"

@implementation AppointmentTableViewCell

@synthesize appointment;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)init {
	self = [super init];

	if (self) {
		[self addSubviews];
		[self setUpConstraints];
	}

	return self;
}

- (void)addSubviews {
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
	if (!([appointment.clientName isEqualToString:@""])) {
		appointmentClientNameLabel.text = appointment.clientName;
	} else {
		appointmentClientNameLabel.text = @"Client name unavailable";
	}

	if (!([appointment.address isEqualToString:@""])) {
		appointmentAddressLabel.text = [NSString stringWithFormat:@"%@ %@", appointment.address, appointment.zipCode];
	} else {
		appointmentAddressLabel.text = @"Property address unavailable";
	}

	if (appointment.appointmentTime) {
		appointmentTimeLabel.text = appointment.appointmentDateString;
	} else {
		appointmentTimeLabel.text = @"Appointment time unavailable";
	}
}

@end
