#import "AppointmentInputViewController.h"

#import "Config.h"
//Create a file called "Config.h" and add a NSString like so:

//NSString *const googleAPIKey = @"API_KEY_HERE";

@interface AppointmentInputViewController()

@end

@implementation AppointmentInputViewController

@synthesize item;

- (instancetype)initForNewAppointment:(BOOL)isNew {
	self = [super init];
	
	if (self) {
		if (isNew) {
			NSLog(@"NEW ITEM");
		}
	}
	
	return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	const static CGFloat fieldHeight = 40.0f;
	const CGFloat kJVFieldWidth = self.view.frame.size.width - 83.0f;
	const static CGFloat fieldX = 63.0f;
	
	self.view.tintColor = FlatTeal;
	
	accessArray = @[@"Doorman", @"Elevator", @"Walkup"];
	petsArray = @[@"Yes", @"No", @"Some"];
	guarantorArray = @[@"Yes", @"No"];
	
	//Set the frame for each textfield
	self.nameField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 22, kJVFieldWidth, fieldHeight)];
	self.emailField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 68, kJVFieldWidth, fieldHeight)];
	self.phoneField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 114, kJVFieldWidth, fieldHeight)];
	self.timeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 160, kJVFieldWidth, fieldHeight)];
	self.addressField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 206, kJVFieldWidth, fieldHeight)];
	self.zipCodeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 252, kJVFieldWidth, fieldHeight)];
	self.neighborhoodField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 298, kJVFieldWidth, fieldHeight)];
	self.moveindateField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 344, kJVFieldWidth, fieldHeight)];
	self.petsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 390, kJVFieldWidth, fieldHeight)];
	self.priceField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 436, kJVFieldWidth, fieldHeight)];
	self.aptsizeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 482, kJVFieldWidth, fieldHeight)];
	self.roomsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 528, kJVFieldWidth - 104.0 , fieldHeight)];
	self.bathsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 574, kJVFieldWidth - 104.0 , fieldHeight)];
	self.accessField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 620, kJVFieldWidth, fieldHeight)];
	self.guarantorField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(fieldX, 666, kJVFieldWidth, fieldHeight)];
	
	bedroomsStepper = [[UIStepper alloc] initWithFrame:CGRectMake(kJVFieldWidth - 31.0, self.roomsField.frame.origin.y + 20 - 14.5, 0, 0)];
	bedroomsStepper.stepValue = 0.5;
	bedroomsStepper.minimumValue = 0.0;
	
	[bedroomsStepper addTarget:self action:@selector(bedBathStepper:) forControlEvents:UIControlEventValueChanged];
	
	bathroomsStepper = [[UIStepper alloc] initWithFrame:CGRectMake(kJVFieldWidth - 31.0, self.bathsField.frame.origin.y + 20 - 14.5, 0, 0)];
	bathroomsStepper.stepValue = 0.5;
	bathroomsStepper.minimumValue = 0.0;
	
	[bathroomsStepper addTarget:self action:@selector(bedBathStepper:) forControlEvents:UIControlEventValueChanged];
	
	//Set placeholder text for each textfield
	self.nameField.placeholder = @" Client Name";
	self.emailField.placeholder = @" Client Email Address";
	self.phoneField.placeholder = @" Client Phone Number";
	self.timeField.placeholder = @" Appointment Time";
	self.addressField.placeholder = @" Property Address";
	self.zipCodeField.placeholder = @" Zip/Postal Code";
	self.neighborhoodField.placeholder = @" City";
	self.moveindateField.placeholder = @" Move-In Date";
	self.petsField.placeholder = @" Pets";
	self.priceField.placeholder = @" Price ($ Per Month)";
	self.aptsizeField.placeholder = @" Size (Sq. Ft.)";
	self.roomsField.placeholder = @" Bedrooms";
	self.bathsField.placeholder = @" Bathrooms";
	self.accessField.placeholder = @" Access";
	self.guarantorField.placeholder = @" Guarantor";
	
	//Image view instances
	self.inputName = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputName"]];
	self.inputEmail = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputEmail"]];
	self.inputPhone = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputPhone"]];
	self.inputTime = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputTime"]];
	self.inputAddress = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputAddress"]];
	self.inputZip = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputZip"]];
	self.inputNeighborhood = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputNeighborhood"]];
	self.inputMoveInDate = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputMoveInDate"]];
	self.inputPets = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputPets"]];
	self.inputPrice = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputPrice"]];
	self.inputAptSize = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputSize"]];
	self.inputRooms = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputBedrooms"]];
	self.inputBaths = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputBaths"]];
	self.inputAccess = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputAccess"]];
	self.inputGuarantor = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputGuarantor"]];
	
	//Set the frame for each image view
	self.inputName.frame = CGRectMake(20.0f, self.nameField.frame.origin.y + 4, 32, 32);
	self.inputEmail.frame = CGRectMake(20.0f, self.emailField.frame.origin.y + 4, 32, 32);
	self.inputPhone.frame = CGRectMake(20.0f, self.phoneField.frame.origin.y + 4, 32, 32);
	self.inputTime.frame = CGRectMake(20.0f, self.timeField.frame.origin.y + 4, 32, 32);
	self.inputAddress.frame = CGRectMake(20.0f, self.addressField.frame.origin.y + 4, 32, 32);
	self.inputZip.frame = CGRectMake(20.0f, self.zipCodeField.frame.origin.y + 4, 32, 32);
	self.inputMoveInDate.frame = CGRectMake(20.0f, self.moveindateField.frame.origin.y + 4, 32, 32);
	self.inputPets.frame = CGRectMake(20.0f, self.petsField.frame.origin.y + 4, 32, 32);
	self.inputPrice.frame = CGRectMake(20.0f, self.priceField.frame.origin.y + 4, 32, 32);
	self.inputNeighborhood.frame = CGRectMake(20.0f, self.neighborhoodField.frame.origin.y + 4, 32, 32);
	self.inputAptSize.frame = CGRectMake(20.0f, self.aptsizeField.frame.origin.y + 4, 32, 32);
	self.inputRooms.frame = CGRectMake(20.0f, self.roomsField.frame.origin.y + 4, 32, 32);
	self.inputBaths.frame = CGRectMake(20.0f, self.bathsField.frame.origin.y + 4, 32, 32);
	self.inputAccess.frame = CGRectMake(20.0f, self.accessField.frame.origin.y + 4, 32, 32);
	self.inputGuarantor.frame = CGRectMake(20.0f, self.guarantorField.frame.origin.y + 4, 32, 32);
	
	//Set the frame for each pickerview/datepicker
	CGRect pickerFrame = CGRectMake(0, 200, self.view.frame.size.width, 200);
	self.pets_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
	self.access_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
	self.guarantor_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
	self.time_picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	self.movein_picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	
	//Set the inputView for textFields
	self.timeField.inputView = self.time_picker;
	self.moveindateField.inputView = self.movein_picker;
	self.accessField.inputView = self.access_picker;
	self.petsField.inputView = self.pets_picker;
	self.guarantorField.inputView = self.guarantor_picker;
	
	self.time_picker.datePickerMode = UIDatePickerModeDateAndTime;
	self.time_picker.minuteInterval = 5;
	[self.time_picker addTarget: self action: @selector(setAppointmentTime) forControlEvents: UIControlEventValueChanged];
	
	self.movein_picker.datePickerMode = UIDatePickerModeDate;
	[self.movein_picker addTarget: self action: @selector(setMoveInDate) forControlEvents: UIControlEventValueChanged];
	
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
	
	self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.guarantorField.frame.origin.y + self.guarantorField.frame.size.height + 22);
	self.scrollView.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0];
	
	[self.view addSubview:self.scrollView];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
																						  target: self
																						  action: @selector(doNotSave)];
	
	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
																		  target: self
																		  action: @selector(saveButtonPressed)];
	
	UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemTrash
																		   target: self
																		   action: @selector(backToTopButtonPressed)];
	
	self.navigationItem.rightBarButtonItems = @[save, clear];
	
	//	Styling and profiling
	[self textFieldStylingAndProperties];
	[self pickerStylingAndProperties];
	[self imageViewStylingAndProperties];
	
	[self.scrollView addSubview: bedroomsStepper];
	[self.scrollView addSubview: bathroomsStepper];
	
	//	 Dismiss keyboard on tap
	[self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismissKeyboardGesture)]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	
	self.nameField.text = item.itemName;
	self.phoneField.text = item.phoneName;
	self.moveindateField.text = item.moveindateName;
	self.priceField.text = item.priceName;
	self.neighborhoodField.text = item.neighborhoodName;
	self.aptsizeField.text = item.aptsizeName;
	self.roomsField.text = item.roomsName;
	self.bathsField.text = item.bathsName;
	self.accessField.text = item.accessName;
	self.timeField.text = item.timeName;
	self.addressField.text = item.addressName;
	self.petsField.text = item.petsName;
	self.guarantorField.text = item.guarantorName;
	self.emailField.text = item.emailName;
	self.zipCodeField.text = item.zipName;
	
	bedroomsStepper.value = [self.roomsField.text doubleValue];
	bathroomsStepper.value = [self.bathsField.text doubleValue];
	
	// Change the navigation item to display name of item
	self.navigationItem.title = item.itemName;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (self.isEditing) {
		NSLog(@"IS EDITING");
	}
	if (!self.isEditing) {
		NSLog(@"NOT EDITING");
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear: animated];
	
	// Clear first responder
	[self.view endEditing: YES];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Element Arrays and styling

