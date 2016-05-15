#import "AppointmentInputViewController.h"
#import "BrokersLabItem.h"
#import "BrokersLabItemStore.h"
#import "AppointmentsViewController.h"
#import <ChameleonFramework/Chameleon.h>

@interface AppointmentInputViewController()

@end

@implementation AppointmentInputViewController

@synthesize item, dismissBlock;

const static CGFloat kJVFieldHeight = 40.0f;
const static CGFloat kJVFieldWidth = 300.0f;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view setTintColor: [UIColor flatRedColor]];
	
	bedsBathsArray = [NSArray arrayWithObjects: @"0", @".5", @"1",@"1.5", @"2", @"2.5",@"3", @"3.5", @"4",@"4.5", @"5", @"5.5",@"6", @"6.5", @"7",@"7.5", @"8", @"8.5",@"9", @"9.5", @"10+", nil];
	accessArray = [NSArray arrayWithObjects: @"Doorman", @"Elevator", @"Walkup", nil];
	priceArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"priceArray" ofType: @"plist"]];
	neighborhoodArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"neighborhoodArray" ofType: @"plist"]];
	aptSizeArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"aptSizeArray" ofType: @"plist"]];
	petsArray = [NSArray arrayWithObjects: @"Yes", @"No", @"Some", nil];
	guarantorArray = [NSArray arrayWithObjects: @"Yes", @"No", nil];
	
	//Set the frame for each textfield
	self.nameField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 22, kJVFieldWidth, kJVFieldHeight)];
	self.emailField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 68, kJVFieldWidth, kJVFieldHeight)];
	self.phoneField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 114, kJVFieldWidth, kJVFieldHeight)];
	self.timeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 160, kJVFieldWidth, kJVFieldHeight)];
	self.addressField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 206, kJVFieldWidth, kJVFieldHeight)];
	self.moveindateField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 252, kJVFieldWidth, kJVFieldHeight)];
	self.petsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 298, kJVFieldWidth, kJVFieldHeight)];
	self.priceField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 344, kJVFieldWidth, kJVFieldHeight)];
	self.neighborhoodField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 390, kJVFieldWidth, kJVFieldHeight)];
	self.aptsizeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 436, kJVFieldWidth, kJVFieldHeight)];
	self.roomsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 482, kJVFieldWidth, kJVFieldHeight)];
	self.bathsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 528, kJVFieldWidth, kJVFieldHeight)];
	self.accessField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 574, kJVFieldWidth, kJVFieldHeight)];
	self.guarantorField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 620, kJVFieldWidth, kJVFieldHeight)];
	
	//Set placeholder text for each textfield
	self.nameField.placeholder = @"Client Name";
	self.emailField.placeholder = @"Client Email Address";
	self.phoneField.placeholder = @"Client Phone Number";
	self.timeField.placeholder = @"Appointment Time";
	self.addressField.placeholder = @"Property Address";
	self.moveindateField.placeholder = @"Move-In Date";
	self.petsField.placeholder = @"Pets";
	self.priceField.placeholder = @"Price";
	self.neighborhoodField.placeholder = @"Neighborhood";
	self.aptsizeField.placeholder = @"Apartment Size";
	self.roomsField.placeholder = @"Bedrooms";
	self.bathsField.placeholder = @"Bathrooms";
	self.accessField.placeholder = @"Access";
	self.guarantorField.placeholder = @"Guarantor";
	
	//Image view instances
	self.inputName = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputName"]];
	self.inputEmail = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputEmail"]];
	self.inputPhone = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputPhone"]];
	self.inputTime = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputTime"]];
	self.inputAddress = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputAddress"]];
	self.inputMoveInDate = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputMoveInDate"]];
	self.inputPets = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputPets"]];
	self.inputPrice = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputPrice"]];
	self.inputNeighborhood = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputNeighborhood"]];
	self.inputAptSize = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputSize"]];
	self.inputRooms = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputBedrooms"]];
	self.inputBaths = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputBaths"]];
	self.inputAccess = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputAccess"]];
	self.inputGuarantor = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"inputGuarantor"]];
	
	//Set the frame for each image view
	[self.inputName setFrame: CGRectMake(20.0f, 26.0f, 32, 32)];
	[self.inputEmail setFrame: CGRectMake(20.0f, self.inputName.frame.origin.y+46, 32, 32)];
	[self.inputPhone setFrame: CGRectMake(20.0f, self.inputEmail.frame.origin.y+46, 32, 32)];
	[self.inputTime setFrame: CGRectMake(20.0f, self.inputPhone.frame.origin.y+46, 32, 32)];
	[self.inputAddress setFrame: CGRectMake(20.0f, self.inputTime.frame.origin.y+46, 32, 32)];
	[self.inputMoveInDate setFrame: CGRectMake(20.0f, self.inputAddress.frame.origin.y+46, 32, 32)];
	[self.inputPets setFrame: CGRectMake(20.0f, self.inputMoveInDate.frame.origin.y+46, 32, 32)];
	[self.inputPrice setFrame: CGRectMake(20.0f, self.inputPets.frame.origin.y+46, 32, 32)];
	[self.inputNeighborhood setFrame: CGRectMake(20.0f, self.inputPrice.frame.origin.y+46, 32, 32)];
	[self.inputAptSize setFrame: CGRectMake(20.0f, self.inputNeighborhood.frame.origin.y+46, 32, 32)];
	[self.inputRooms setFrame: CGRectMake(20.0f, self.inputAptSize.frame.origin.y+46, 32, 32)];
	[self.inputBaths setFrame: CGRectMake(20.0f, self.inputRooms.frame.origin.y+46, 32, 32)];
	[self.inputAccess setFrame: CGRectMake(20.0f, self.inputBaths.frame.origin.y+46, 32, 32)];
	[self.inputGuarantor setFrame: CGRectMake(20.0f, self.inputAccess.frame.origin.y+46, 32, 32)];
	
	//Set the frame for each pickerview/datepicker
	self.bathroom_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.pets_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.price_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.access_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.bedroom_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.guarantor_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.neighborhood_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.aptSize_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.time_picker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	self.movein_picker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, 200, 320, 200)];
	
	//Set the inputView for textFields
	[self.neighborhoodField setInputView: self.neighborhood_picker];
	[self.bathsField setInputView: self.bathroom_picker];
	[self.roomsField setInputView: self.bedroom_picker];
	[self.timeField setInputView: self.time_picker];
	[self.moveindateField setInputView: self.movein_picker];
	[self.accessField setInputView: self.access_picker];
	[self.priceField setInputView: self.price_picker];
	[self.aptsizeField setInputView: self.aptSize_picker];
	[self.petsField setInputView: self.pets_picker];
	[self.guarantorField setInputView: self.guarantor_picker];
	
	// Dismiss keyboard on scrollview drag
	self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	
	// Dismiss keyboard on tap
	[self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismissKeyboardGesture)]];
	
	self.time_picker.datePickerMode = UIDatePickerModeDateAndTime;
	self.time_picker.minuteInterval = 5;
	[self.time_picker addTarget: self action: @selector(displayDate: ) forControlEvents: UIControlEventValueChanged];
	
	self.movein_picker.datePickerMode = UIDatePickerModeDate;
	[self.movein_picker addTarget: self action: @selector(displayMoveIn: ) forControlEvents: UIControlEventValueChanged];
	
	[self.scrollView setContentSize: CGSizeMake(320, 682)];
	
	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
																		  target: self
																		  action: @selector(saveFields: )];
	
	UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
																		  target: self
																		  action: @selector(doNotSave)];
	
	UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemTrash
																		   target: self
																		   action: @selector(backToTopButtonPressed: )];
	
	[[self navigationItem] setLeftBarButtonItem: back];
	[[self navigationItem] setRightBarButtonItems: [NSArray arrayWithObjects: save, clear, nil]];
	
	//Styling and profiling
	[self textFieldStylingAndProperties];
	[self pickerStylingAndProperties];
	[self imageViewStylingAndProperties];
}

