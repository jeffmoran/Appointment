#import "AppointmentInputViewController.h"
#import "BrokersLabItem.h"
#import "BrokersLabItemStore.h"
#import "AppointmentsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AppointmentInputViewController()<UITextFieldDelegate, UITextViewDelegate>

@end
@implementation AppointmentInputViewController
@synthesize item, dismissBlock;

const static CGFloat kJVFieldHeight = 40.0f;
#define fontface [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
#define fontface2 [UIFont fontWithName:@"HelveticaNeue-Light" size:11];

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *floatingLabelColor = [UIColor grayColor];
    [self.view setTintColor:[UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000]];
    
    self.nameField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 22, 237, kJVFieldHeight)];
    self.nameField.placeholder = NSLocalizedString(@"Client Name", @"");
    self.nameField.font = fontface;
    self.nameField.floatingLabel.font = fontface2;
    self.nameField.floatingLabelTextColor = floatingLabelColor;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.nameField];
    
    //create an image
    UIImage *inputName = [UIImage imageNamed:@"inputName"];
    
    //image view instance to display the image
    self.inputName = [[UIImageView alloc] initWithImage:inputName];
    
    //set the frame for the image view
    CGRect nameFrame = CGRectMake(20.0f, 26.0f, 32, 32);
    [self.inputName setFrame:nameFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputName];
    
    self.emailField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 68, 237, kJVFieldHeight)];
    self.emailField.placeholder = NSLocalizedString(@"Client Email Address", @"");
    self.emailField.font = fontface;
    self.emailField.floatingLabel.font = fontface2;
    self.emailField.floatingLabelTextColor = floatingLabelColor;
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.scrollView addSubview:self.emailField];
    
    //create an image
    UIImage *inputEmail = [UIImage imageNamed:@"inputEmail"];
    
    //image view instance to display the image
    self.inputEmail = [[UIImageView alloc] initWithImage:inputEmail];
    
    //set the frame for the image view
    CGRect emailFrame = CGRectMake(20.0f, 72.0f, 32, 32);
    [self.inputEmail setFrame:emailFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputEmail];
    
    self.phoneField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 114, 237, kJVFieldHeight)];
    self.phoneField.placeholder = NSLocalizedString(@"Client Phone Number", @"");
    self.phoneField.font = fontface;
    self.phoneField.floatingLabel.font = fontface2;
    self.phoneField.floatingLabelTextColor = floatingLabelColor;
    self.phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.scrollView addSubview:self.phoneField];
    
    //create an image
    UIImage *inputPhone = [UIImage imageNamed:@"inputPhone"];
    
    //image view instance to display the image
    self.inputPhone = [[UIImageView alloc] initWithImage:inputPhone];
    
    //set the frame for the image view
    CGRect phoneFrame = CGRectMake(20.0f, 118.0f, 32, 32);
    [self.inputPhone setFrame:phoneFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputPhone];
    
    self.timeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 160, 237, kJVFieldHeight)];
    self.timeField.placeholder = NSLocalizedString(@"Appointment Time", @"");
    self.timeField.font = fontface;
    self.timeField.floatingLabel.font = fontface2;
    self.timeField.floatingLabelTextColor = floatingLabelColor;
    self.timeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.timeField];
    
    //create an image
    UIImage *inputTime = [UIImage imageNamed:@"inputTime"];
    
    //image view instance to display the image
    self.inputTime = [[UIImageView alloc] initWithImage:inputTime];
    
    //set the frame for the image view
    CGRect timeFrame = CGRectMake(20.0f, 164.0f, 32, 32);
    [self.inputTime setFrame:timeFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputTime];
    
    self.addressField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 206, 237, kJVFieldHeight)];
    self.addressField.placeholder = NSLocalizedString(@"Property Address", @"");
    self.addressField.font = fontface;
    self.addressField.floatingLabel.font = fontface2;
    self.addressField.floatingLabelTextColor = floatingLabelColor;
    self.addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.addressField];
    
    //create an image
    UIImage *inputAddress = [UIImage imageNamed:@"inputAddress"];
    
    //image view instance to display the image
    self.inputAddress = [[UIImageView alloc] initWithImage:inputAddress];
    
    //set the frame for the image view
    CGRect addressFrame = CGRectMake(20.0f, 210.0f, 32, 32);
    [self.inputAddress setFrame:addressFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputAddress];
    
    self.moveindateField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 252, 237, kJVFieldHeight)];
    self.moveindateField.placeholder = NSLocalizedString(@"Move-In Date", @"");
    self.moveindateField.font = fontface;
    self.moveindateField.floatingLabel.font = fontface2;
    self.moveindateField.floatingLabelTextColor = floatingLabelColor;
    self.moveindateField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.moveindateField];
    
    //create an image
    UIImage *inputMoveInDate = [UIImage imageNamed:@"inputMoveInDate"];
    
    //image view instance to display the image
    self.inputMoveInDate = [[UIImageView alloc] initWithImage:inputMoveInDate];
    
    //set the frame for the image view
    CGRect moveInDateFrame = CGRectMake(20.0f, 256.0f, 32, 32);
    [self.inputMoveInDate setFrame:moveInDateFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputMoveInDate];
    
    self.petsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 298, 237, kJVFieldHeight)];
    self.petsField.placeholder = NSLocalizedString(@"Pets", @"");
    self.petsField.font = fontface;
    self.petsField.floatingLabel.font = fontface2;
    self.petsField.floatingLabelTextColor = floatingLabelColor;
    self.petsField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.petsField];
    
    //create an image
    UIImage *inputPets = [UIImage imageNamed:@"inputPets"];
    
    //image view instance to display the image
    self.inputPets = [[UIImageView alloc] initWithImage:inputPets];
    
    //set the frame for the image view
    CGRect petsFrame = CGRectMake(20.0f, 302.0f, 32, 32);
    [self.inputPets setFrame:petsFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputPets];
    
    self.priceField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 344, 237, kJVFieldHeight)];
    self.priceField.placeholder = NSLocalizedString(@"Price", @"");
    self.priceField.font = fontface;
    self.priceField.floatingLabel.font = fontface2;
    self.priceField.floatingLabelTextColor = floatingLabelColor;
    self.priceField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.priceField];
    
    //create an image
    UIImage *inputPrice = [UIImage imageNamed:@"inputPrice"];
    
    //image view instance to display the image
    self.inputPrice = [[UIImageView alloc] initWithImage:inputPrice];
    
    //set the frame for the image view
    CGRect priceFrame = CGRectMake(20.0f, 348.0f, 32, 32);
    [self.inputPrice setFrame:priceFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputPrice];
    
    self.neighborhoodField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 390, 237, kJVFieldHeight)];
    self.neighborhoodField.placeholder = NSLocalizedString(@"Neighborhood", @"");
    self.neighborhoodField.font = fontface;
    self.neighborhoodField.floatingLabel.font = fontface2;
    self.neighborhoodField.floatingLabelTextColor = floatingLabelColor;
    self.neighborhoodField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.neighborhoodField];
    
    //create an image
    UIImage *inputNeighborhood = [UIImage imageNamed:@"inputNeighborhood"];
    
    //image view instance to display the image
    self.inputNeighborhood = [[UIImageView alloc] initWithImage:inputNeighborhood];
    
    //set the frame for the image view
    CGRect neighborhoodFrame = CGRectMake(20.0f, 394.0f, 32, 32);
    [self.inputNeighborhood setFrame:neighborhoodFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputNeighborhood];
    
    self.aptsizeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 436, 237, kJVFieldHeight)];
    self.aptsizeField.placeholder = NSLocalizedString(@"Apartment Size", @"");
    self.aptsizeField.font = fontface;
    self.aptsizeField.floatingLabel.font = fontface2;
    self.aptsizeField.floatingLabelTextColor = floatingLabelColor;
    self.aptsizeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.aptsizeField];
    
    //create an image
    UIImage *inputAptSize = [UIImage imageNamed:@"inputSize"];
    
    //image view instance to display the image
    self.inputAptSize = [[UIImageView alloc] initWithImage:inputAptSize];
    
    //set the frame for the image view
    CGRect aptSizeFrame = CGRectMake(20.0f, 440.0f, 32, 32);
    [self.inputAptSize setFrame:aptSizeFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputAptSize];
    
    self.roomsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 482, 237, kJVFieldHeight)];
    self.roomsField.placeholder = NSLocalizedString(@"Bedrooms", @"");
    self.roomsField.font = fontface;
    self.roomsField.floatingLabel.font = fontface2;
    self.roomsField.floatingLabelTextColor = floatingLabelColor;
    self.roomsField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.roomsField];
    
    //create an image
    UIImage *inputRooms = [UIImage imageNamed:@"inputBedrooms"];
    
    //image view instance to display the image
    self.inputRooms = [[UIImageView alloc] initWithImage:inputRooms];
    
    //set the frame for the image view
    CGRect roomsFrame = CGRectMake(20.0f, 486.0f, 32, 32);
    [self.inputRooms setFrame:roomsFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputRooms];
    
    self.bathsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 528, 237, kJVFieldHeight)];
    self.bathsField.placeholder = NSLocalizedString(@"Bathrooms", @"");
    self.bathsField.font = fontface;
    self.bathsField.floatingLabel.font = fontface2;
    self.bathsField.floatingLabelTextColor = floatingLabelColor;
    self.bathsField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.bathsField];
    
    //create an image
    UIImage *inputBaths = [UIImage imageNamed:@"inputBaths"];
    
    //image view instance to display the image
    self.inputBaths = [[UIImageView alloc] initWithImage:inputBaths];
    
    //set the frame for the image view
    CGRect bathsFrame = CGRectMake(20.0f, 532.0f, 32, 32);
    [self.inputBaths setFrame:bathsFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputBaths];
    
    self.accessField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 574, 237, kJVFieldHeight)];
    self.accessField.placeholder = NSLocalizedString(@"Access", @"");
    self.accessField.font = fontface;
    self.accessField.floatingLabel.font = fontface2;
    self.accessField.floatingLabelTextColor = floatingLabelColor;
    self.accessField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.accessField];
    
    //create an image
    UIImage *inputAccess = [UIImage imageNamed:@"inputAccess"];
    
    //image view instance to display the image
    self.inputAccess = [[UIImageView alloc] initWithImage:inputAccess];
    
    //set the frame for the image view
    CGRect accessFrame = CGRectMake(20.0f, 578.0f, 32, 32);
    [self.inputAccess setFrame:accessFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputAccess];
    
    self.guarantorField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 620, 237, kJVFieldHeight)];
    self.guarantorField.placeholder = NSLocalizedString(@"Guarantor", @"");
    self.guarantorField.font = fontface;
    self.guarantorField.floatingLabel.font = fontface2;
    self.guarantorField.floatingLabelTextColor = floatingLabelColor;
    self.guarantorField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:self.guarantorField];
    
    //create an image
    UIImage *inputGuarantor = [UIImage imageNamed:@"inputGuarantor"];
    
    //image view instance to display the image
    self.inputGuarantor = [[UIImageView alloc] initWithImage:inputGuarantor];
    
    //set the frame for the image view
    CGRect guarantorFrame = CGRectMake(20.0f, 624.0f, 32, 32);
    [self.inputGuarantor setFrame:guarantorFrame];
    
    //add the image view to the current view
    [self.scrollView addSubview:self.inputGuarantor];
    
    // Register inputs scroller
   // self.inputsScroller = [[MVTextInputsScroller alloc] initWithScrollView:self.scrollView];
    // Dismiss keyboard on drag
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    // Dismiss keyboard on tap
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
    
    // Textfield capitalization
    [self textFieldCapitalization];
    
    // A bit of styling
    [self updateStyling];
    
    [self setInputResponderChain];
    
    bedsBathsArray = [NSArray arrayWithObjects:@"0", @".5", @"1",@"1.5", @"2", @"2.5",@"3", @"3.5", @"4",@"4.5", @"5", @"5.5",@"6", @"6.5", @"7",@"7.5", @"8", @"8.5",@"9", @"9.5", @"10+", nil];
    accessArray = [NSArray arrayWithObjects:@"Doorman", @"Elevator", @"Walkup", nil];
    priceArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"priceArray" ofType:@"plist"]];
    neighborhoodArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"neighborhoodArray" ofType:@"plist"]];
    aptSizeArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"aptSizeArray" ofType:@"plist"]];
    petsArray = [NSArray arrayWithObjects:@"Yes", @"No", @"Some", nil];
    guarantorArray = [NSArray arrayWithObjects:@"Yes", @"No", nil];
    
    [self.nameField becomeFirstResponder];
    
    self.neighborhood_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.neighborhood_picker.delegate = self;
    self.neighborhood_picker.showsSelectionIndicator = YES;
    
    self.bathroom_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.bathroom_picker.delegate = self;
    self.bathroom_picker.showsSelectionIndicator = YES;
    
    self.bedroom_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.bedroom_picker.delegate = self;
    self.bedroom_picker.showsSelectionIndicator = YES;
    
    self.access_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.access_picker.delegate = self;
    self.access_picker.showsSelectionIndicator = YES;
    
    self.price_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.price_picker.delegate = self;
    self.price_picker.showsSelectionIndicator = YES;
    
    self.aptSize_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.aptSize_picker.delegate = self;
    self.aptSize_picker.showsSelectionIndicator = YES;
    
    self.pets_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.pets_picker.delegate = self;
    self.pets_picker.showsSelectionIndicator = YES;
    
    self.guarantor_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.guarantor_picker.delegate = self;
    self.guarantor_picker.showsSelectionIndicator = YES;
    
    self.time_picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.time_picker.datePickerMode = UIDatePickerModeDateAndTime;
    self.time_picker.minuteInterval = 5;
    [self.time_picker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventValueChanged];
     
    
    self.movein_picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.movein_picker.datePickerMode = UIDatePickerModeDate;
    [self.movein_picker addTarget:self action:@selector(displayMoveIn:) forControlEvents:UIControlEventValueChanged];

    
    [self.neighborhoodField setInputView:self.neighborhood_picker];
    [self.bathsField setInputView:self.bathroom_picker];
    [self.roomsField setInputView:self.bedroom_picker];
    [self.timeField setInputView:self.time_picker];
    [self.moveindateField setInputView:self.movein_picker];
    [self.accessField setInputView:self.access_picker];
    [self.priceField setInputView:self.price_picker];
    [self.aptsizeField setInputView:self.aptSize_picker];
    [self.petsField setInputView:self.pets_picker];
    [self.guarantorField setInputView:self.guarantor_picker];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 682)];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(save:)];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(goBack)];
    [[self navigationItem] setLeftBarButtonItem:back];
    
    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                           target:self
                                                                           action:@selector(backToTopButtonPressed:)];
  
    [[self navigationItem] setRightBarButtonItems:[NSArray arrayWithObjects:done, clear, nil]];
}

