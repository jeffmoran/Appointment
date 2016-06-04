#import <Foundation/Foundation.h>
#import "AppointmentInputViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface AppointmentsViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end