- (NSArray *)allInputFields {
	return @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.moveindateField, self.petsField, self.priceField, self.neighborhoodField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
}

- (NSArray *)allInputPickers {
	return @[self.bathroom_picker, self.pets_picker, self.price_picker, self.access_picker, self.bedroom_picker, self.guarantor_picker, self.neighborhood_picker, self.aptSize_picker];
}

- (NSArray *)allImageViews {
	return @[self.inputName, self.inputEmail, self.inputPhone, self.inputTime, self.inputAddress, self.inputMoveInDate, self.inputPets, self.inputPrice, self.inputNeighborhood, self.inputAptSize, self.inputRooms, self.inputBaths, self.inputAccess, self.inputGuarantor];
}

- (void)textFieldStylingAndProperties {
	for (UIView *view in [self allInputFields]) {
		view.layer.borderColor = [[UIColor darkGrayColor] CGColor];
		view.layer.borderWidth = .7;
		view.layer.cornerRadius = 5;
		view.layer.backgroundColor = [[UIColor whiteColor] CGColor];
	}
	
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		[textField setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 16]];
		[textField setFloatingLabelFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 11]];
		[textField setFloatingLabelTextColor: [UIColor grayColor]];
		[textField setClearButtonMode: UITextFieldViewModeWhileEditing];
		[textField setAutocapitalizationType: UITextAutocapitalizationTypeWords];
		[textField setReturnKeyType: UIReturnKeyNext];
		[textField setAutocorrectionType: UITextAutocorrectionTypeNo];
		[self.scrollView addSubview: textField];
		[textField setDelegate: self];
		
		if (textField == self.nameField) {
			[textField becomeFirstResponder];
		}
		
		if (textField == self.emailField) {
			[textField setKeyboardType: UIKeyboardTypeEmailAddress];
		}
		
		if (textField == self.phoneField) {
			[textField setKeyboardType: UIKeyboardTypePhonePad];
		}
	}
}

