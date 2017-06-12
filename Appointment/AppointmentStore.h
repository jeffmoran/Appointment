#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Appointment;

@interface AppointmentStore : NSObject {
	NSManagedObjectModel *model;
    NSManagedObjectContext *objectContext;
}

+ (AppointmentStore *)shared;

- (NSArray *)allAppointments;

- (Appointment *)createAppointment;
- (void)removeAppointment:(Appointment *)appointment;
- (void)removeAllAppointments;
- (void)saveChanges;

@end
