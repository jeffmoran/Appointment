#import "AppointmentStore.h"
#import "Appointment.h"

@implementation AppointmentStore

+ (AppointmentStore *)sharedStore {
	static AppointmentStore *sharedStore = nil;
	
	if (!sharedStore) {
		sharedStore = [[super allocWithZone: nil] init];
	}
	
	return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone {
	return [self sharedStore];
}

- (instancetype)init {
	self = [super init];
	
	if (self) {
		model = [NSManagedObjectModel mergedModelFromBundles: nil];
		
		NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
		
		NSURL *storeURL = [NSURL fileURLWithPath: [self itemArchivePath]];
		
		NSError *error = nil;
		
		if (![psc addPersistentStoreWithType:NSSQLiteStoreType
							   configuration: nil
										 URL: storeURL
									 options:@{NSMigratePersistentStoresAutomaticallyOption:@ YES, NSInferMappingModelAutomaticallyOption:@ YES}
									   error: &error]) {
			[NSException raise: @"Open failed"
						format:@"Reason: %@", error.localizedDescription];
		}
		
		// Create the managed object context
		objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
		objectContext.persistentStoreCoordinator = psc;
		
		// The managed object context can manage undo, but we don't need it
		[objectContext setUndoManager: nil];
		
		[self loadAllItems];
	}
	
	return self;
}

- (void)loadAllItems {
	if (!allItems) {
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
		
		allItems = [[NSMutableArray alloc] initWithArray: result];
	}
}

- (NSString *)itemArchivePath {
	NSArray *documentDirectories =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
										NSUserDomainMask, YES);
 
	// Get one and only document directory from that list
	NSString *documentDirectory = documentDirectories[0];
	
	return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges {
	NSError *err = nil;
	BOOL successful = [objectContext save: &err];
	
	[objectContext performBlockAndWait: ^{
		if (!successful) {
			NSLog(@"Error saving: %@", err.localizedDescription);
		}
	}];
	
	return successful;
}

- (void)removeItem:(Appointment *)appt {
	[objectContext deleteObject: appt];
	[allItems removeObjectIdenticalTo: appt];
}

- (NSArray *)allItems {
	return allItems;
}

- (Appointment *)createItem {
	Appointment *newItem = [NSEntityDescription insertNewObjectForEntityForName: @"Appointment"
															inManagedObjectContext: objectContext];
	
	[allItems addObject: newItem];
	
	return newItem;
}

@end