- (void)pickerStylingAndProperties {
	for (UIPickerView *picker in [self allInputPickers]) {
		[picker setDelegate: self];
		[picker setShowsSelectionIndicator: YES];
	}
}

- (void)imageViewStylingAndProperties {
	for (UIImageView *image in [self allImageViews]) {
		[self.scrollView addSubview: image];
	}
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

- (NSString *)formatNumber:(NSString *)mobileNumber {
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"(" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @")" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @" " withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"-" withString: @""];
	mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString: @"+" withString: @""];
	
	NSUInteger length = [mobileNumber length];
	
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
	
	NSUInteger length = [mobileNumber length];
	
	return length;
}

- (IBAction)backToTopButtonPressed:(id)sender {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		[textfield setText: @""];
	}
	[self.nameField becomeFirstResponder];
}

- (void)dismissKeyboardGesture {
	[self.view endEditing: YES];
}

- (IBAction)displayDate:(id)sender {
	NSDate *myDate = self.time_picker.date;
	NSLog(@"%@", self.time_picker.date);
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"MMMM d yyyy h: mm aa"];
	
	NSString *dateAsString = [dateFormat stringFromDate: myDate];
	[self.timeField setText: dateAsString];
}

- (IBAction)displayMoveIn:(id)sender {
	NSDate *myDate = self.movein_picker.date;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle: NSDateFormatterLongStyle];
	NSString *dateAsString = [dateFormatter stringFromDate: myDate];
	[self.moveindateField setText: dateAsString];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	[self.nameField setText: [item itemName]];
	[self.phoneField setText: [item phoneName]];
	[self.moveindateField setText: [item moveindateName]];
	[self.priceField setText: [item priceName]];
	[self.neighborhoodField setText: [item neighborhoodName]];
	[self.aptsizeField setText: [item aptsizeName]];
	[self.roomsField setText: [item roomsName]];
	[self.bathsField setText: [item bathsName]];
	[self.accessField setText: [item accessName]];
	[self.timeField setText: [item timeName]];
	[self.addressField setText: [item addressName]];
	[self.petsField setText: [item petsName]];
	[self.guarantorField setText: [item guarantorName]];
	[self.emailField setText: [item emailName]];
	
	// Change the navigation item to display name of item
	[[self navigationItem] setTitle: [item itemName]];
}

- (IBAction)saveFields:(id)sender {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		if (!([textfield.text length] > 0)) {
			[textfield setText: @"Unavailable"];
		}
	}
	
	[[self navigationController] popViewControllerAnimated: YES];
}

- (void)doNotSave {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (!([textField.text length] > 0)) {
			[[BrokersLabItemStore sharedStore] removeItem: item];
			[self.navigationController popViewControllerAnimated: YES];
			NSLog(@"Not saving appointment.");
		}
		else {
			[self.navigationController popViewControllerAnimated: YES];
			NSLog(@"Saving appointment.");
		}
	}
}

- (id)initForNewItem:(BOOL)isNew {
	self = [super initWithNibName: @"AppointmentInputViewController" bundle: nil];
	
	if (self) {
		if (isNew) {
			
		}
	}
	
	return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	@throw [NSException exceptionWithName: @"Wrong initializer"
								   reason: @"Use initForNewItem: "
								 userInfo: nil];
	
	return nil;
}

