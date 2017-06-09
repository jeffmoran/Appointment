#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Appointment;

@interface AppointmentStore : NSObject {
    NSMutableArray *allAppointments;
    NSManagedObjectContext *objectContext;
}

+ (AppointmentStore *)shared;

- (NSArray *)allAppointments;

- (Appointment *)createAppointment;
- (void)removeAppointment:(Appointment *)appointment;

- (void)saveChanges;

@end
