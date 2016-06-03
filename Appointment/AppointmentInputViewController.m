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
	
	(self.view).tintColor = [UIColor flatRedColor];
	
	bedsBathsArray = @[@"0", @".5", @"1",@"1.5", @"2", @"2.5",@"3", @"3.5", @"4",@"4.5", @"5", @"5.5",@"6", @"6.5", @"7",@"7.5", @"8", @"8.5",@"9", @"9.5", @"10+"];
	accessArray = @[@"Doorman", @"Elevator", @"Walkup"];
	priceArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"priceArray" ofType: @"plist"]];
	neighborhoodArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"neighborhoodArray" ofType: @"plist"]];
	aptSizeArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"aptSizeArray" ofType: @"plist"]];
	petsArray = @[@"Yes", @"No", @"Some"];
	guarantorArray = @[@"Yes", @"No"];
	
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
	(self.inputName).frame = CGRectMake(20.0f, 26.0f, 32, 32);
	(self.inputEmail).frame = CGRectMake(20.0f, self.inputName.frame.origin.y+46, 32, 32);
	(self.inputPhone).frame = CGRectMake(20.0f, self.inputEmail.frame.origin.y+46, 32, 32);
	(self.inputTime).frame = CGRectMake(20.0f, self.inputPhone.frame.origin.y+46, 32, 32);
	(self.inputAddress).frame = CGRectMake(20.0f, self.inputTime.frame.origin.y+46, 32, 32);
	(self.inputMoveInDate).frame = CGRectMake(20.0f, self.inputAddress.frame.origin.y+46, 32, 32);
	(self.inputPets).frame = CGRectMake(20.0f, self.inputMoveInDate.frame.origin.y+46, 32, 32);
	(self.inputPrice).frame = CGRectMake(20.0f, self.inputPets.frame.origin.y+46, 32, 32);
	(self.inputNeighborhood).frame = CGRectMake(20.0f, self.inputPrice.frame.origin.y+46, 32, 32);
	(self.inputAptSize).frame = CGRectMake(20.0f, self.inputNeighborhood.frame.origin.y+46, 32, 32);
	(self.inputRooms).frame = CGRectMake(20.0f, self.inputAptSize.frame.origin.y+46, 32, 32);
	(self.inputBaths).frame = CGRectMake(20.0f, self.inputRooms.frame.origin.y+46, 32, 32);
	(self.inputAccess).frame = CGRectMake(20.0f, self.inputBaths.frame.origin.y+46, 32, 32);
	(self.inputGuarantor).frame = CGRectMake(20.0f, self.inputAccess.frame.origin.y+46, 32, 32);
	
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
	(self.neighborhoodField).inputView = self.neighborhood_picker;
	(self.bathsField).inputView = self.bathroom_picker;
	(self.roomsField).inputView = self.bedroom_picker;
	(self.timeField).inputView = self.time_picker;
	(self.moveindateField).inputView = self.movein_picker;
	(self.accessField).inputView = self.access_picker;
	(self.priceField).inputView = self.price_picker;
	(self.aptsizeField).inputView = self.aptSize_picker;
	(self.petsField).inputView = self.pets_picker;
	(self.guarantorField).inputView = self.guarantor_picker;
	
	// Dismiss keyboard on scrollview drag
	self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	
	// Dismiss keyboard on tap
	[self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismissKeyboardGesture)]];
	
	self.time_picker.datePickerMode = UIDatePickerModeDateAndTime;
	self.time_picker.minuteInterval = 5;
	[self.time_picker addTarget: self action: @selector(setAppointmentTime) forControlEvents: UIControlEventValueChanged];
	
	self.movein_picker.datePickerMode = UIDatePickerModeDate;
	[self.movein_picker addTarget: self action: @selector(setMoveInDate) forControlEvents: UIControlEventValueChanged];
	
	(self.scrollView).contentSize = CGSizeMake(320, 682);
	
	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
																		  target: self
																		  action: @selector(saveFields: )];
	
	UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
																		  target: self
																		  action: @selector(doNotSave)];
	
	UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemTrash
																		   target: self
																		   action: @selector(backToTopButtonPressed: )];
	
	self.navigationItem.leftBarButtonItem = back;
	self.navigationItem.rightBarButtonItems = @[save, clear];
	
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
		view.layer.borderColor = [UIColor darkGrayColor].CGColor;
		view.layer.borderWidth = .7;
		view.layer.cornerRadius = 5;
		view.layer.backgroundColor = [UIColor whiteColor].CGColor;
	}
	
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		textField.font = [UIFont fontWithName: @"HelveticaNeue-Light" size: 16];
		textField.floatingLabelFont = [UIFont fontWithName: @"HelveticaNeue-Light" size: 11];
		textField.floatingLabelTextColor = [UIColor grayColor];
		textField.clearButtonMode = UITextFieldViewModeWhileEditing;
		textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
		textField.returnKeyType = UIReturnKeyNext;
		textField.autocorrectionType = UITextAutocorrectionTypeNo;
		[self.scrollView addSubview: textField];
		textField.delegate = self;
		
		if (textField == self.nameField) {
			[textField becomeFirstResponder];
		}
		
		if (textField == self.emailField) {
			textField.keyboardType = UIKeyboardTypeEmailAddress;
		}
		
		if (textField == self.phoneField) {
			textField.keyboardType = UIKeyboardTypePhonePad;
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

- (IBAction)backToTopButtonPressed:(id)sender {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		textfield.text = @"";
	}
	[self.nameField becomeFirstResponder];
}

