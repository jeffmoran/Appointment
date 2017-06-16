//
//  AppointmentDetailTableViewCell.m
//  Appointment
//
//  Created by Jeffrey Moran on 6/8/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "AppointmentDetailTableViewCell.h"

@implementation AppointmentDetailTableViewCell

@synthesize appointmentHeaderLabel, appointmentValueLabel;

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
	appointmentHeaderLabel = [[UILabel alloc] init];
	appointmentHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
	appointmentHeaderLabel.numberOfLines = 2;
	appointmentHeaderLabel.adjustsFontSizeToFitWidth = YES;
	appointmentHeaderLabel.textAlignment = NSTextAlignmentRight;
	appointmentHeaderLabel.textColor = [UIColor darkGrayColor];
	appointmentHeaderLabel.font = [UIFont systemFontOfSize:13];

	appointmentValueLabel = [[UILabel alloc] init];
	appointmentValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
	appointmentValueLabel.font = [UIFont boldSystemFontOfSize:18];
	appointmentValueLabel.numberOfLines = 0;

	[self.contentView addSubview:appointmentHeaderLabel];
	[self.contentView addSubview:appointmentValueLabel];
}

- (void)setUpConstraints {
	[NSLayoutConstraint
	 activateConstraints:@[
						   [self.contentView.heightAnchor constraintGreaterThanOrEqualToConstant:50],

						   [appointmentHeaderLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant: 5],
						   [appointmentHeaderLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
						   [appointmentHeaderLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
						   [appointmentHeaderLabel.widthAnchor constraintEqualToConstant:80],

						   [appointmentValueLabel.leftAnchor constraintEqualToAnchor:appointmentHeaderLabel.rightAnchor constant: 5],
						   [appointmentValueLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
						   [appointmentValueLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -5],
						   [appointmentValueLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant: -5]
						   ]];
}

@end
