#import <Foundation/Foundation.h>
#import "AppointmentInputViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface AppointmentsViewController : UIViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDataSource, UITableViewDelegate> {
	UIButton *newAppointmentButton;
	UITableView *appointmentsTableView;
}

@end