- (NSArray *)allInputFields {
	return @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.zipCodeField, self.neighborhoodField, self.moveindateField, self.petsField, self.priceField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
}

- (NSArray *)allInputPickers {
	return @[self.pets_picker, self.access_picker, self.guarantor_picker];
}

- (NSArray *)allImageViews {
	return @[self.inputName, self.inputEmail, self.inputPhone, self.inputTime, self.inputAddress, self.inputZip, self.inputMoveInDate, self.inputPets, self.inputPrice, self.inputNeighborhood, self.inputAptSize, self.inputRooms, self.inputBaths, self.inputAccess, self.inputGuarantor];
}

- (void)textFieldStylingAndProperties {
	UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
	NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																		   target:self
																		   action:nil];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(backButtonPressed)];
	
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(nextButtonPressed)];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																				target:self
																				action:@selector(dismissKeyboardGesture)];
	
	[toolbarItems addObject:backButton];
	[toolbarItems addObject:nextButton];
	[toolbarItems addObject:space];
	[toolbarItems addObject:doneButton];
	
	[toolbar setItems:toolbarItems];
	
	for (UIView *view in [self allInputFields]) {
		view.layer.borderColor = [UIColor darkGrayColor].CGColor;
		view.layer.borderWidth = .7;
		view.layer.cornerRadius = 5;
		view.layer.backgroundColor = [UIColor whiteColor].CGColor;
	}
	
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		textField.font = [UIFont fontWithName: @"HelveticaNeue-Light" size: 16];
		textField.floatingLabelFont = [UIFont fontWithName: @"HelveticaNeue-Light" size: 11];
		textField.floatingLabelTextColor = [UIColor grayColor];
		textField.clearButtonMode = UITextFieldViewModeAlways;
		textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
		textField.autocorrectionType = UITextAutocorrectionTypeYes;
		textField.delegate = self;
		
		textField.inputAccessoryView = toolbar;
		
		[self.scrollView addSubview: textField];
		
		if (textField == self.emailField) {
			textField.keyboardType = UIKeyboardTypeEmailAddress;
		}
		
		if (textField == self.phoneField) {
			textField.keyboardType = UIKeyboardTypePhonePad;
		}
		
		if (textField == self.zipCodeField || textField == self.aptsizeField || textField == self.priceField) {
			textField.keyboardType = UIKeyboardTypeNumberPad;
		}
		
		if (textField == self.roomsField || textField == self.bathsField){
			textField.keyboardType = UIKeyboardTypeDecimalPad;
		}
	}
}