- (void)dealloc {
    //[self.inputsScroller unregister];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phoneField) {
        NSUInteger length = [self getLength:textField.text];
        
        if(length == 10) {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"%@-",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textField.text];
            
            textField.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
        
    }
    
    return YES;
}

-(NSString*)formatNumber:(NSString*)mobileNumber {
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSUInteger length = [mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        
    }
    
    
    return mobileNumber;
}


-(NSUInteger)getLength:(NSString*)mobileNumber {
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSUInteger length = [mobileNumber length];
    
    return length;
}

- (NSArray *)allInputFields {
    return @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.moveindateField, self.petsField, self.priceField, self.neighborhoodField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
}

- (void)updateStyling {
    for (UIView *view in [self allInputFields]) {
        view.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        view.layer.borderWidth = .7;
        view.layer.cornerRadius = 5;
        view.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    }
}

- (void)textFieldCapitalization {
    for (UITextField *textfield in [self allInputFields]) {
        [textfield setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    }
}

- (void)setInputResponderChain {
    
    NSArray *textFields = @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.moveindateField, self.petsField, self.priceField, self.neighborhoodField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
    for (UIResponder *responder in textFields) {
        if ([responder isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)responder;
            textField.returnKeyType = UIReturnKeyNext;
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.delegate = self;
        }
    }
    //self.phoneField.returnKeyType = UIReturnKeyDone;
}

- (IBAction)backToTopButtonPressed:(id)sender {
    [self clearForm];
    [self.nameField becomeFirstResponder];
}

- (IBAction)clearButtonPressed:(id)sender {
    [self clearForm];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissKeyboard];
}

