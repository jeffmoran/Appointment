#import "AppointmentCleanViewController.h"
#import "MapViewController.h"

@import AddressBook;


@implementation AppointmentCleanViewController

#pragma mark View Lifecycle

- (void) loadView{
	[super loadView];
	
	TKLabelFieldCell *nameField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	nameField.label.text = @"Client\nName";
	nameField.field.text = self.nameString;
	
	TKLabelFieldCell *emailField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	emailField.label.text = @"Client\nEmail";
	emailField.field.text = self.emailString;
	
	TKLabelFieldCell *phoneNumberField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	phoneNumberField.label.text = @"Client\nNumber";
	phoneNumberField.field.text = self.phoneString;
	
	TKLabelFieldCell *timeField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	timeField.label.text = @"Time";
	timeField.field.text = self.timeString;
	
	TKLabelFieldCell *addressField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	addressField.label.text = @"Property\nAddress";
	addressField.field.text = self.addressString;
	addressField.field.adjustsFontSizeToFitWidth = YES;
	
	TKLabelFieldCell *moveInDateField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	moveInDateField.label.text = @"Move-In\nDate";
	moveInDateField.field.text = self.moveInDateString;
	
	TKLabelFieldCell *petsField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	petsField.label.text = @"Pets";
	petsField.field.text = self.petsString;
	
	TKLabelFieldCell *priceField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	priceField.label.text = @"Rent";
	priceField.field.text = self.priceString;
	
	TKLabelFieldCell *neighborhoodField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	neighborhoodField.label.text = @"Location";
	neighborhoodField.field.text = self.neighborhoodString;
	
	TKLabelFieldCell *aptsizeField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	aptsizeField.label.text = @"Apartment\nSize";
	aptsizeField.field.text = self.aptsizeString;
	
	TKLabelFieldCell *roomsField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	roomsField.label.text = @"Bedrooms";
	roomsField.field.text = self.roomsString;
	
	TKLabelFieldCell *bathsField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	bathsField.label.text = @"Bathrooms";
	bathsField.field.text = self.bathsString;
	
	TKLabelFieldCell *accessField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	accessField.label.text = @"Access";
	accessField.field.text = self.accessString;
	
	TKLabelFieldCell *guarantorField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	guarantorField.label.text = @"Guarantor";
	guarantorField.field.text = self.guarantorString;
	
	self.cells = @[nameField,emailField,phoneNumberField,timeField,addressField,moveInDateField,petsField, priceField, neighborhoodField, aptsizeField, roomsField,bathsField, accessField, guarantorField];
}

- (void)viewDidLoad {
	
	[self.tableView setAllowsSelection:NO];
	
	UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain
															target:self
															action:@selector(menu)];
	[[self navigationItem] setRightBarButtonItem:menu];
	[[self navigationItem] setTitle:@"BrokersLab"];
	
	_calendarNotesString = [NSString stringWithFormat:@"Property Address: %@\n\nClient Number: %@\n\nMove-In Date: %@\n\nPets Allowed: %@\n\nProperty Price: %@\n\nNeighborhood: %@\n\nApartment Size: %@\n\nNumber of Bedrooms: %@\n\nNumber of Bathrooms: %@\n\nAccess: %@\n\nGuarantor: %@", self.addressString, self.phoneString, self.moveInDateString, self.petsString, self.priceString, self.neighborhoodString, self.aptsizeString, self.roomsString, self.bathsString, self.accessString, self.guarantorString];
}

- (void) menu {
	[self showGrid];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
	if (itemIndex == 0) {
		[self call];
	}
	if (itemIndex == 1) {
		[self email];
	}
	if (itemIndex == 2) {
		[self map];
	}
	if (itemIndex == 3) {
		[self contact];
	}
	if (itemIndex == 4) {
		[self calendar];
	}
	if (itemIndex == 5) {
		NSLog(@"Menu cancelled.");
	}
}

#pragma mark - Grid

- (void)showGrid {
	NSInteger numberOfOptions = 6;
	NSArray *items = @[
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"phone128"] title:@"Call client"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"email128"] title:@"Email client"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"map128"] title:@"Find on map"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"contact128"] title:@"Add contact"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"calendar128"] title:@"Calendar"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] title:@"Cancel"],
					   ];
	
	RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
	av.delegate = self;
	av.highlightColor = [UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
	//    av.bounces = NO;
	[av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

#pragma mark - Grid methods

- (void)call {
	UIDevice *device = [UIDevice currentDevice];
	if ([[device model] isEqualToString:@"iPhone"] ) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.phoneString]]];
	} else {
		
		UIAlertController *notPermitted = [UIAlertController
											  alertControllerWithTitle:@"Alert"
											  message:@"Your device doesn't support this feature."
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[notPermitted addAction:cancelAction];
		
		[self presentViewController:notPermitted animated:YES completion:nil];
	}
}

