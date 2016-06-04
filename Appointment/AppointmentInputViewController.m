#import "AppointmentInputViewController.h"

#import "Config.h"
//Create a file called "Config.h" and add a NSString like so:

//NSString *const googleAPIKey = @"API_KEY_HERE";

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
    aptSizeArray = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource: @"aptSizeArray" ofType: @"plist"]];
    petsArray = @[@"Yes", @"No", @"Some"];
    guarantorArray = @[@"Yes", @"No"];
    
    //Set the frame for each textfield
    self.nameField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 22, kJVFieldWidth, kJVFieldHeight)];
    self.emailField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 68, kJVFieldWidth, kJVFieldHeight)];
    self.phoneField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 114, kJVFieldWidth, kJVFieldHeight)];
    self.timeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 160, kJVFieldWidth, kJVFieldHeight)];
    self.addressField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 206, kJVFieldWidth, kJVFieldHeight)];
    self.zipCodeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 252, kJVFieldWidth, kJVFieldHeight)];
    self.moveindateField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 298, kJVFieldWidth, kJVFieldHeight)];
    self.petsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 344, kJVFieldWidth, kJVFieldHeight)];
    self.priceField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 390, kJVFieldWidth, kJVFieldHeight)];
    self.neighborhoodField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 436, kJVFieldWidth, kJVFieldHeight)];
    self.aptsizeField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 482, kJVFieldWidth, kJVFieldHeight)];
    self.roomsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 528, kJVFieldWidth, kJVFieldHeight)];
    self.bathsField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 574, kJVFieldWidth, kJVFieldHeight)];
    self.accessField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 620, kJVFieldWidth, kJVFieldHeight)];
    self.guarantorField = [[JVFloatLabeledTextField alloc] initWithFrame: CGRectMake(63, 666, kJVFieldWidth, kJVFieldHeight)];
    
    //Set placeholder text for each textfield
    self.nameField.placeholder = @"Client Name";
    self.emailField.placeholder = @"Client Email Address";
    self.phoneField.placeholder = @"Client Phone Number";
    self.timeField.placeholder = @"Appointment Time";
    self.addressField.placeholder = @"Property Address";
    self.zipCodeField.placeholder = @"Zip/Postal Code";
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
    (self.inputName).frame = CGRectMake(20.0f, self.nameField.frame.origin.y + 4, 32, 32);
    (self.inputEmail).frame = CGRectMake(20.0f, self.emailField.frame.origin.y + 4, 32, 32);
    (self.inputPhone).frame = CGRectMake(20.0f, self.phoneField.frame.origin.y + 4, 32, 32);
    (self.inputTime).frame = CGRectMake(20.0f, self.timeField.frame.origin.y + 4, 32, 32);
    (self.inputAddress).frame = CGRectMake(20.0f, self.addressField.frame.origin.y + 4, 32, 32);
    (self.inputMoveInDate).frame = CGRectMake(20.0f, self.moveindateField.frame.origin.y + 4, 32, 32);
    (self.inputPets).frame = CGRectMake(20.0f, self.petsField.frame.origin.y + 4, 32, 32);
    (self.inputPrice).frame = CGRectMake(20.0f, self.priceField.frame.origin.y + 4, 32, 32);
    (self.inputNeighborhood).frame = CGRectMake(20.0f, self.neighborhoodField.frame.origin.y + 4, 32, 32);
    (self.inputAptSize).frame = CGRectMake(20.0f, self.aptsizeField.frame.origin.y + 4, 32, 32);
    (self.inputRooms).frame = CGRectMake(20.0f, self.roomsField.frame.origin.y + 4, 32, 32);
    (self.inputBaths).frame = CGRectMake(20.0f, self.bathsField.frame.origin.y + 4, 32, 32);
    (self.inputAccess).frame = CGRectMake(20.0f, self.accessField.frame.origin.y + 4, 32, 32);
    (self.inputGuarantor).frame = CGRectMake(20.0f, self.guarantorField.frame.origin.y + 4, 32, 32);
    
    //Set the frame for each pickerview/datepicker
    CGRect pickerFrame = CGRectMake(0, 200, 320, 200);
    self.bathroom_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.pets_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.price_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.access_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.bedroom_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.guarantor_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.aptSize_picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.time_picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    self.movein_picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    //Set the inputView for textFields
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    (self.scrollView).contentSize = CGSizeMake(320, 728);

    self.scrollView.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0];

    [self.view addSubview:self.scrollView];
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
    return @[self.nameField, self.emailField, self.phoneField, self.timeField, self.addressField, self.zipCodeField, self.moveindateField, self.petsField, self.priceField, self.neighborhoodField, self.aptsizeField, self.roomsField, self.bathsField, self.accessField, self.guarantorField];
}

- (NSArray *)allInputPickers {
    return @[self.bathroom_picker, self.pets_picker, self.price_picker, self.access_picker, self.bedroom_picker, self.guarantor_picker, self.aptSize_picker];
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
        
        if (textField == self.zipCodeField) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
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
    (self.zipCodeField).text = item.zipName;
    
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
    self = [super init];
    
    if (self) {
        if (isNew) {
            NSLog(@"NEW ITEM");
        }
    }
    
    return self;
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
    item.zipName = (self.zipCodeField).text;
}

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
                                                                                         message: @"Could not automatically get neighborhood from zip/postal code. Check your internet or input neighborhood manually."
                                                                                  preferredStyle: UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action = [UIAlertAction
                                             actionWithTitle: @"OK"
                                             style: UIAlertActionStyleCancel
                                             handler: ^(UIAlertAction *action) {
                                                 NSLog(@"Dismissed");
                                             }];
                    
                    [errorAlert addAction: action];
                    
                    [self presentViewController: errorAlert animated:YES completion:nil];
                });
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setUpJSONWithData: data];
                });
            }
            
        }];
        [task resume];
    });
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
                                 handler: ^(UIAlertAction *action) {
                                     NSLog(@"Dismissed");
                                 }];
        
        [errorAlert addAction: action];
        
        [self presentViewController: errorAlert animated:YES completion:nil];
    }
    else {
        self.neighborhoodField.text = [addressComponentsDict[1] valueForKey:@"long_name"];
        NSLog(@"NEIGHBORHOOD IS %@", self.neighborhoodField.text);
    }
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
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyDone) {
        [self.view endEditing: YES];
    }
    
    return [self setNextResponder: textField] ? NO : YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.zipCodeField) {
        [self requestURLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@", self.zipCodeField.text, googleAPIKey]];
    }
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