- (void)pickerStylingAndProperties {
	for (UIPickerView *picker in [self allInputPickers]) {
		picker.delegate = self;
		[picker setShowsSelectionIndicator: YES];
	}
}

- (void)imageViewStylingAndProperties {
	for (UIImageView *image in [self allImageViews]) {
		[self.scrollView addSubview: image];
	}
}

#pragma mark - Methods

- (void)backToTopButtonPressed {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		textfield.text = nil;
	}
	
	bedroomsStepper.value = 0.0;
	bathroomsStepper.value = 0.0;
	
	[self.nameField becomeFirstResponder];
}

- (void)dismissKeyboardGesture {
	[self.view endEditing: YES];
}

- (void)backButtonPressed {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			fieldIndex = [[self allInputFields] indexOfObject:textField];
		}
	}
	
	if (!(fieldIndex == 0)) {
		[[[self allInputFields]objectAtIndex:fieldIndex - 1] becomeFirstResponder];
	}
}

- (void)nextButtonPressed {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			fieldIndex = [[self allInputFields] indexOfObject:textField];
		}
	}
	
	if (!(fieldIndex == 14)) {
		[[[self allInputFields]objectAtIndex:fieldIndex + 1] becomeFirstResponder];
	}
}

- (void)bedBathStepper:(UIStepper *)stepper {
	if (stepper == bedroomsStepper) {
		self.roomsField.text = [NSString stringWithFormat:@"%.1f", bedroomsStepper.value];
	}
	if (stepper == bathroomsStepper) {
		self.bathsField.text = [NSString stringWithFormat:@"%.1f", bathroomsStepper.value];
	}
}