- (void)setItem:(BrokersLabItem *)i {
	item = i;
	[[self navigationItem] setTitle: [item itemName]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear: animated];
	
	// Clear first responder
	[[self view] endEditing: YES];
	
	// "Save" changes to item
	[item setItemName: [self.nameField text]];
	[item setPhoneName: [self.phoneField text]];
	[item setMoveindateName: [self.moveindateField text]];
	[item setPriceName: [self.priceField text]];
	[item setNeighborhoodName: [self.neighborhoodField text]];
	[item setAptsizeName: [self.aptsizeField text]];
	[item setRoomsName: [self.roomsField text]];
	[item setBathsName: [self.bathsField text]];
	[item setAccessName: [self.accessField text]];
	[item setTimeName: [self.timeField text]];
	[item setAddressName: [self.addressField text]];
	[item setPetsName: [self.petsField text]];
	[item setGuarantorName: [self.guarantorField text]];
	[item setEmailName: [self.emailField text]];
}

#pragma mark - UIPickerView datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	if (pickerView == self.bathroom_picker) {
		return bedsBathsArray.count;
	}
	
	if (pickerView == self.bedroom_picker) {
		return bedsBathsArray.count;
	}
	
	if (pickerView == self.access_picker) {
		return accessArray.count;
	}
	
	if (pickerView == self.price_picker) {
		return priceArray.count;
	}
	
	if (pickerView == self.neighborhood_picker) {
		return neighborhoodArray.count;
	}
	
	if (pickerView == self.aptSize_picker) {
		return aptSizeArray.count;
	}
	
	if (pickerView == self.pets_picker) {
		return petsArray.count;
	}
	
	if (pickerView == self.guarantor_picker) {
		return guarantorArray.count;
	}
	
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if (pickerView == self.bathroom_picker) {
		return [bedsBathsArray objectAtIndex: row];
	}
	
	if (pickerView == self.bedroom_picker) {
		return [bedsBathsArray objectAtIndex: row];
	}
	
	if (pickerView == self.access_picker) {
		return [accessArray objectAtIndex: row];
	}
	
	if (pickerView == self.price_picker) {
		return [priceArray objectAtIndex: row];
	}
	
	if (pickerView == self.neighborhood_picker) {
		return [neighborhoodArray objectAtIndex: row];
	}
	
	if (pickerView == self.aptSize_picker) {
		return [aptSizeArray objectAtIndex: row];
	}
	
	if (pickerView == self.pets_picker) {
		return [petsArray objectAtIndex: row];
	}
	
	if (pickerView == self.guarantor_picker) {
		return [guarantorArray objectAtIndex: row];
	}
	else {
		return 0;
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (pickerView == self.bathroom_picker) {
		self.bathsField.text = [bedsBathsArray objectAtIndex: row];
	}
	
	if (pickerView == self.bedroom_picker) {
		self.roomsField.text = [bedsBathsArray objectAtIndex: row];
	}
	
	if (pickerView == self.access_picker) {
		self.accessField.text = [accessArray objectAtIndex: row];
	}
	
	if (pickerView == self.price_picker) {
		self.priceField.text = [priceArray objectAtIndex: row];
	}
	
	if (pickerView == self.aptSize_picker) {
		self.aptsizeField.text = [aptSizeArray objectAtIndex: row];
	}
	
	if (pickerView == self.pets_picker) {
		self.petsField.text = [petsArray objectAtIndex: row];
	}
	
	if (pickerView == self.guarantor_picker) {
		self.guarantorField.text = [guarantorArray objectAtIndex: row];
	}
	
	if (pickerView == self.neighborhood_picker) {
		self.neighborhoodField.text = [neighborhoodArray objectAtIndex: row];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.returnKeyType == UIReturnKeyDone) {
		[self.view endEditing: YES];
	}
	
	return [self setNextResponder: textField] ? NO : YES;
}

- (BOOL)setNextResponder:(UITextField *)textField {
	NSInteger indexOfInput = [[self allInputFields] indexOfObject: textField];
	
	if (indexOfInput != NSNotFound && indexOfInput < [self allInputFields].count-1) {
		UIResponder *next = [[self allInputFields] objectAtIndex: (NSUInteger)(indexOfInput+1)];
		
		if ([next canBecomeFirstResponder]) {
			[next becomeFirstResponder];
			
			return YES;
		}
	}
	
	return NO;
}

@end