- (void)dismissKeyboardGesture {
	[self.view endEditing: YES];
}

- (void)setAppointmentTime{
	NSDate *date = self.time_picker.date;
	
	static NSDateFormatter *dateFormatterAppointmentTime = nil;
	
	if (!dateFormatterAppointmentTime) {
		dateFormatterAppointmentTime =	 [[NSDateFormatter alloc] init];
		dateFormatterAppointmentTime.dateFormat = @"MMMM d, yyyy h:mm aa";
	}
	
	(self.timeField).text = [dateFormatterAppointmentTime stringFromDate: date];
}

- (void)setMoveInDate {
	NSDate *date = self.movein_picker.date;

	static NSDateFormatter *dateFormatterMoveIn = nil;
	
	if (!dateFormatterMoveIn) {
		dateFormatterMoveIn =	 [[NSDateFormatter alloc] init];
		dateFormatterMoveIn.dateStyle = NSDateFormatterLongStyle;
	}

	(self.moveindateField).text = [dateFormatterMoveIn stringFromDate: date];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	(self.nameField).text = item.itemName;
	(self.phoneField).text = item.phoneName;
	(self.moveindateField).text = item.moveindateName;
	(self.priceField).text = item.priceName;
	(self.neighborhoodField).text = item.neighborhoodName;
	(self.aptsizeField).text = item.aptsizeName;
	(self.roomsField).text = item.roomsName;
	(self.bathsField).text = item.bathsName;
	(self.accessField).text = item.accessName;
	(self.timeField).text = item.timeName;
	(self.addressField).text = item.addressName;
	(self.petsField).text = item.petsName;
	(self.guarantorField).text = item.guarantorName;
	(self.emailField).text = item.emailName;
	
	// Change the navigation item to display name of item
	self.navigationItem.title = item.itemName;
}

- (IBAction)saveFields:(id)sender {
	for (JVFloatLabeledTextField *textfield in [self allInputFields]) {
		if (!((textfield.text).length > 0)) {
			textfield.text = @"Unavailable";
		}
	}
	
	[self.navigationController popViewControllerAnimated: YES];
}

- (void)doNotSave {
	for (JVFloatLabeledTextField *textField in [self allInputFields]) {
		if (!((textField.text).length > 0)) {
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

- (instancetype)initForNewItem:(BOOL)isNew {
	self = [super initWithNibName: @"AppointmentInputViewController" bundle: nil];
	
	if (self) {
		if (isNew) {
			NSLog(@"NEW ITEM");
		}
	}
	
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	@throw [NSException exceptionWithName: @"Wrong initializer"
								   reason: @"Use initForNewItem: "
								 userInfo: nil];
	
	return nil;
}

- (void)setItem:(BrokersLabItem *)i {
	item = i;
	self.navigationItem.title = item.itemName;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear: animated];
	
	// Clear first responder
	[self.view endEditing: YES];
	
	// "Save" changes to item
	item.itemName = (self.nameField).text;
	item.phoneName = (self.phoneField).text;
	item.moveindateName = (self.moveindateField).text;
	item.priceName = (self.priceField).text;
	item.neighborhoodName = (self.neighborhoodField).text;
	item.aptsizeName = (self.aptsizeField).text;
	item.roomsName = (self.roomsField).text;
	item.bathsName = (self.bathsField).text;
	item.accessName = (self.accessField).text;
	item.timeName = (self.timeField).text;
	item.addressName = (self.addressField).text;
	item.petsName = (self.petsField).text;
	item.guarantorName = (self.guarantorField).text;
	item.emailName = (self.emailField).text;
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
		return bedsBathsArray[row];
	}
	
	if (pickerView == self.bedroom_picker) {
		return bedsBathsArray[row];
	}
	
	if (pickerView == self.access_picker) {
		return accessArray[row];
	}
	
	if (pickerView == self.price_picker) {
		return priceArray[row];
	}
	
	if (pickerView == self.neighborhood_picker) {
		return neighborhoodArray[row];
	}
	
	if (pickerView == self.aptSize_picker) {
		return aptSizeArray[row];
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
	if (pickerView == self.bathroom_picker) {
		self.bathsField.text = bedsBathsArray[row];
	}
	
	if (pickerView == self.bedroom_picker) {
		self.roomsField.text = bedsBathsArray[row];
	}
	
	if (pickerView == self.access_picker) {
		self.accessField.text = accessArray[row];
	}
	
	if (pickerView == self.price_picker) {
		self.priceField.text = priceArray[row];
	}
	
	if (pickerView == self.aptSize_picker) {
		self.aptsizeField.text = aptSizeArray[row];
	}
	
	if (pickerView == self.pets_picker) {
		self.petsField.text = petsArray[row];
	}
	
	if (pickerView == self.guarantor_picker) {
		self.guarantorField.text = guarantorArray[row];
	}
	
	if (pickerView == self.neighborhood_picker) {
		self.neighborhoodField.text = neighborhoodArray[row];
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
		UIResponder *next = [self allInputFields][(NSUInteger)(indexOfInput+1)];
		
		if ([next canBecomeFirstResponder]) {
			[next becomeFirstResponder];
			
			return YES;
		}
	}
	
	return NO;
}

@end