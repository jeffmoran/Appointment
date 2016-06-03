#import "AppointmentsViewController.h"
#import "BrokersLabItemStore.h"
#import "BrokersLabItem.h"
#import "BrokersLabItemCell.h"
#import "MapViewController.h"
#import "AppointmentCleanViewController.h"

@implementation AppointmentsViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[self.tableView reloadData];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Appointments";
	
	UINib *nib = [UINib nibWithNibName: @"BrokersLabItemCell" bundle: nil];
	
	[self.tableView registerNib: nib forCellReuseIdentifier: @"BrokersLabItemCell"];
	
	UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
																		 target: self
																		 action: @selector(addNewItem: )];
	
	self.navigationItem.leftBarButtonItem = [self editButtonItem];
	self.navigationItem.rightBarButtonItem = add;
	
	self.tableView.allowsSelectionDuringEditing = YES;
}

#pragma mark - Add new appointment

- (IBAction)addNewItem:(id)sender {
	BrokersLabItem *newItem = [[BrokersLabItemStore sharedStore] createItem];
	
	AppointmentInputViewController *detailViewController = [[AppointmentInputViewController alloc] initForNewItem: YES];
	
	detailViewController.item = newItem;
	
	detailViewController.dismissBlock = ^{
		[self.tableView reloadData];
	};
	
	// Push it onto the top of the navigation controller's stack
	[self.navigationController pushViewController: detailViewController animated: YES];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString: @"Clean"]) {
		
		AppointmentCleanViewController *destViewController = segue.destinationViewController;
		
		NSIndexPath *indexPath = [self.tableView  indexPathForCell: sender];
		BrokersLabItem *s = [[BrokersLabItemStore sharedStore] allItems][indexPath.row];
		
		destViewController.nameString = s.itemName;
		destViewController.timeString = s.timeName;
		destViewController.addressString = s.addressName;
		destViewController.phoneString = s.phoneName;
		destViewController.moveInDateString = s.moveindateName;
		destViewController.priceString = s.priceName;
		destViewController.neighborhoodString = s.neighborhoodName;
		destViewController.aptsizeString = s.aptsizeName;
		destViewController.roomsString = s.roomsName;
		destViewController.bathsString = s.bathsName;
		destViewController.accessString = s.accessName;
		destViewController.petsString = s.petsName;
		destViewController.guarantorString = s.guarantorName;
		destViewController.emailString = s.emailName;
	}
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.tableView.editing == YES) {
		AppointmentInputViewController *detailViewController = [[AppointmentInputViewController alloc] initForNewItem: NO];
		
		NSArray *items = [[BrokersLabItemStore sharedStore] allItems];
		BrokersLabItem *selectedItem = items[indexPath.row];
		detailViewController.item = selectedItem;
		[self.navigationController pushViewController: detailViewController animated: YES];
	}
	else {
		[self performSegueWithIdentifier: @"Clean" sender: [tableView cellForRowAtIndexPath: indexPath]];
	}
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[BrokersLabItemStore sharedStore] allItems].count;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	[[BrokersLabItemStore sharedStore] moveItemAtIndex: fromIndexPath.row
											   toIndex: toIndexPath.row];
	
	[self.tableView beginUpdates];
	[self.tableView reloadData];
	[self.tableView endUpdates];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	BrokersLabItem *s = [[BrokersLabItemStore sharedStore] allItems][indexPath.row];
	
	BrokersLabItemCell *cell = [tableView dequeueReusableCellWithIdentifier: @"BrokersLabItemCell"];
	
	//	[cell setController: self];
	//	[cell setTableView: tableView];
	
	cell.nameLabel.text = s.itemName;
	cell.addressLabel.text = s.addressName;
	cell.timeLabel.text = s.timeName;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"My Appointments";
			break;
		default:
			return @"";
			break;
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	// If the table view is asking to commit a delete command...
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		BrokersLabItemStore *ps = [BrokersLabItemStore sharedStore];
		NSArray *items = [ps allItems];
		BrokersLabItem *p = items[indexPath.row];
		[ps removeItem: p];
		
		// We also remove that row from the table view with an animation
		[tableView deleteRowsAtIndexPaths: @[indexPath]
						 withRowAnimation: UITableViewRowAnimationFade];
		
		[self.tableView beginUpdates];
		[self.tableView reloadData];
		[self.tableView endUpdates];
	}
}

@end