- (void)email{
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		
		controller.mailComposeDelegate = self;
		
		[controller setSubject: [NSString stringWithFormat: @"%@ Appointment With %@", self.timeString, self.nameString]];
		
		NSArray *toRecipients = [NSArray arrayWithObjects:self.emailString, nil];
		
		[controller setToRecipients:toRecipients];
		
		NSString *emailBody = @"";
		
		//        NSString *emailBody = [NSString stringWithFormat: @"<b>Client Name:</b><br/>%@  <br/><br/> <b>Appointment Time:</b><br/>%@ <br/><br/> <b>Property Address:</b><br/>%@ <br/><br/> <b>Client Number:</b><br/>%@ <br/><br/> <b>Move-In Date:</b><br/>%@ <br/><br/> <b>Pets Allowed:</b><br/>%@ <br/><br/> <b>Property Price:</b><br/>%@<br/><br/> <b>Neighborhood:</b><br/>%@  <br/><br/> <b>Apartment Size:</b><br/>%@ <br/><br/> <b>Number of Bedrooms:</b><br/>%@ <br/><br/> <b>Number of Bathrooms:</b><br/>%@ <br/><br/> <b>Access:</b><br/>%@ <br/><br/> <b>Guarantor:</b><br/>%@", self.nameString, self.timeString, self.addressString, self.phoneString, self.moveInDateString, self.petsString, self.priceString, self.neighborhoodString, self.aptsizeString, self.roomsString, self.bathsString, self.accessString, self.guarantorString];
		
		[controller setMessageBody:emailBody isHTML:YES];
		
		[self presentViewController:controller animated:YES completion: nil];
	}
	else
	{
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:@"Failure"
											  message:@"Your device doesn't support the composer sheet"
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

-(void)calendar{
	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:@"Add to calendar?"
										  message:@"Would you like to add this appointment to your calendar"
										  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction
								   actionWithTitle:@"Maybe later."
								   style:UIAlertActionStyleCancel
								   handler:^(UIAlertAction *action) {
									   NSLog(@"Cancel action");
								   }];
	
	UIAlertAction *yesAction = [UIAlertAction
								actionWithTitle:@"Yes."
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction *action) {
									NSLog(@"yesAction");
								}];
	
	[alertController addAction:cancelAction];
	[alertController addAction:yesAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)map {
	__weak AppointmentCleanViewController *weakSelf = self;
	NSLog(@"Maps segue");
	[weakSelf performSegueWithIdentifier:@"map" sender:weakSelf];
}

- (void)contact{
	if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
		ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
		//1
		NSLog(@"Denied");
		UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
		[cantAddContactAlert show];
	} else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
		//2
		NSLog(@"Authorized");
		[self newContact];
	} else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
		//3
		NSLog(@"Not determined");
		ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
			dispatch_async(dispatch_get_main_queue(), ^{
				if (!granted){
					//4
					UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
					[cantAddContactAlert show];
					return;
				}
				//5
				[self newContact];
			});
		});
	}
}

- (void)newContact {
	NSString *firstName;
	//NSString *lastName;
	NSString *phoneNumber;
	NSString *emailAddress;
	
	firstName = self.nameString;
	//lastName = @"Cat";
	phoneNumber = self.phoneString;
	emailAddress = self.emailString;
	
	ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
	ABRecordRef contact = ABPersonCreate();
	ABRecordSetValue(contact, kABPersonFirstNameProperty, (__bridge CFStringRef)firstName, nil);
	//ABRecordSetValue(contact, kABPersonLastNameProperty, (__bridge CFStringRef)lastName, nil);
	
	
	ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)phoneNumber, kABPersonPhoneMobileLabel, NULL);
	ABRecordSetValue(contact, kABPersonPhoneProperty, phoneNumbers, nil);
	
	ABMutableMultiValueRef emailAddresses = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(emailAddresses, (__bridge CFStringRef)emailAddress, kABWorkLabel, NULL);
	
	ABRecordSetValue(contact, kABPersonEmailProperty, emailAddresses, nil);
	
	ABAddressBookAddRecord(addressBookRef, contact, nil);
	
	// Check for duplicates
	NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
	for (id record in allContacts){
		ABRecordRef thisContact = (__bridge ABRecordRef)record;
		if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
							ABRecordCopyCompositeName(contact), 0) == kCFCompareEqualTo){
			//The contact already exists!
			UIAlertView *contactExistsAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@ already exists! Please delete or update.", firstName]
																		message:nil
																	   delegate:nil cancelButtonTitle:@"OK"
															  otherButtonTitles: nil];
			[contactExistsAlert show];
			return;
		}
	}
	
	ABAddressBookSave(addressBookRef, nil);
	UIAlertView *contactAddedAlert = [[UIAlertView alloc]initWithTitle:@"Contact Added" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[contactAddedAlert show];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0)
	{
		NSLog(@"LEAD SHARED (OPEN LEADS MAIN)");
		
	}
	if (buttonIndex == 1)
	{
		NSLog(@"LEAD NOT SHARED (OPEN LEADS MAIN)");
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"map"]) {
		MapViewController *destViewController = segue.destinationViewController;
		destViewController.addressName = self.addressString;
	}
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return self.cells[indexPath.row];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 50;
}

#pragma mark - MFMailComposeViewController Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
	
	[self dismissViewControllerAnimated:YES completion: nil];
}

@end