#pragma mark - Picker Methods

- (void)setAppointmentTime{
	NSDate *date = self.time_picker.date;
	
	static NSDateFormatter *dateFormatterAppointmentTime = nil;
	
	if (!dateFormatterAppointmentTime) {
		dateFormatterAppointmentTime =	 [[NSDateFormatter alloc] init];
		dateFormatterAppointmentTime.dateFormat = @"MMMM d, yyyy h:mm aa";
	}
	
	self.timeField.text = [dateFormatterAppointmentTime stringFromDate: date];
}

- (void)setMoveInDate {
	NSDate *date = self.movein_picker.date;
	
	static NSDateFormatter *dateFormatterMoveIn = nil;
	
	if (!dateFormatterMoveIn) {
		dateFormatterMoveIn =	 [[NSDateFormatter alloc] init];
		dateFormatterMoveIn.dateStyle = NSDateFormatterLongStyle;
	}
	
	self.moveindateField.text = [dateFormatterMoveIn stringFromDate: date];
}

#pragma mark - Save Methods

- (void)saveButtonPressed {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		if (!((textfield.text).length > 0)) {
			//textfield.text = @"Unavailable";
			emptyFields = YES;
		}
	}
	
	if (emptyFields) {
		NSLog(@"Empty fields");
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"You left one or more fields empty." preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *save = [UIAlertAction actionWithTitle:@"Save"
													   style:UIAlertActionStyleDefault
													 handler:^(UIAlertAction *action){
														 [self save];
													 }];
		
		UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
														 style:UIAlertActionStyleCancel
													   handler:nil];
		
		[alert addAction:save];
		[alert addAction:cancel];
		
		[self presentViewController:alert animated:YES completion:nil];
	}
	else {
		NSLog(@"No empty fields");
		item.itemName = self.nameField.text;
		item.phoneName = self.phoneField.text;
		item.moveindateName = self.moveindateField.text;
		item.priceName = self.priceField.text;
		item.neighborhoodName = self.neighborhoodField.text;
		item.aptsizeName = self.aptsizeField.text;
		item.roomsName = self.roomsField.text;
		item.bathsName = self.bathsField.text;
		item.accessName = self.accessField.text;
		item.timeName = self.timeField.text;
		item.addressName = self.addressField.text;
		item.petsName = self.petsField.text;
		item.guarantorName = self.guarantorField.text;
		item.emailName = self.emailField.text;
		item.zipName = self.zipCodeField.text;
		
		NSLog(@"Saving appointment.");
		[self.navigationController popViewControllerAnimated: YES];
	}
}

