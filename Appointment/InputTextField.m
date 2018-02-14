//
//  InputTextField.m
//  Appointment
//
//  Created by Jeff Moran on 6/10/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "InputTextField.h"

@implementation InputTextField

- (instancetype)initWithPlaceholder:(NSString *)placeholder {
	self = [self init];

	if (self) {
		self.placeholder = placeholder;
	}

	return self;
}

- (instancetype)init {
	self = [super init];
	
	if (self) {
		self.translatesAutoresizingMaskIntoConstraints = NO;
		self.layer.borderColor = [UIColor darkGrayColor].CGColor;
		self.layer.borderWidth = .7;
		self.layer.cornerRadius = 5;
		self.layer.backgroundColor = [UIColor whiteColor].CGColor;
		self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
		self.clearButtonMode = UITextFieldViewModeAlways;
		self.autocapitalizationType = UITextAutocapitalizationTypeWords;
		self.autocorrectionType = UITextAutocorrectionTypeYes;
	}
	
	return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
	return CGRectMake(bounds.origin.x + 5, bounds.origin.y, bounds.size.width - 20, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
	return [self textRectForBounds:bounds];
}

@end
