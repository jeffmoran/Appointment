#import "BrokersLabItemStore.h"
#import "BrokersLabItem.h"

@implementation BrokersLabItemStore

+ (BrokersLabItemStore *)sharedStore {
	static BrokersLabItemStore *sharedStore = nil;
	
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
		
		NSPersistentStoreCoordinator *psc =
		[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
		
		NSString *path = [self itemArchivePath];
		NSURL *storeURL = [NSURL fileURLWithPath: path];
		
		NSError *error = nil;
		
		if (![psc addPersistentStoreWithType:NSSQLiteStoreType
							   configuration: nil
										 URL: storeURL
									 options: nil
									   error: &error]) {
			[NSException raise: @"Open failed"
						format:@"Reason: %@", error.localizedDescription];
		}
		
		// Create the managed object context
		context = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
		context.persistentStoreCoordinator = psc;
		
		// The managed object context can manage undo, but we don't need it
		[context setUndoManager: nil];
		
		[self loadAllItems];
	}
	
	return self;
}

- (void)loadAllItems {
	if (!allItems) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		
		NSEntityDescription *entity = model.entitiesByName[@"BrokersLabItem"];
		request.entity = entity;
		
		NSSortDescriptor *sortDescriptor = [NSSortDescriptor
											sortDescriptorWithKey: @"orderingValue"
											ascending: YES];
		request.sortDescriptors = @[sortDescriptor];
		
		NSError *error;
		NSArray *result = [context executeFetchRequest: request error:&error];
		
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
	BOOL successful = [context save: &err];
	
	[context performBlockAndWait: ^{
		if (!successful) {
			NSLog(@"Error saving: %@", err.localizedDescription);
		}
	}];
	
	return successful;
}

- (void)removeItem:(BrokersLabItem *)p {
	[context deleteObject: p];
	[allItems removeObjectIdenticalTo: p];
}

- (NSArray *)allItems {
	return allItems;
}

//- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to {
//	if (from == to) {
//		return;
//	}
//	
//	NSLog(@"Reordering");
//	// Get pointer to object being moved so we can re-insert it
//	BrokersLabItem *p = allItems[from];
//	
//	// Remove p from array
//	[allItems removeObjectAtIndex: from];
//	
//	// Insert p in array at new location
//	[allItems insertObject: p atIndex:to];
//	
//	NSLog(@"Saving");
//	NSError *err = nil;
//	[context save:&err];
//}

- (BrokersLabItem *)createItem {
	BrokersLabItem *newItem = [NSEntityDescription insertNewObjectForEntityForName: @"BrokersLabItem"
															inManagedObjectContext: context];
	
	[allItems addObject: newItem];
	
	return newItem;
}

@end