- (void)save {
	item.itemName = self.nameField.text;
	item.phoneName = self.phoneField.text;
	item.moveindateName = self.moveindateField.text;
	item.priceName = self.priceField.text;
	item.neighborhoodName = self.neighborhoodField.text;
	item.aptsizeName = self.aptsizeField.text;
	item.roomsName = self.roomsField.text;
	item.bathsName = self.bathsField.text;
	item.accessName = self.accessField.text;
	item.timeName = self.timeField.text;
	item.addressName = self.addressField.text;
	item.petsName = self.petsField.text;
	item.guarantorName = self.guarantorField.text;
	item.emailName = self.emailField.text;
	item.zipName = self.zipCodeField.text;
	
	NSLog(@"Saving appointment.");
	[self.navigationController popViewControllerAnimated: YES];
}

- (void)doNotSave {
	if (!self.isEditing) {
		NSLog(@"New appointment, not saving");
		[[AppointmentStore sharedStore] removeItem: item];
		[self.navigationController popViewControllerAnimated: YES];
	}
	else {
		NSLog(@"Existing appointment, not saving");
		[self.navigationController popViewControllerAnimated: YES];
	}
}

#pragma mark - URL Request & JSON Parse

- (void)requestURLWithString:(NSString *)urlString {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		
		NSURL *URL = [NSURL URLWithString:urlString];
		NSURLRequest *request = [NSURLRequest requestWithURL: URL
												 cachePolicy: NSURLRequestReturnCacheDataElseLoad
											 timeoutInterval: 60];
		
		NSURLSession *session = [NSURLSession sharedSession];
		NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (error) {
				NSLog(@"%@", error);
				dispatch_async(dispatch_get_main_queue(), ^{
					UIAlertController *errorAlert = [UIAlertController  alertControllerWithTitle:@"Error"
																						 message: @"Could not automatically get neighborhood from zip/postal code. Check your internet connection or input neighborhood manually."
																				  preferredStyle: UIAlertControllerStyleAlert];
					
					UIAlertAction *action = [UIAlertAction
											 actionWithTitle: @"OK"
											 style: UIAlertActionStyleCancel
											 handler:nil];
					
					[errorAlert addAction: action];
					
					[self presentViewController: errorAlert animated:YES completion:nil];
				});
			}
			else {
				[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
				dispatch_async(dispatch_get_main_queue(), ^{
					[self setUpJSONWithData: data];
				});
			}
		}];
		[task resume];
	});
}

- (void)setUpJSONWithData:(NSData *)data {
	NSError *error;
	NSDictionary *mainresponseDict = [NSJSONSerialization JSONObjectWithData: data options:0 error:&error];
	NSDictionary *resultsDict = mainresponseDict[@"results"];
	
	NSArray *addressComponentsDict = [resultsDict valueForKey: @"address_components"][0];
	
	if (error) {
		NSLog(@"Error parsing JSON data - %@", error.localizedDescription);
		UIAlertController *errorAlert = [UIAlertController  alertControllerWithTitle:@"Error"
																			 message: @"Could not automatically get neighborhood from zip/postal code. Check your internet or input neighborhood manually."
																	  preferredStyle: UIAlertControllerStyleAlert];
		
		UIAlertAction *action = [UIAlertAction
								 actionWithTitle: @"OK"
								 style: UIAlertActionStyleCancel
								 handler:nil];
		
		[errorAlert addAction: action];
		
		[self presentViewController: errorAlert animated:YES completion:nil];
	}
	else {
		self.neighborhoodField.text = [addressComponentsDict[1] valueForKey:@"long_name"];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		NSLog(@"NEIGHBORHOOD IS %@", self.neighborhoodField.text);
	}
}

