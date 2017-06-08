#import "Appointment.h"

@implementation Appointment

@dynamic itemName;
@dynamic emailName;
@dynamic phoneName;
@dynamic timeName;
@dynamic addressName;
@dynamic zipName;
@dynamic neighborhoodName;
@dynamic moveindateName;
@dynamic petsName;
@dynamic priceName;
@dynamic aptsizeName;
@dynamic roomsName;
@dynamic bathsName;

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
	return @[self.itemName,
			 self.emailName,
			 self.phoneName,
			 self.timeName,
			 self.addressName,
			 self.zipName,
			 self.neighborhoodName,
			 self.moveindateName,
			 self.petsName,
			 [NSString stringWithFormat:@"$%@ Per Month", self.priceName],
			 [NSString stringWithFormat:@"%@ Sq. Ft.", self.priceName],
			 self.roomsName,
			 self.bathsName];
}

@end
