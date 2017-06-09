#import "AppointmentInputViewController.h"
#import "Config.h"
//Create a file called "Config.h" and add a NSString like so:

//NSString *const googleAPIKey = @"API_KEY_HERE";

@implementation AppointmentInputViewController

@synthesize appointment;

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.tintColor = FlatTeal;
	self.view.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0];

	petsArray = @[@"Yes", @"No", @"Some"];

	//Set the frame for each textfield
	self.nameField = [[JVFloatLabeledTextField alloc] init];
	self.emailField = [[JVFloatLabeledTextField alloc] init];
	self.phoneField = [[JVFloatLabeledTextField alloc] init];
	self.timeField = [[JVFloatLabeledTextField alloc] init];
	self.addressField = [[JVFloatLabeledTextField alloc] init];
	self.zipCodeField = [[JVFloatLabeledTextField alloc] init];
	self.neighborhoodField = [[JVFloatLabeledTextField alloc] init];
	self.moveindateField = [[JVFloatLabeledTextField alloc] init];
	self.petsField = [[JVFloatLabeledTextField alloc] init];
	self.priceField = [[JVFloatLabeledTextField alloc] init];
	self.aptsizeField = [[JVFloatLabeledTextField alloc] init];
	self.roomsField = [[JVFloatLabeledTextField alloc] init];
	self.bathsField = [[JVFloatLabeledTextField alloc] init];

	bedroomsStepper = [[UIStepper alloc] init];
	bedroomsStepper.translatesAutoresizingMaskIntoConstraints = NO;
	bedroomsStepper.stepValue = 0.5;
	bedroomsStepper.minimumValue = 0.0;
	
	[bedroomsStepper addTarget:self action:@selector(bedBathStepper:) forControlEvents:UIControlEventValueChanged];
	
	bathroomsStepper = [[UIStepper alloc] init];
	bathroomsStepper.translatesAutoresizingMaskIntoConstraints = NO;
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
	
	//Image view instances
	self.inputName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputName"]];
	self.inputEmail = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputEmail"]];
	self.inputPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputPhone"]];
	self.inputTime = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputTime"]];
	self.inputAddress = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputAddress"]];
	self.inputZip = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputZip"]];
	self.inputNeighborhood = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputNeighborhood"]];
	self.inputMoveInDate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputMoveInDate"]];
	self.inputPets = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputPets"]];
	self.inputPrice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputPrice"]];
	self.inputAptSize = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputSize"]];
	self.inputRooms = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputBedrooms"]];
	self.inputBaths = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputBaths"]];

	//Set the frame for each pickerview/datepicker
	CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
	self.pets_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
	self.time_picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	self.movein_picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	
	//Set the inputView for textFields
	self.timeField.inputView = self.time_picker;
	self.moveindateField.inputView = self.movein_picker;
	self.petsField.inputView = self.pets_picker;

	self.time_picker.datePickerMode = UIDatePickerModeDateAndTime;
	self.time_picker.minuteInterval = 5;
	self.time_picker.minimumDate = [NSDate date];
	[self.time_picker addTarget:self action:@selector(setAppointmentTime:) forControlEvents:UIControlEventValueChanged];
	
	self.movein_picker.datePickerMode = UIDatePickerModeDate;
	[self.movein_picker addTarget:self action:@selector(setMoveInDate:) forControlEvents:UIControlEventValueChanged];
	
	self.scrollView = [[UIScrollView alloc] init];
	self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

	self.contentView = [[UIView alloc] init];
	self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
	 
	[self.view addSubview:self.scrollView];
	[self.scrollView addSubview:self.contentView];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																						  target:self
																						  action:@selector(popViewController)];

	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
																		  target:self
																		  action:@selector(saveButtonPressed)];
	
	UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
																		   target:self
																		   action:@selector(clearButtonPressed)];
	
	self.navigationItem.rightBarButtonItems = @[save, clear];
	
	//	Styling and profiling
	[self textFieldStylingAndProperties];
	[self pickerStylingAndProperties];
	[self imageViewStylingAndProperties];
	
	[self.contentView addSubview:bedroomsStepper];
	[self.contentView addSubview:bathroomsStepper];

	[self setUpConstraints];

	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardGesture)]];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	self.nameField.text = appointment.itemName;
	self.phoneField.text = appointment.phoneName;
	self.moveindateField.text = appointment.moveindateName;
	self.priceField.text = appointment.priceName;
	self.neighborhoodField.text = appointment.neighborhoodName;
	self.aptsizeField.text = appointment.aptsizeName;
	self.roomsField.text = appointment.roomsName;
	self.bathsField.text = appointment.bathsName;
	self.timeField.text = appointment.timeName;
	self.addressField.text = appointment.addressName;
	self.petsField.text = appointment.petsName;
	self.emailField.text = appointment.emailName;
	self.zipCodeField.text = appointment.zipName;

	bedroomsStepper.value = self.roomsField.text.doubleValue;
	bathroomsStepper.value = self.bathsField.text.doubleValue;

	self.title = appointment.itemName;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)setUpConstraints {
	self.scrollViewHeightConstraint = [self.scrollView.heightAnchor constraintEqualToConstant:self.view.frame.size.height];
	[self.scrollViewHeightConstraint setActive:YES];

	[NSLayoutConstraint
	 activateConstraints:@[
						   [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
						   [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
						   [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],

						   [self.contentView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor],
						   [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
						   [self.contentView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor],
						   [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
						   [self.contentView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor],

						   [self.inputName.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:20],
						   [self.inputName.centerYAnchor constraintEqualToAnchor:self.nameField.centerYAnchor],

						   [self.inputEmail.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputEmail.centerYAnchor constraintEqualToAnchor:self.emailField.centerYAnchor],

						   [self.inputPhone.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputPhone.centerYAnchor constraintEqualToAnchor:self.phoneField.centerYAnchor],

						   [self.inputTime.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputTime.centerYAnchor constraintEqualToAnchor:self.timeField.centerYAnchor],

						   [self.inputAddress.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputAddress.centerYAnchor constraintEqualToAnchor:self.addressField.centerYAnchor],

						   [self.inputZip.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputZip.centerYAnchor constraintEqualToAnchor:self.zipCodeField.centerYAnchor],

						   [self.inputMoveInDate.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputMoveInDate.centerYAnchor constraintEqualToAnchor:self.moveindateField.centerYAnchor],

						   [self.inputPets.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputPets.centerYAnchor constraintEqualToAnchor:self.petsField.centerYAnchor],

						   [self.inputPrice.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputPrice.centerYAnchor constraintEqualToAnchor:self.priceField.centerYAnchor],

						   [self.inputNeighborhood.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputNeighborhood.centerYAnchor constraintEqualToAnchor:self.neighborhoodField.centerYAnchor],

						   [self.inputAptSize.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputAptSize.centerYAnchor constraintEqualToAnchor:self.aptsizeField.centerYAnchor],

						   [self.inputRooms.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputRooms.centerYAnchor constraintEqualToAnchor:self.roomsField.centerYAnchor],

						   [self.inputBaths.leftAnchor constraintEqualToAnchor:self.inputName.leftAnchor],
						   [self.inputBaths.centerYAnchor constraintEqualToAnchor:self.bathsField.centerYAnchor],

						   [self.nameField.leftAnchor constraintEqualToAnchor:self.inputName.rightAnchor constant:20],
						   [self.nameField.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20],
						   [self.nameField.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-20],

						   [self.emailField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.emailField.topAnchor constraintEqualToAnchor:self.nameField.bottomAnchor constant:8],
						   [self.emailField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.phoneField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.phoneField.topAnchor constraintEqualToAnchor:self.emailField.bottomAnchor constant:8],
						   [self.phoneField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.timeField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.timeField.topAnchor constraintEqualToAnchor:self.phoneField.bottomAnchor constant:8],
						   [self.timeField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.addressField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.addressField.topAnchor constraintEqualToAnchor:self.timeField.bottomAnchor constant:8],
						   [self.addressField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.zipCodeField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.zipCodeField.topAnchor constraintEqualToAnchor:self.addressField.bottomAnchor constant:8],
						   [self.zipCodeField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.neighborhoodField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.neighborhoodField.topAnchor constraintEqualToAnchor:self.zipCodeField.bottomAnchor constant:8],
						   [self.neighborhoodField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.moveindateField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.moveindateField.topAnchor constraintEqualToAnchor:self.neighborhoodField.bottomAnchor constant:8],
						   [self.moveindateField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.petsField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.petsField.topAnchor constraintEqualToAnchor:self.moveindateField.bottomAnchor constant:8],
						   [self.petsField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.priceField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.priceField.topAnchor constraintEqualToAnchor:self.petsField.bottomAnchor constant:8],
						   [self.priceField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.aptsizeField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.aptsizeField.topAnchor constraintEqualToAnchor:self.priceField.bottomAnchor constant:8],
						   [self.aptsizeField.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],

						   [self.roomsField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.roomsField.topAnchor constraintEqualToAnchor:self.aptsizeField.bottomAnchor constant:8],
						   [self.roomsField.rightAnchor constraintEqualToAnchor:bedroomsStepper.leftAnchor constant: -8],

						   [self.bathsField.leftAnchor constraintEqualToAnchor:self.nameField.leftAnchor],
						   [self.bathsField.topAnchor constraintEqualToAnchor:self.roomsField.bottomAnchor constant:8],
						   [self.bathsField.rightAnchor constraintEqualToAnchor:bathroomsStepper.leftAnchor constant:-8],
						   [self.bathsField.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-20],

						   [bedroomsStepper.centerYAnchor constraintEqualToAnchor:self.roomsField.centerYAnchor],
						   [bedroomsStepper.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],
						   
						   [bathroomsStepper.centerYAnchor constraintEqualToAnchor:self.bathsField.centerYAnchor],
						   [bathroomsStepper.rightAnchor constraintEqualToAnchor:self.nameField.rightAnchor],
						   ]];
}

- (void)keyboardWillShow:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];

	CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

	CGFloat viewHeight = self.view.frame.size.height - keyboardSize.height;

	self.scrollViewHeightConstraint.constant = viewHeight;

	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	CGFloat viewHeight = self.view.frame.size.height;

	self.scrollViewHeightConstraint.constant = viewHeight;

	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}

#pragma mark - Element Arrays and styling

- (NSArray *)allInputFields {
	return @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.zipCodeField, self.neighborhoodField, self.moveindateField, self.petsField, self.priceField, self.aptsizeField, self.roomsField, self.bathsField];
}

- (NSArray *)allInputPickers {
	return @[self.pets_picker];
}

- (NSArray *)allImageViews {
	return @[self.inputName, self.inputEmail, self.inputPhone, self.inputTime, self.inputAddress, self.inputZip, self.inputMoveInDate, self.inputPets, self.inputPrice, self.inputNeighborhood, self.inputAptSize, self.inputRooms, self.inputBaths];
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
	
	toolbar.items = toolbarItems;
	
	for (UIView *view in [self allInputFields]) {
		view.layer.borderColor = [UIColor darkGrayColor].CGColor;
		view.layer.borderWidth = .7;
		view.layer.cornerRadius = 5;
		view.layer.backgroundColor = [UIColor whiteColor].CGColor;
	}
	
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		textField.translatesAutoresizingMaskIntoConstraints = NO;
		textField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
		textField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
		textField.floatingLabelTextColor = [UIColor grayColor];
		textField.clearButtonMode = UITextFieldViewModeAlways;
		textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
		textField.autocorrectionType = UITextAutocorrectionTypeYes;
		textField.delegate = self;

		textField.inputAccessoryView = toolbar;
		
		[self.contentView addSubview:textField];
		
		if (textField == self.emailField) {
			textField.keyboardType = UIKeyboardTypeEmailAddress;
		}
		
		if (textField == self.phoneField) {
			textField.keyboardType = UIKeyboardTypePhonePad;
		}
		
		if (textField == self.zipCodeField || textField == self.aptsizeField || textField == self.priceField) {
			textField.keyboardType = UIKeyboardTypeNumberPad;
		}
		
		if (textField == self.roomsField || textField == self.bathsField) {
			textField.keyboardType = UIKeyboardTypeDecimalPad;
		}

		[[textField.heightAnchor constraintEqualToConstant:40] setActive:YES];
	}
}