#pragma mark - UIPickerView datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (pickerView == self.access_picker) {
		return accessArray.count;
	}
	
	if (pickerView == self.pets_picker) {
		return petsArray.count;
	}
	
	if (pickerView == self.guarantor_picker) {
		return guarantorArray.count;
	}
	
	else {
		return 0;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (pickerView == self.access_picker) {
		return accessArray[row];
	}
	
	if (pickerView == self.pets_picker) {
		return petsArray[row];
	}
	
	if (pickerView == self.guarantor_picker) {
		return guarantorArray[row];
	}
	
	else {
		return 0;
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (pickerView == self.access_picker) {
		self.accessField.text = accessArray[row];
	}
	
	if (pickerView == self.pets_picker) {
		self.petsField.text = petsArray[row];
	}
	
	if (pickerView == self.guarantor_picker) {
		self.guarantorField.text = guarantorArray[row];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.returnKeyType == UIReturnKeyDone) {
		[self.view endEditing: YES];
	}
	
	return [self setNextResponder: textField] ? NO : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			//works nicely (except iPhone 4S screen size) but needs to be less hardcoded
			if (textField.frame.origin.y >= self.view.frame.size.height - 400) {
				//same here
				CGPoint point = CGPointMake(0, textField.frame.origin.y - 300);
				NSLog(@"Point Height: %f", point.y);
				[self.scrollView setContentOffset:point animated:YES];
			}
		}
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == self.zipCodeField) {
		if (!([self.zipCodeField.text isEqual: @""] || [self.zipCodeField.text isEqualToString:@"Unavailable"])) {
			if (self.zipCodeField.text.length <= 5) {
				[self requestURLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@", self.zipCodeField.text, googleAPIKey]];
			}
			else {
				NSLog(@"Zip code field is greater than or equal to 5, no JSON request");
			}
		}
		else {
			NSLog(@"Zip code field is blank or unavailable, no JSON request");
		}
	}
	
	[self.scrollView setContentOffset: CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
}

- (BOOL)setNextResponder:(UITextField *)textField {
	NSInteger indexOfInput = [[self allInputFields] indexOfObject: textField];
	
	if (indexOfInput != NSNotFound && indexOfInput < [self allInputFields].count-1) {
		UIResponder *next = [self allInputFields][(NSUInteger)(indexOfInput+1)];
		
		if ([next canBecomeFirstResponder]) {
			[next becomeFirstResponder];
			
			return YES;
		}
	}
	
	return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField == self.phoneField) {
		NSUInteger length = [self getLength: textField.text];
		
		if (length == 10) {
			if (range.length == 0) {
				
				return NO;
			}
		}
		
		if (length == 3) {
			NSString *num = [self formatNumber: textField.text];
			textField.text = [NSString stringWithFormat: @"%@-", num];
			
			if (range.length > 0) {
				textField.text = [NSString stringWithFormat: @"%@", [num substringToIndex: 3]];
			}
		}
		else if (length == 6) {
			NSString *num = [self formatNumber: textField.text];
			textField.text = [NSString stringWithFormat: @"%@-%@-", [num  substringToIndex: 3], [num substringFromIndex: 3]];
			
			if (range.length > 0) {
				textField.text = [NSString stringWithFormat: @"(%@) %@", [num substringToIndex: 3], [num substringFromIndex: 3]];
			}
		}
	}
	
	return YES;
}

#pragma mark - Number styling

- (NSString *)formatNumber:(NSString *)mobileNumber {
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"(" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @")" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @" " withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"-" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"+" withString: @""];
	
	NSUInteger length = mobileNumber.length;
	
	if (length > 10) {
		mobileNumber = [mobileNumber substringFromIndex: length-10];
		
	}
	
	return mobileNumber;
}

- (NSUInteger)getLength:(NSString *)mobileNumber {
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"(" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @")" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @" " withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"-" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"+" withString: @""];
	
	NSUInteger length = mobileNumber.length;
	
	return length;
}

@end