- (void)clearForm {
    NSArray *textFields = @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.moveindateField, self.petsField, self.priceField, self.neighborhoodField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
    for (id input in textFields) {
        [input setText:@""];
    }
}
- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)displayDate:(id)sender {
    NSDate *myDate = self.time_picker.date;
    NSLog(@"%@", self.time_picker.date);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM d yyyy h:mm aa"];
    
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    [self.timeField setText:prettyVersion];
}

- (IBAction)displayMoveIn:(id)sender {
    NSDate *myDate = self.movein_picker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    // [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    NSString *prettyVersion = [dateFormatter stringFromDate:myDate];
    [self.moveindateField setText:prettyVersion];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.nameField setText:[item itemName]];
    [self.phoneField setText:[item phoneName]];
    [self.moveindateField setText:[item moveindateName]];
    [self.priceField setText:[item priceName]];
    [self.neighborhoodField setText:[item neighborhoodName]];
    [self.aptsizeField setText:[item aptsizeName]];
    [self.roomsField setText:[item roomsName]];
    [self.bathsField setText:[item bathsName]];
    [self.accessField setText:[item accessName]];
    [self.timeField setText:[item timeName]];
    [self.addressField setText:[item addressName]];
    [self.petsField setText:[item petsName]];
    [self.guarantorField setText:[item guarantorName]];
    [self.emailField setText:[item emailName]];
    
    // Change the navigation item to display name of item
    [[self navigationItem] setTitle:[item itemName]];
}

