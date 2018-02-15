#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AppointmentStore : NSObject {
	NSManagedObjectModel *model;
	NSManagedObjectContext *objectContext;
}

+ (AppointmentStore *)shared;

@property (nonatomic, readonly, copy) NSArray *allAppointments;
@property (nonatomic, readonly, strong) Appointment *emptyAppointment;

- (void)removeAppointment:(Appointment *)appointment;
- (void)removeAllAppointments;
- (void)saveChanges;

@end
