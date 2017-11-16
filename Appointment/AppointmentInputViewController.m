#import "AppointmentInputViewController.h"
#import "GoogleGeocodeAPI.h"

@implementation AppointmentInputViewController

@synthesize appointment;

// MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (@available(iOS 11.0, *)) {
		self.navigationController.navigationBar.prefersLargeTitles = YES;
	}
	
	self.view.tintColor = FlatTeal;
	self.view.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0];
	
	petsArray = @[@"Yes", @"No", @"Some"];
	
	nameField = [[InputTextField alloc] init];
	emailField = [[InputTextField alloc] init];
	phoneField = [[InputTextField alloc] init];
	timeField = [[InputTextField alloc] init];
	addressField = [[InputTextField alloc] init];
	zipCodeField = [[InputTextField alloc] init];
	neighborhoodField = [[InputTextField alloc] init];
	moveindateField = [[InputTextField alloc] init];
	petsField = [[InputTextField alloc] init];
	priceField = [[InputTextField alloc] init];
	aptsizeField = [[InputTextField alloc] init];
	roomsField = [[InputTextField alloc] init];
	bathsField = [[InputTextField alloc] init];
	
	nameField.placeholder = @" Client Name";
	emailField.placeholder = @" Client Email Address";
	phoneField.placeholder = @" Client Phone Number";
	timeField.placeholder = @" Appointment Time";
	addressField.placeholder = @" Property Address";
	zipCodeField.placeholder = @" Zip/Postal Code";
	neighborhoodField.placeholder = @" City";
	moveindateField.placeholder = @" Move-In Date";
	petsField.placeholder = @" Pets";
	priceField.placeholder = @" Price ($ Per Month)";
	aptsizeField.placeholder = @" Size (Sq. Ft.)";
	roomsField.placeholder = @" Bedrooms";
	bathsField.placeholder = @" Bathrooms";
	
	inputName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputName"]];
	inputEmail = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputEmail"]];
	inputPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputPhone"]];
	inputTime = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputTime"]];
	inputAddress = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputAddress"]];
	inputZip = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputZip"]];
	inputNeighborhood = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputNeighborhood"]];
	inputMoveInDate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputMoveInDate"]];
	inputPets = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputPets"]];
	inputPrice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputPrice"]];
	inputAptSize = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputSize"]];
	inputRooms = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputBedrooms"]];
	inputBaths = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputBaths"]];
	inputNotes = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputNotes"]];
	
	//Set the frame for each pickerview/datepicker
	CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
	petsPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
	petsPicker.delegate = self;
	petsPicker.showsSelectionIndicator = YES;
	
	timePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	moveInPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	
	//Set the inputView for textFields
	timeField.inputView = timePicker;
	moveindateField.inputView = moveInPicker;
	petsField.inputView = petsPicker;
	
	timePicker.minuteInterval = 5;
	timePicker.minimumDate = [NSDate date];
	[timePicker addTarget:self action:@selector(setAppointmentTime:) forControlEvents:UIControlEventValueChanged];
	
	moveInPicker.datePickerMode = UIDatePickerModeDate;
	[moveInPicker addTarget:self action:@selector(setMoveInDate:) forControlEvents:UIControlEventValueChanged];
	
	scrollView = [[UIScrollView alloc] init];
	scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	
	contentView = [[UIView alloc] init];
	contentView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:scrollView];
	[scrollView addSubview:contentView];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																						  target:self
																						  action:@selector(dismissVC)];
	
	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
																		  target:self
																		  action:@selector(saveButtonPressed)];
	
	UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
																		   target:self
																		   action:@selector(clearButtonPressed)];
	
	self.navigationItem.rightBarButtonItems = @[save, clear];
	
	//	Styling and profiling
	[self setUpNotesTextView];
	[self textFieldStylingAndProperties];
	[self imageViewStylingAndProperties];
	
	[self setUpConstraints];
	
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardGesture)]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	if (appointment) {
		nameField.text = appointment.clientName;
		phoneField.text = appointment.clientPhone;
		moveindateField.text = [self moveInDateString:appointment.moveInDate];
		priceField.text = appointment.price;
		neighborhoodField.text = appointment.city;
		aptsizeField.text = appointment.size;
		roomsField.text = appointment.roomsCount;
		bathsField.text = appointment.bathsCount;
		timeField.text = [self appointmentDateString:appointment.appointmentTime];
		addressField.text = appointment.address;
		petsField.text = appointment.pets;
		emailField.text = appointment.clientEmail;
		zipCodeField.text = appointment.zipCode;
		notesTextView.text = appointment.notes;
		
		timePicker.date = appointment.appointmentTime;
		moveInPicker.date = appointment.moveInDate;
		
		self.title = appointment.clientName;
	} else {
		self.title = @"New Appointment";
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)setUpConstraints {
	scrollViewHeightConstraint = [scrollView.heightAnchor constraintEqualToConstant:self.view.frame.size.height];
	[scrollViewHeightConstraint setActive:YES];
	
	[NSLayoutConstraint
	 activateConstraints:@[
						   [scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
						   [scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
						   [scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
						   
						   [contentView.leftAnchor constraintEqualToAnchor:scrollView.leftAnchor],
						   [contentView.topAnchor constraintEqualToAnchor:scrollView.topAnchor],
						   [contentView.rightAnchor constraintEqualToAnchor:scrollView.rightAnchor],
						   [contentView.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor],
						   [contentView.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor],
						   
						   [inputName.leftAnchor constraintEqualToAnchor:contentView.leftAnchor constant:20],
						   [inputName.centerYAnchor constraintEqualToAnchor:nameField.centerYAnchor],
						   
						   [inputEmail.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputEmail.centerYAnchor constraintEqualToAnchor:emailField.centerYAnchor],
						   
						   [inputPhone.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputPhone.centerYAnchor constraintEqualToAnchor:phoneField.centerYAnchor],
						   
						   [inputTime.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputTime.centerYAnchor constraintEqualToAnchor:timeField.centerYAnchor],
						   
						   [inputAddress.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputAddress.centerYAnchor constraintEqualToAnchor:addressField.centerYAnchor],
						   
						   [inputZip.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputZip.centerYAnchor constraintEqualToAnchor:zipCodeField.centerYAnchor],
						   
						   [inputMoveInDate.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputMoveInDate.centerYAnchor constraintEqualToAnchor:moveindateField.centerYAnchor],
						   
						   [inputPets.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputPets.centerYAnchor constraintEqualToAnchor:petsField.centerYAnchor],
						   
						   [inputPrice.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputPrice.centerYAnchor constraintEqualToAnchor:priceField.centerYAnchor],
						   
						   [inputNeighborhood.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputNeighborhood.centerYAnchor constraintEqualToAnchor:neighborhoodField.centerYAnchor],
						   
						   [inputAptSize.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputAptSize.centerYAnchor constraintEqualToAnchor:aptsizeField.centerYAnchor],
						   
						   [inputRooms.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputRooms.centerYAnchor constraintEqualToAnchor:roomsField.centerYAnchor],
						   
						   [inputBaths.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputBaths.centerYAnchor constraintEqualToAnchor:bathsField.centerYAnchor],
						   
						   [inputNotes.leftAnchor constraintEqualToAnchor:inputName.leftAnchor],
						   [inputNotes.centerYAnchor constraintEqualToAnchor:notesTextView.centerYAnchor],
						   
						   [nameField.leftAnchor constraintEqualToAnchor:inputName.rightAnchor constant:20],
						   [nameField.topAnchor constraintEqualToAnchor:contentView.topAnchor constant:20],
						   [nameField.rightAnchor constraintEqualToAnchor:contentView.rightAnchor constant:-20],
						   
						   [emailField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [emailField.topAnchor constraintEqualToAnchor:nameField.bottomAnchor constant:8],
						   [emailField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [phoneField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [phoneField.topAnchor constraintEqualToAnchor:emailField.bottomAnchor constant:8],
						   [phoneField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [timeField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [timeField.topAnchor constraintEqualToAnchor:phoneField.bottomAnchor constant:8],
						   [timeField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [addressField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [addressField.topAnchor constraintEqualToAnchor:timeField.bottomAnchor constant:8],
						   [addressField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [zipCodeField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [zipCodeField.topAnchor constraintEqualToAnchor:addressField.bottomAnchor constant:8],
						   [zipCodeField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [neighborhoodField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [neighborhoodField.topAnchor constraintEqualToAnchor:zipCodeField.bottomAnchor constant:8],
						   [neighborhoodField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [moveindateField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [moveindateField.topAnchor constraintEqualToAnchor:neighborhoodField.bottomAnchor constant:8],
						   [moveindateField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [petsField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [petsField.topAnchor constraintEqualToAnchor:moveindateField.bottomAnchor constant:8],
						   [petsField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [priceField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [priceField.topAnchor constraintEqualToAnchor:petsField.bottomAnchor constant:8],
						   [priceField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [aptsizeField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [aptsizeField.topAnchor constraintEqualToAnchor:priceField.bottomAnchor constant:8],
						   [aptsizeField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [roomsField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [roomsField.topAnchor constraintEqualToAnchor:aptsizeField.bottomAnchor constant:8],
						   [roomsField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [bathsField.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [bathsField.topAnchor constraintEqualToAnchor:roomsField.bottomAnchor constant:8],
						   [bathsField.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   
						   [notesTextView.leftAnchor constraintEqualToAnchor:nameField.leftAnchor],
						   [notesTextView.topAnchor constraintEqualToAnchor:bathsField.bottomAnchor constant:8],
						   [notesTextView.heightAnchor constraintEqualToConstant:200],
						   [notesTextView.rightAnchor constraintEqualToAnchor:nameField.rightAnchor],
						   [notesTextView.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor constant:-20],
						   ]];
}

- (void)keyboardWillShow:(NSNotification *)notification {
	NSDictionary *userInfo = notification.userInfo;
	
	CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
	CGFloat viewHeight = self.view.frame.size.height - keyboardSize.height;
	
	scrollViewHeightConstraint.constant = viewHeight;
	
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	CGFloat viewHeight = self.view.frame.size.height;
	
	scrollViewHeightConstraint.constant = viewHeight;
	
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}

// MARK: - Element Arrays and styling

- (NSArray *)allInputFields {
	return @[nameField, emailField, phoneField, timeField, addressField, zipCodeField, neighborhoodField, moveindateField, petsField, priceField, aptsizeField, roomsField, bathsField, notesTextView];
}

- (NSArray *)allImageViews {
	return @[inputName, inputEmail, inputPhone, inputTime, inputAddress, inputZip, inputNeighborhood, inputMoveInDate, inputPets, inputPrice, inputAptSize, inputRooms, inputBaths, inputNotes];
}

- (void)setUpNotesTextView {
	notesTextView = [[UITextView alloc] init];
	notesTextView.translatesAutoresizingMaskIntoConstraints = NO;
	notesTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	notesTextView.layer.borderWidth = .7;
	notesTextView.layer.cornerRadius = 5;
	notesTextView.layer.backgroundColor = [UIColor whiteColor].CGColor;
	notesTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
	notesTextView.autocapitalizationType = UITextAutocapitalizationTypeWords;
	notesTextView.autocorrectionType = UITextAutocorrectionTypeYes;
	
	[contentView addSubview:notesTextView];
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
	
	for (InputTextField *textField in [self allInputFields]) {
		if ([textField isKindOfClass:[InputTextField class]]) {
			textField.delegate = self;
			textField.inputAccessoryView = toolbar;
			
			[contentView addSubview:textField];
			
			if (textField == emailField) {
				textField.keyboardType = UIKeyboardTypeEmailAddress;
			}
			
			if (textField == phoneField) {
				textField.keyboardType = UIKeyboardTypePhonePad;
			}
			
			if (textField == zipCodeField || textField == aptsizeField || textField == priceField) {
				textField.keyboardType = UIKeyboardTypeNumberPad;
			}
			
			if (textField == roomsField || textField == bathsField) {
				textField.keyboardType = UIKeyboardTypeDecimalPad;
			}
			
			[[textField.heightAnchor constraintEqualToConstant:40] setActive:YES];
		}
	}
	
	notesTextView.inputAccessoryView = toolbar;
}

- (void)imageViewStylingAndProperties {
	for (UIImageView *imageView in [self allImageViews]) {
		imageView.translatesAutoresizingMaskIntoConstraints = NO;
		
		[contentView addSubview:imageView];
		
		[[imageView.heightAnchor constraintEqualToConstant:32] setActive:YES];
		[[imageView.widthAnchor constraintEqualToConstant:32] setActive:YES];
	}
}

// MARK: - Methods

- (void)clearButtonPressed {
	for (InputTextField *textfield in [self allInputFields]) {
		textfield.text = nil;
	}
	
	[[self allInputFields][0] becomeFirstResponder];
}

- (void)dismissKeyboardGesture {
	[self.view endEditing:YES];
}

- (void)backButtonPressed {
	for (UIResponder *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			fieldIndex = [[self allInputFields] indexOfObject:textField];
		}
	}
	
	if (fieldIndex != 0) {
		[[self allInputFields][fieldIndex - 1] becomeFirstResponder];
	} else {
		[[self allInputFields][[self allInputFields].count - 1] becomeFirstResponder];
	}
}

- (void)nextButtonPressed {
	for (UIResponder *textField in [self allInputFields]) {
		if (textField.isFirstResponder) {
			fieldIndex = [[self allInputFields] indexOfObject:textField];
		}
	}
	
	if ([self allInputFields].count - 1 != fieldIndex) {
		[[self allInputFields][fieldIndex + 1] becomeFirstResponder];
	} else {
		[[self allInputFields][0] becomeFirstResponder];
	}
}

// MARK: - Picker Methods

- (NSString *)appointmentDateString:(NSDate *)date {
	static NSDateFormatter *formatter = nil;
	
	if (!formatter) {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"MMMM d, yyyy h:mm aa";
	}
	
	return [formatter stringFromDate:date];
}

- (NSString *)moveInDateString:(NSDate *)date {
	static NSDateFormatter *formatter = nil;
	
	if (!formatter) {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateStyle = NSDateFormatterLongStyle;
	}
	
	return [formatter stringFromDate:date];
}

- (void)setAppointmentTime:(UIDatePicker *)datePicker {
	timeField.text = [self appointmentDateString:datePicker.date];
}

- (void)setMoveInDate:(UIDatePicker *)datePicker {
	moveindateField.text = [self moveInDateString:datePicker.date];
}

// MARK: - Save Methods

- (void)saveButtonPressed {	
	for (InputTextField *textfield in [self allInputFields]) {
		if ((textfield.text).length <= 0) {
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
			
			return;
		}
	}
	
	[self save];
}

- (void)save {
	if (appointment) {
		// if an appointment exists here, we are in editing mode
		// delete the appointment first
		[[AppointmentStore shared] removeAppointment:appointment];
	}
	
	// create new appointment based off whatever is in the textFields
	Appointment *newAppointment = [[AppointmentStore shared] createAppointment];
	
	newAppointment.clientName = nameField.text;
	newAppointment.clientPhone = phoneField.text;
	newAppointment.moveInDate = moveInPicker.date;
	newAppointment.price = priceField.text;
	newAppointment.city = neighborhoodField.text;
	newAppointment.size = aptsizeField.text;
	newAppointment.roomsCount = roomsField.text;
	newAppointment.bathsCount = bathsField.text;
	newAppointment.appointmentTime = timePicker.date;
	newAppointment.address = addressField.text;
	newAppointment.pets = petsField.text;
	newAppointment.clientEmail = emailField.text;
	newAppointment.zipCode = zipCodeField.text;
	newAppointment.notes = notesTextView.text;
	
	// save the appointment
	[[AppointmentStore shared] saveChanges];
	
	[self dismissVC];
}

- (void)dismissVC {
	[self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (pickerView == petsPicker) {
		return petsArray.count;
	} else {
		return 0;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (pickerView == petsPicker) {
		return petsArray[row];
	} else {
		return 0;
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (pickerView == petsPicker) {
		petsField.text = petsArray[row];
	}
}

// MARK: - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.returnKeyType == UIReturnKeyDone) {
		[self.view endEditing:YES];
	}
	
	return ![self setNextResponder:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == zipCodeField) {
		if (zipCodeField.text.length <= 5) {
			[GoogleGeocodeAPI requestCityWithZipCode:zipCodeField.text completionHandler:^(NSString *city) {
				neighborhoodField.text = city;
			}];
		} else {
			NSLog(@"Zip code field is greater than 5, no JSON request");
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
	if (textField == phoneField) {
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

// MARK: - Number styling

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
