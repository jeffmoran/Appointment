#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Appointment;

@interface AppointmentStore : NSObject {
    NSMutableArray *allItems;
    NSManagedObjectContext *objectContext;
}

+ (AppointmentStore *)shared;

- (void)removeAppointment:(Appointment *)appointment;

- (NSArray *)allItems;

- (Appointment *)createItem;

- (void)saveChanges;

- (void)loadAllItems:(NSManagedObjectModel *)model;

@end
