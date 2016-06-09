#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BrokersLabItem;

@interface BrokersLabItemStore : NSObject {
    NSMutableArray *allItems;
    NSManagedObjectContext *objectContext;
    NSManagedObjectModel *model;
}

+ (BrokersLabItemStore *)sharedStore;

- (void)removeItem:(BrokersLabItem *)p;

- (NSArray *)allItems;

- (BrokersLabItem *)createItem;

//- (void)moveItemAtIndex:(NSInteger)from
//                toIndex:(NSInteger)to;

- (NSString *)itemArchivePath;

- (BOOL)saveChanges;

- (void)loadAllItems;

@end
