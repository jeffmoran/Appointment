#import "AppointmentStore.h"

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
		[self setUpContext];
	}
	
	return self;
}

- (void)setUpContext {
	model = [NSManagedObjectModel mergedModelFromBundles:nil];
	
	NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
	
	NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	
	NSURL *storeURL = [NSURL fileURLWithPath:[documentDirectory stringByAppendingPathComponent:@"store.data"]];
	
	NSError *error = nil;
	
	if (![psc addPersistentStoreWithType:NSSQLiteStoreType
						   configuration:nil
									 URL:storeURL
								 options:@{NSMigratePersistentStoresAutomaticallyOption:@ YES, NSInferMappingModelAutomaticallyOption:@ YES}
								   error: &error]) {
		
		[NSException raise: @"Open failed" format:@"Reason: %@", error.localizedDescription];
	}
	
	objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	objectContext.persistentStoreCoordinator = psc;
}

- (void)saveChanges {
	NSError *error = nil;
	
	if (objectContext.hasChanges) {
		[objectContext save:&error];
		[objectContext performBlockAndWait:^{
			if (error) {
				NSLog(@"Error saving: %@", error.localizedDescription);
			}
		}];
	}
}

- (void)removeAppointment:(Appointment *)appointment {
	[objectContext deleteObject:appointment];
}

- (void)removeAllAppointments {
	NSArray *stores = objectContext.persistentStoreCoordinator.persistentStores;
	
	for (NSPersistentStore *store in stores) {
		[objectContext.persistentStoreCoordinator removePersistentStore:store error:nil];
		[[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
	}
	
	[self setUpContext];
}

- (NSArray *)allAppointments {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity = model.entitiesByName[@"Appointment"];
	request.entity = entity;
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"appointmentTime" ascending:YES];
	request.sortDescriptors = @[sortDescriptor];
	
	NSError *error;
	NSArray *result = [objectContext executeFetchRequest:request error:&error];
	
	if (!result) {
		[NSException raise:@"Fetch failed" format:@"Reason: %@", error.localizedDescription];
	}
	
	return [[NSMutableArray alloc] initWithArray:result];
}

- (Appointment *)createAppointment {
	Appointment *newAppointment = [NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:objectContext];
	
	return newAppointment;
}

@end
