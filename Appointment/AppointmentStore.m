#import "AppointmentStore.h"
#import "Appointment.h"

@implementation AppointmentStore

+ (AppointmentStore *)shared {
	static AppointmentStore *shared = nil;

	@synchronized(self) {
		if (shared == nil) {
			shared = [[self alloc] init];
		}
	}

	return shared;
}

- (instancetype)init {
	self = [super init];
	
	if (self) {
		NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles: nil];
		
		NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];

		NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

		NSURL *storeURL = [NSURL fileURLWithPath: [documentDirectory stringByAppendingPathComponent:@"store.data"]];
		
		NSError *error = nil;
		
		if (![psc addPersistentStoreWithType:NSSQLiteStoreType
							   configuration: nil
										 URL: storeURL
									 options:@{NSMigratePersistentStoresAutomaticallyOption:@ YES, NSInferMappingModelAutomaticallyOption:@ YES}
									   error: &error]) {

			[NSException raise: @"Open failed" format:@"Reason: %@", error.localizedDescription];
		}
		
		objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
		objectContext.persistentStoreCoordinator = psc;
		
		[self loadAllAppointments: model];
	}
	
	return self;
}

- (void)loadAllAppointments:(NSManagedObjectModel *)model {
	if (!allAppointments) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		
		NSEntityDescription *entity = model.entitiesByName[@"Appointment"];
		request.entity = entity;
		
		//	NSSortDescriptor *sortDescriptor = [NSSortDescriptor
		//										sortDescriptorWithKey: @"orderingValue"
		//										ascending: YES];
		//request.sortDescriptors = @[sortDescriptor];
		
		NSError *error;
		NSArray *result = [objectContext executeFetchRequest: request error:&error];
		
		if (!result) {
			[NSException raise: @"Fetch failed"
						format:@"Reason: %@", error.localizedDescription];
		}
		
		allAppointments = [[NSMutableArray alloc] initWithArray: result];
	}
}

- (void)saveChanges {
	NSError *err = nil;

	if ([objectContext hasChanges]) {
		[objectContext save: &err];
		[objectContext performBlockAndWait: ^{
			if (err) {
				NSLog(@"Error saving: %@", err.localizedDescription);
			}
		}];
	}
}

- (void)removeAppointment:(Appointment *)appointment {
	[objectContext deleteObject: appointment];
	[allAppointments removeObjectIdenticalTo: appointment];
}

- (NSArray *)allAppointments {
	return allAppointments;
}

- (Appointment *)createAppointment {
	Appointment *newAppointment = [NSEntityDescription insertNewObjectForEntityForName: @"Appointment" inManagedObjectContext: objectContext];
	
	[allAppointments addObject: newAppointment];
	
	return newAppointment;
}

@end
