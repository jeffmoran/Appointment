#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Appointment : NSManagedObject

@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, retain) NSString *phoneName;
@property (nonatomic, retain) NSString *moveindateName;
@property (nonatomic, retain) NSString *priceName;
@property (nonatomic, retain) NSString *neighborhoodName;
@property (nonatomic, retain) NSString *aptsizeName;
@property (nonatomic, retain) NSString *roomsName;
@property (nonatomic, retain) NSString *bathsName;
@property (nonatomic, retain) NSString *timeName;
@property (nonatomic, retain) NSString *addressName;
@property (nonatomic, retain) NSString *petsName;
@property (nonatomic, retain) NSString *emailName;
@property (nonatomic, retain) NSString *zipName;

- (NSArray *)appointmentPropertiesHeader;
- (NSArray *)appointmentProperties;

@end