- (IBAction)save:(id)sender {
    if ((!([self.nameField.text length] > 0) )) {
        self.nameField.text = @"Unavailable";
    }
    if ((!([self.emailField.text length] > 0) )) {
        self.emailField.text = @"Unavailable";
    }
    if ((!([self.phoneField.text length] > 0) )) {
        self.phoneField.text = @"Unavailable";
    }
    if ((!([self.timeField.text length] > 0) )) {
        self.timeField.text = @"Unavailable";
    }
    if ((!([self.addressField.text length] > 0) )) {
        self.addressField.text = @"Unavailable";
    }
    if ((!([self.moveindateField.text length] > 0) )) {
        self.moveindateField.text = @"Unavailable";
    }
    if ((!([self.petsField.text length] > 0) )) {
        self.petsField.text = @"Unavailable";
    }
    if ((!([self.priceField.text length] > 0) )) {
        self.priceField.text = @"Unavailable";
    }
    if ((!([self.neighborhoodField.text length] > 0) )) {
        self.neighborhoodField.text = @"Unavailable";
    }
    if ((!([self.aptsizeField.text length] > 0) )) {
        self.aptsizeField.text = @"Unavailable";
    }
    if ((!([self.roomsField.text length] > 0) )) {
        self.roomsField.text = @"Unavailable";
    }
    if ((!([self.bathsField.text length] > 0) )) {
        self.bathsField.text = @"Unavailable";
    }
    if ((!([self.accessField.text length] > 0) )) {
        self.accessField.text = @"Unavailable";
    }
    if ((!([self.guarantorField.text length] > 0) )) {
        self.guarantorField.text = @"Unavailable";
    }
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)goBack
{
    if ((!([self.nameField.text length] > 0) )||(!([self.addressField.text length] > 0) )||(!([self.timeField.text length] > 0) )||(!([self.phoneField.text length] > 0) )||(!([self.moveindateField.text length] > 0) )||(!([self.priceField.text length] > 0) )||(!([self.neighborhoodField.text length] > 0) )||(!([self.aptsizeField.text length] > 0) )||(!([self.roomsField.text length] > 0) )||(!([self.bathsField.text length] > 0) )||(!([self.accessField.text length] > 0) )) {
        
        [[BrokersLabItemStore sharedStore] removeItem:item];
        
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"Delete");
    }
    
    else {
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"Save");
    }
}

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"AppointmentInputViewController" bundle:nil];
    
    if (self) {
        if (isNew) {
            
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    @throw [NSException exceptionWithName:@"Wrong initializer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}

- (void)setItem:(BrokersLabItem *)i {
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [[self view] endEditing:YES];
    
    // "Save" changes to item
    [item setItemName:[self.nameField text]];
    [item setPhoneName:[self.phoneField text]];
    [item setMoveindateName:[self.moveindateField text]];
    [item setPriceName:[self.priceField text]];
    [item setNeighborhoodName:[self.neighborhoodField text]];
    [item setAptsizeName:[self.aptsizeField text]];
    [item setRoomsName:[self.roomsField text]];
    [item setBathsName:[self.bathsField text]];
    [item setAccessName:[self.accessField text]];
    [item setTimeName:[self.timeField text]];
    [item setAddressName:[self.addressField text]];
    [item setPetsName:[self.petsField text]];
    [item setGuarantorName:[self.guarantorField text]];
    [item setEmailName:[self.emailField text]];
}

#pragma mark - UIPickerView datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.bathroom_picker) {
        return [bedsBathsArray objectAtIndex:row];
    }
    if (pickerView == self.bedroom_picker) {
        return [bedsBathsArray objectAtIndex:row];
    }
    if (pickerView == self.access_picker) {
        return [accessArray objectAtIndex:row];
    }
    if (pickerView == self.price_picker) {
        return [priceArray objectAtIndex:row];
    }
    if (pickerView == self.neighborhood_picker) {
        return [neighborhoodArray objectAtIndex:row];
    }
    if (pickerView == self.aptSize_picker) {
        return [aptSizeArray objectAtIndex:row];
    }
    if (pickerView == self.pets_picker) {
        return [petsArray objectAtIndex:row];
    }
    if (pickerView == self.guarantor_picker) {
        return [guarantorArray objectAtIndex:row];
    }
    else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.bathroom_picker) {
        self.bathsField.text = [bedsBathsArray objectAtIndex:row];
    }
    if (pickerView == self.bedroom_picker) {
        self.roomsField.text = [bedsBathsArray objectAtIndex:row];
    }
    if (pickerView == self.access_picker) {
        self.accessField.text = [accessArray objectAtIndex:row];
    }
    if (pickerView == self.price_picker) {
        self.priceField.text = [priceArray objectAtIndex:row];
    }
    if (pickerView == self.aptSize_picker) {
        self.aptsizeField.text = [aptSizeArray objectAtIndex:row];
    }
    if (pickerView == self.pets_picker) {
        self.petsField.text = [petsArray objectAtIndex:row];
    }
    if (pickerView == self.guarantor_picker) {
        self.guarantorField.text = [guarantorArray objectAtIndex:row];
    }
    if (pickerView == self.neighborhood_picker) {
        self.neighborhoodField.text = [neighborhoodArray objectAtIndex:row];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone) {
        [self.view endEditing:YES];
    }
    
    return [self setNextResponder:textField] ? NO : YES;
}

- (BOOL)setNextResponder:(UITextField *)textField {
    
    NSArray *textFields = @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.moveindateField, self.petsField, self.priceField, self.neighborhoodField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
    NSInteger indexOfInput = [textFields indexOfObject:textField];
    if (indexOfInput != NSNotFound && indexOfInput < textFields.count - 1) {
        UIResponder *next = [textFields objectAtIndex:(NSUInteger)(indexOfInput + 1)];
        if ([next canBecomeFirstResponder]) {
            [next becomeFirstResponder];
            return YES;
        }
    }
    return NO;
}


@end