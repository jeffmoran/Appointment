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
		
		[self loadAllItems: model];
	}
	
	return self;
}

- (void)loadAllItems:(NSManagedObjectModel *)model {
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
	NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

	return [documentDirectory stringByAppendingPathComponent:@"store.data"];
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
	[allItems removeObjectIdenticalTo: appointment];
}

- (NSArray *)allItems {
	return allItems;
}

- (Appointment *)createItem {
	Appointment *newItem = [NSEntityDescription insertNewObjectForEntityForName: @"Appointment" inManagedObjectContext: objectContext];
	
	[allItems addObject: newItem];
	
	return newItem;
}

@end
