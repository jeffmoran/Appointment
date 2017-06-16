#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Appointment : NSManagedObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSDate *appointmentTime;
@property (nonatomic, strong) NSString *bathsCount;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *clientEmail;
@property (nonatomic, strong) NSString *clientName;
@property (nonatomic, strong) NSString *clientPhone;
@property (nonatomic, strong) NSDate *moveInDate;
@property (nonatomic, strong) NSString *pets;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *roomsCount;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *notes;


- (NSArray *)appointmentPropertiesHeader;
- (NSArray *)appointmentProperties;
- (NSString *)appointmentDateString;
- (NSString *)moveInDateString;
- (NSString *)calendarNotesString;
- (NSString *)emailBodyString;

@end
