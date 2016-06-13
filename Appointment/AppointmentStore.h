#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Appointment;

@interface AppointmentStore : NSObject {
    NSMutableArray *allItems;
    NSManagedObjectContext *objectContext;
    NSManagedObjectModel *model;
}

+ (AppointmentStore *)sharedStore;

- (void)removeItem:(Appointment *)p;

- (NSArray *)allItems;

- (Appointment *)createItem;

//- (void)moveItemAtIndex:(NSInteger)from
//                toIndex:(NSInteger)to;

- (NSString *)itemArchivePath;

- (BOOL)saveChanges;

- (void)loadAllItems;

@end
