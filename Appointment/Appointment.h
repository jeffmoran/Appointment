#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Appointment : NSManagedObject

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *appointmentTime;
@property (nonatomic, retain) NSString *bathsCount;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *clientEmail;
@property (nonatomic, retain) NSString *clientName;
@property (nonatomic, retain) NSString *clientPhone;
@property (nonatomic, retain) NSString *moveInDate;
@property (nonatomic, retain) NSString *pets;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *roomsCount;
@property (nonatomic, retain) NSString *size;
@property (nonatomic, retain) NSString *zipCode;

- (NSArray *)appointmentPropertiesHeader;
- (NSArray *)appointmentProperties;

@end