- (void)pickerStylingAndProperties {
	for (UIPickerView *picker in [self allInputPickers]) {
		picker.delegate = self;
		[picker setShowsSelectionIndicator:YES];
	}
}

- (void)imageViewStylingAndProperties {
	for (UIImageView *imageView in [self allImageViews]) {
		imageView.translatesAutoresizingMaskIntoConstraints = NO;
		[[imageView.heightAnchor constraintEqualToConstant:32] setActive:YES];
		[[imageView.widthAnchor constraintEqualToConstant:32] setActive:YES];

		[self.contentView addSubview:imageView];
	}
}

#pragma mark - Methods

- (void)clearButtonPressed {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		textfield.text = nil;
	}
	
	bedroomsStepper.value = 0.0;
	bathroomsStepper.value = 0.0;
	
	[self.nameField becomeFirstResponder];
}

- (void)dismissKeyboardGesture {
	[self.view endEditing:YES];
}

- (void)backButtonPressed {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			fieldIndex = [[self allInputFields] indexOfObject:textField];
		}
	}
	
	if (!(fieldIndex == 0)) {
		[[self allInputFields][fieldIndex - 1] becomeFirstResponder];
	}
}

- (void)nextButtonPressed {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			fieldIndex = [[self allInputFields] indexOfObject:textField];
		}
	}

	if (!(fieldIndex == [self allInputFields].count - 1)) {
		[[self allInputFields][fieldIndex + 1] becomeFirstResponder];
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

- (void)setAppointmentTime:(UIDatePicker *)datePicker {
	static NSDateFormatter *dateFormatterAppointmentTime = nil;
	
	if (!dateFormatterAppointmentTime) {
		dateFormatterAppointmentTime = [[NSDateFormatter alloc] init];
		dateFormatterAppointmentTime.dateFormat = @"MMMM d, yyyy h:mm aa";
	}
	
	self.timeField.text = [dateFormatterAppointmentTime stringFromDate:datePicker.date];
}

- (void)setMoveInDate:(UIDatePicker *)datePicker {
	static NSDateFormatter *dateFormatterMoveIn = nil;
	
	if (!dateFormatterMoveIn) {
		dateFormatterMoveIn = [[NSDateFormatter alloc] init];
		dateFormatterMoveIn.dateStyle = NSDateFormatterLongStyle;
	}
	
	self.moveindateField.text = [dateFormatterMoveIn stringFromDate:datePicker.date];
}

#pragma mark - Save Methods

- (void)saveButtonPressed {
	BOOL emptyFields = NO;
	
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		if (!((textfield.text).length > 0)) {
			emptyFields = YES;
		}
	}
	
	if (emptyFields) {
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
	} else {
		[self save];
	}
}

