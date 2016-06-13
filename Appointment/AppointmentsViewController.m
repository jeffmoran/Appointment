#import "AppointmentsViewController.h"
#import "AppointmentStore.h"
#import "Appointment.h"
#import "AppointmentCell.h"
#import "MapViewController.h"
#import "AppointmentCleanViewController.h"

@implementation AppointmentsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Appointments";

	self.navigationItem.leftBarButtonItem = [self editButtonItem];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
																						   target: self
																						   action: @selector(addNewAppointment)];
	
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

- (void)addNewAppointment {
	Appointment *newAppointment = [[AppointmentStore sharedStore] createItem];
	
	AppointmentInputViewController *detailViewController = [[AppointmentInputViewController alloc] initForNewItem: YES];
	
	detailViewController.item = newAppointment;
	
	detailViewController.isEditing = NO;
	
	[self.navigationController pushViewController: detailViewController animated: YES];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString: @"Clean"]) {
		
		AppointmentCleanViewController *destViewController = segue.destinationViewController;
		
		NSIndexPath *indexPath = [self.tableView  indexPathForCell: sender];
		Appointment *appointment = [[AppointmentStore sharedStore] allItems][indexPath.row];
		
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
		
		NSArray *items = [[AppointmentStore sharedStore] allItems];
		Appointment *selectedItem = items[indexPath.row];
		detailViewController.item = selectedItem;
		detailViewController.isEditing = YES;
		[self.navigationController pushViewController: detailViewController animated: YES];
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
	return [[AppointmentStore sharedStore] allItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellIdentifier";

	Appointment *s = [[AppointmentStore sharedStore] allItems][indexPath.row];
	
	AppointmentCell *cell = (AppointmentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	NSLog(@"NEW CELL");
	
	if (!([s.itemName isEqualToString: @""])){
		cell.nameLabel.text = s.itemName;
	}
	else {
		cell.nameLabel.text = @"Client name unavailable";
	}
	
	if (!([s.timeName isEqualToString: @""])){
		cell.timeLabel.text = s.timeName;
	}
	else {
		cell.timeLabel.text = @"Appointment time unavailable";
	}
	
	if (!([s.addressName isEqualToString: @""])) {
		cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@", s.addressName, s.zipName];
	}
	else {
		cell.addressLabel.text = @"Property address unavailable";
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if ([[AppointmentStore sharedStore] allItems].count == 0) {
		return 0;
	}
	else if ([[AppointmentStore sharedStore] allItems].count == 1) {
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
				return [NSString stringWithFormat:@"%lu Appointments", (unsigned long)[[AppointmentStore sharedStore] allItems].count];
				break;
			default:
				return @"";
				break;
		}
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		AppointmentStore *itemStore = [AppointmentStore sharedStore];
		NSArray *items = [itemStore allItems];
		Appointment *appointment = items[indexPath.row];
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