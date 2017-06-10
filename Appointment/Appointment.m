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
			 @"Bathrooms"];
}

- (NSArray *)appointmentProperties {
	return @[self.clientName,
			 self.clientEmail,
			 self.clientPhone,
			 self.appointmentTime,
			 self.address,
			 self.zipCode,
			 self.city,
			 self.moveInDate,
			 self.pets,
			 [NSString stringWithFormat:@"$%@ Per Month", self.price],
			 [NSString stringWithFormat:@"%@ Sq. Ft.", self.size],
			 self.roomsCount,
			 self.bathsCount];
}

@end
