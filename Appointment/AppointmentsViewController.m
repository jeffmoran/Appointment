#import "AppointmentsViewController.h"
#import "BrokersLabItemStore.h"
#import "BrokersLabItem.h"
#import "BrokersLabItemCell.h"
#import "MapViewController.h"
#import "AppointmentCleanViewController.h"

@implementation AppointmentsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Appointments";
	
	UINib *nib = [UINib nibWithNibName: @"BrokersLabItemCell" bundle: nil];
	
	[self.tableView registerNib: nib forCellReuseIdentifier: @"BrokersLabItemCell"];
	
	self.navigationItem.leftBarButtonItem = [self editButtonItem];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
																						   target: self
																						   action: @selector(addNewAppointment: )];
	
	self.tableView.allowsSelectionDuringEditing = YES;
	
	self.tableView.emptyDataSetSource = self;
	self.tableView.emptyDataSetDelegate = self;
	self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	//Added short timer so that DZNEmptyDataSet was properly centered on load
	[NSTimer scheduledTimerWithTimeInterval: .01
									 target: self
								   selector: @selector(reloadData)
								   userInfo: nil
									repeats: NO];
	
}

- (void)reloadData{
	[self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark - Add new appointment

- (IBAction)addNewAppointment:(id)sender {
	BrokersLabItem *newAppointment = [[BrokersLabItemStore sharedStore] createItem];
	
	AppointmentInputViewController *detailViewController = [[AppointmentInputViewController alloc] initForNewItem: YES];
	
	detailViewController.item = newAppointment;
	
	detailViewController.dismissBlock = ^{
		[self.tableView reloadData];
	};
	
	detailViewController.isEditing = NO;
	
	// Push it onto the top of the navigation controller's stack
	[self.navigationController pushViewController: detailViewController animated: YES];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString: @"Clean"]) {
		
		AppointmentCleanViewController *destViewController = segue.destinationViewController;
		
		NSIndexPath *indexPath = [self.tableView  indexPathForCell: sender];
		BrokersLabItem *appointment = [[BrokersLabItemStore sharedStore] allItems][indexPath.row];
		
		destViewController.nameString = appointment.itemName;
		destViewController.timeString = appointment.timeName;
		destViewController.addressString = appointment.addressName;
		destViewController.zipString = appointment.zipName;
		destViewController.phoneString = appointment.phoneName;
		destViewController.moveInDateString = appointment.moveindateName;
		destViewController.priceString = appointment.priceName;
		destViewController.neighborhoodString = appointment.neighborhoodName;
		destViewController.aptsizeString = appointment.aptsizeName;
		destViewController.roomsString = appointment.roomsName;
		destViewController.bathsString = appointment.bathsName;
		destViewController.accessString = appointment.accessName;
		destViewController.petsString = appointment.petsName;
		destViewController.guarantorString = appointment.guarantorName;
		destViewController.emailString = appointment.emailName;
	}
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.tableView.editing == YES) {
		AppointmentInputViewController *detailViewController = [[AppointmentInputViewController alloc] initForNewItem: NO];
		
		NSArray *items = [[BrokersLabItemStore sharedStore] allItems];
		BrokersLabItem *selectedItem = items[indexPath.row];
		detailViewController.item = selectedItem;
		detailViewController.isEditing = YES;
		[self.navigationController  pushViewController: detailViewController animated: YES];
	}
	else {
		[self performSegueWithIdentifier: @"Clean" sender: [tableView cellForRowAtIndexPath: indexPath]];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[BrokersLabItemStore sharedStore] allItems].count;
}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//	[[BrokersLabItemStore sharedStore] moveItemAtIndex: fromIndexPath.row
//											   toIndex: toIndexPath.row];
//	
//	[self.tableView beginUpdates];
//	[self.tableView reloadData];
//	[self.tableView endUpdates];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	BrokersLabItem *s = [[BrokersLabItemStore sharedStore] allItems][indexPath.row];
	
	BrokersLabItemCell *cell = [tableView dequeueReusableCellWithIdentifier: @"BrokersLabItemCell"];
	
	//	[cell setController: self];
	//	[cell setTableView: tableView];
	
	cell.nameLabel.text = s.itemName;
	cell.addressLabel.text = s.addressName;
	cell.timeLabel.text = s.timeName;
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if ([[BrokersLabItemStore sharedStore] allItems].count == 0) {
		return 0;
	}
	else if ([[BrokersLabItemStore sharedStore] allItems].count == 1) {
		switch (section) {
			case 0:
				return @"1 Appointment";
				break;
			default:
				return @"";
				break;
		}
	}
	else {
		switch (section) {
			case 0:
				return [NSString stringWithFormat:@"%lu Appointments", (unsigned long)[[BrokersLabItemStore sharedStore] allItems].count];
				break;
			default:
				return @"";
				break;
		}
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		BrokersLabItemStore *itemStore = [BrokersLabItemStore sharedStore];
		NSArray *items = [itemStore allItems];
		BrokersLabItem *appointment = items[indexPath.row];
		[itemStore removeItem: appointment];
		
		[tableView deleteRowsAtIndexPaths: @[indexPath]
						 withRowAnimation: UITableViewRowAnimationFade];
		
		[self.tableView beginUpdates];
		[self.tableView reloadData];
		[self.tableView endUpdates];
	}
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return false;
}

#pragma mark - DZNEmptyDataSet

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
	NSString *text = @"No appointments";
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
								 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
	
	return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
	NSString *text = @"Tap on the + button to create a new appointment.";
	
	NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
	paragraph.lineBreakMode = NSLineBreakByWordWrapping;
	paragraph.alignment = NSTextAlignmentCenter;
	
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
								 NSForegroundColorAttributeName: [UIColor lightGrayColor],
								 NSParagraphStyleAttributeName: paragraph};
	
	return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
	return YES;
}

@end