#import "Appointment.h"

@implementation Appointment

@dynamic address;
@dynamic appointmentTime;
@dynamic bathsCount;
@dynamic city;
@dynamic clientEmail;
@dynamic clientName;
@dynamic clientPhone;
@dynamic moveInDate;
@dynamic pets;
@dynamic price;
@dynamic roomsCount;
@dynamic size;
@dynamic zipCode;
@dynamic notes;

- (NSArray *)appointmentPropertiesHeader {
	return @[@"Client Name",
			 @"Client Email",
			 @"Client Number",
			 @"Time",
			 @"Property Address",
			 @"Zip/Postal Code",
			 @"City",
			 @"Move-In Date",
			 @"Pets",
			 @"Rent",
			 @"Size",
			 @"Bedrooms",
			 @"Bathrooms",
			 @"Notes"];
}

- (NSArray *)appointmentProperties {
	return @[self.clientName,
			 self.clientEmail,
			 self.clientPhone,
			 self.appointmentDateString,
			 self.address,
			 self.zipCode,
			 self.city,
			 self.moveInDateString,
			 self.pets,
			 [NSString stringWithFormat:@"$%@ Per Month", self.price],
			 [NSString stringWithFormat:@"%@ Sq. Ft.", self.size],
			 self.roomsCount,
			 self.bathsCount,
			 self.notes];
}

- (NSString *)appointmentDateString {
	static NSDateFormatter *formatter = nil;
	
	if (!formatter) {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"MMMM d, yyyy h:mm aa";
	}
	
	return [formatter stringFromDate:self.appointmentTime];
}

- (NSString *)moveInDateString {
	static NSDateFormatter *formatter = nil;
	
	if (!formatter) {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateStyle = NSDateFormatterLongStyle;
	}
	
	return [formatter stringFromDate:self.moveInDate];
}

- (NSString *)calendarNotesString {
	NSString *string = [NSString stringWithFormat: @"Property Address: %@ %@\n\nCity: %@\n\nClient Number: %@\n\nMove-In Date: %@\n\nPets Allowed: %@\n\nProperty Price: %@\n\nSize: %@\n\nNumber of Bedrooms: %@\n\nNumber of Bathrooms: %@", self.address, self.zipCode, self.city, self.clientPhone, self.moveInDateString, self.pets, self.price, self.size, self.roomsCount, self.bathsCount];
	
	return string;
}

- (NSString *)emailBodyString {
	NSString *string = [NSString stringWithFormat: @"<b>Client Name:</b><br/>%@  <br/><br/> <b>Client Number:</b><br/>%@ <br/><br/><b>Appointment Time:</b><br/>%@ <br/><br/> <b>Property Address:</b><br/>%@ %@ <br/><br/>  <b>City:</b><br/>%@ <br/><br/><b>Property Price:</b><br/>%@<br/><br/><b>Move-In Date:</b><br/>%@ <br/><br/> <b>Pets Allowed:</b><br/>%@ <br/><br/><b>Size:</b><br/>%@ Sq. Ft.<br/><br/> <b>Number of Bedrooms:</b><br/>%@ <br/><br/> <b>Number of Bathrooms:</b><br/>%@", self.clientName, self.clientPhone, self.appointmentDateString, self.address, self.zipCode, self.city, self.price, self.moveInDateString, self.pets, self.size, self.roomsCount, self.bathsCount];
	
	return string;
}

@end
