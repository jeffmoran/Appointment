#import "AppointmentsViewController.h"
#import "AppointmentStore.h"
#import "Appointment.h"
#import "AppointmentCell.h"
#import "MapViewController.h"
#import "AppointmentDetailViewController.h"

@implementation AppointmentsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Appointments";

	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																						   target:self
																						   action:@selector(addNewAppointment)];
	
	self.tableView.allowsSelectionDuringEditing = YES;
	
	self.tableView.emptyDataSetSource = self;
	self.tableView.emptyDataSetDelegate = self;
	self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	//Added short timer so that DZNEmptyDataSet was properly centered on load
	[NSTimer scheduledTimerWithTimeInterval:.01
									 target:self
								   selector:@selector(reloadData)
								   userInfo:nil
									repeats:NO];
	
}

- (void)reloadData {
	[self.tableView reloadData];
}

#pragma mark - Add new appointment

- (void)addNewAppointment {
	AppointmentInputViewController *inputViewController = [[AppointmentInputViewController alloc] init];

	[self.navigationController pushViewController:inputViewController animated:YES];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"Clean"]) {
		
		AppointmentDetailViewController *destViewController = segue.destinationViewController;
		
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

		destViewController.appointment = [[AppointmentStore shared] allAppointments][indexPath.row];
	}
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.tableView.editing) {
		AppointmentInputViewController *detailViewController = [[AppointmentInputViewController alloc] init];
		
		NSArray *items = [[AppointmentStore shared] allAppointments];
		Appointment *selectedItem = items[indexPath.row];
		detailViewController.appointment = selectedItem;

		[self.navigationController pushViewController:detailViewController animated:YES];
	} else {
		[self performSegueWithIdentifier:@"Clean" sender:[tableView cellForRowAtIndexPath:indexPath]];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[AppointmentStore shared] allAppointments].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"appointmentCellIdentifier";

	Appointment *appointment = [[AppointmentStore shared] allAppointments][indexPath.row];
	
	AppointmentCell *cell = (AppointmentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!([appointment.itemName isEqualToString:@""])) {
		cell.nameLabel.text = appointment.itemName;
	} else {
		cell.nameLabel.text = @"Client name unavailable";
	}
	
	if (!([appointment.timeName isEqualToString:@""])) {
		cell.timeLabel.text = appointment.timeName;
	} else {
		cell.timeLabel.text = @"Appointment time unavailable";
	}
	
	if (!([appointment.addressName isEqualToString:@""])) {
		cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@", appointment.addressName, appointment.zipName];
	} else {
		cell.addressLabel.text = @"Property address unavailable";
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[AppointmentStore shared] allAppointments].count == 0) {
		return @"";
	} else if ([[AppointmentStore shared] allAppointments].count == 1) {
		return @"1 Appointment";
	} else {
		return [NSString stringWithFormat:@"%lu Appointments", (unsigned long)[[AppointmentStore shared] allAppointments].count];

	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		Appointment *appointment = [[AppointmentStore shared] allAppointments][indexPath.row];
		[[AppointmentStore shared] removeAppointment:appointment];

		[self.tableView beginUpdates];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[self.tableView endUpdates];

		[self.tableView reloadData];
	}
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

@end