- (void)save {
	if (appointment) {
		// if an appointment exists here, we are in editing mode
		// delete the appointment first
		[[AppointmentStore shared] removeAppointment:appointment];
	}

	// create new appointment based off whatever is in the textFields
	Appointment *newAppointment = [[AppointmentStore shared] createAppointment];

	newAppointment.itemName = self.nameField.text;
	newAppointment.phoneName = self.phoneField.text;
	newAppointment.moveindateName = self.moveindateField.text;
	newAppointment.priceName = self.priceField.text;
	newAppointment.neighborhoodName = self.neighborhoodField.text;
	newAppointment.aptsizeName = self.aptsizeField.text;
	newAppointment.roomsName = self.roomsField.text;
	newAppointment.bathsName = self.bathsField.text;
	newAppointment.timeName = self.timeField.text;
	newAppointment.addressName = self.addressField.text;
	newAppointment.petsName = self.petsField.text;
	newAppointment.emailName = self.emailField.text;
	newAppointment.zipName = self.zipCodeField.text;
	
	// save the appointment
	[[AppointmentStore shared] saveChanges];

	[self.navigationController popViewControllerAnimated:YES];
}

- (void)popViewController {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - URL Request & JSON Parse

- (void)requestURLWithString:(NSString *)urlString {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		
		NSURL *URL = [NSURL URLWithString:urlString];
		NSURLRequest *request = [NSURLRequest requestWithURL:URL
												 cachePolicy:NSURLRequestReturnCacheDataElseLoad
											 timeoutInterval:60];
		
		NSURLSession *session = [NSURLSession sharedSession];
		NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (error) {
				NSLog(@"%@", error);
				dispatch_async(dispatch_get_main_queue(), ^{
					UIAlertController *errorAlert = [UIAlertController  alertControllerWithTitle:@"Error"
																						 message:@"Could not automatically get neighborhood from zip/postal code. Check your internet connection or input neighborhood manually."
																				  preferredStyle:UIAlertControllerStyleAlert];
					
					UIAlertAction *action = [UIAlertAction
											 actionWithTitle:@"OK"
											 style:UIAlertActionStyleCancel
											 handler:nil];
					
					[errorAlert addAction:action];
					
					[self presentViewController:errorAlert animated:YES completion:nil];
				});
			} else {
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
	NSDictionary *mainresponseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

	if (error) {
		NSLog(@"Error parsing JSON data - %@", error.localizedDescription);
		UIAlertController *errorAlert = [UIAlertController  alertControllerWithTitle:@"Error"
																			 message:@"Could not automatically get neighborhood from zip/postal code. Check your internet or input neighborhood manually."
																	  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *action = [UIAlertAction
								 actionWithTitle:@"OK"
								 style:UIAlertActionStyleCancel
								 handler:nil];
		
		[errorAlert addAction:action];
		
		[self presentViewController:errorAlert animated:YES completion:nil];
	} else {
		NSDictionary *resultsDict = mainresponseDict[@"results"];

		NSArray *addressComponentsDict = [resultsDict valueForKey:@"address_components"];

		if (addressComponentsDict.count > 0) {
			self.neighborhoodField.text = [addressComponentsDict[0][1] valueForKey:@"long_name"];
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			NSLog(@"NEIGHBORHOOD IS %@", self.neighborhoodField.text);
		}
	}
}

#pragma mark - UIPickerView datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (pickerView == self.pets_picker) {
		return petsArray.count;
	} else {
		return 0;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (pickerView == self.pets_picker) {
		return petsArray[row];
	} else {
		return 0;
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (pickerView == self.pets_picker) {
		self.petsField.text = petsArray[row];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.returnKeyType == UIReturnKeyDone) {
		[self.view endEditing:YES];
	}
	
	return [self setNextResponder:textField] ? NO :YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == self.zipCodeField) {
		if (!([self.zipCodeField.text isEqual:@""] || [self.zipCodeField.text isEqualToString:@"Unavailable"])) {
			if (self.zipCodeField.text.length <= 5) {
				[self requestURLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@", self.zipCodeField.text, googleAPIKey]];
			} else {
				NSLog(@"Zip code field is greater than or equal to 5, no JSON request");
			}
		} else {
			NSLog(@"Zip code field is blank or unavailable, no JSON request");
		}
	}
}

- (BOOL)setNextResponder:(UITextField *)textField {
	NSInteger indexOfInput = [[self allInputFields] indexOfObject:textField];
	
	if (indexOfInput != NSNotFound && indexOfInput < [self allInputFields].count - 1) {
		UIResponder *next = [self allInputFields][(NSUInteger)(indexOfInput + 1)];
		
		if (next.canBecomeFirstResponder) {
			[next becomeFirstResponder];
			
			return YES;
		}
	}
	
	return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField == self.phoneField) {
		NSUInteger length = [self getLength:textField.text];
		
		if (length == 10) {
			if (range.length == 0) {
				
				return NO;
			}
		}
		
		if (length == 3) {
			NSString *num = [self formatNumber:textField.text];
			textField.text = [NSString stringWithFormat:@"%@-", num];
			
			if (range.length > 0) {
				textField.text = [NSString stringWithFormat:@"%@", [num substringToIndex: 3]];
			}
		} else if (length == 6) {
			NSString *num = [self formatNumber:textField.text];
			textField.text = [NSString stringWithFormat:@"%@-%@-", [num  substringToIndex: 3], [num substringFromIndex: 3]];
			
			if (range.length > 0) {
				textField.text = [NSString stringWithFormat:@"(%@) %@", [num substringToIndex: 3], [num substringFromIndex: 3]];
			}
		}
	}
	
	return YES;
}

#pragma mark - Number styling

- (NSString *)formatNumber:(NSString *)mobileNumber {
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
	
	NSUInteger length = mobileNumber.length;
	
	if (length > 10) {
		mobileNumber = [mobileNumber substringFromIndex:length - 10];
		
	}
	
	return mobileNumber;
}

- (NSUInteger)getLength:(NSString *)mobileNumber {
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
	
	NSUInteger length = mobileNumber.length;
	
	return length;
}

@end
