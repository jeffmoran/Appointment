#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "Appointment.h"
#import "AppointmentStore.h"
#import "AppointmentsViewController.h"

@import ChameleonFramework;

@interface AppointmentInputViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray *accessArray;
    NSArray *petsArray;
    NSArray *guarantorArray;
	NSInteger fieldIndex;
	UIStepper *bedroomsStepper;
	UIStepper *bathroomsStepper;
	BOOL emptyFields;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *nameField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *emailField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *timeField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *addressField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *zipCodeField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *moveindateField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *priceField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *neighborhoodField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *aptsizeField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *roomsField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *bathsField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *accessField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *petsField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *guarantorField;

@property (nonatomic, strong) UIImageView *inputName;
@property (nonatomic, strong) UIImageView *inputEmail;
@property (nonatomic, strong) UIImageView *inputPhone;
@property (nonatomic, strong) UIImageView *inputMoveInDate;
@property (nonatomic, strong) UIImageView *inputPrice;
@property (nonatomic, strong) UIImageView *inputNeighborhood;
@property (nonatomic, strong) UIImageView *inputZip;
@property (nonatomic, strong) UIImageView *inputAptSize;
@property (nonatomic, strong) UIImageView *inputRooms;
@property (nonatomic, strong) UIImageView *inputBaths;
@property (nonatomic, strong) UIImageView *inputAccess;
@property (nonatomic, strong) UIImageView *inputTime;
@property (nonatomic, strong) UIImageView *inputAddress;
@property (nonatomic, strong) UIImageView *inputPets;
@property (nonatomic, strong) UIImageView *inputGuarantor;

@property (nonatomic, strong) IBOutlet UIPickerView *access_picker;
@property (nonatomic, strong) IBOutlet UIPickerView *pets_picker;
@property (nonatomic, strong) IBOutlet UIPickerView *guarantor_picker;
@property (nonatomic, strong) IBOutlet UIDatePicker *time_picker;
@property (nonatomic, strong) IBOutlet UIDatePicker *movein_picker;

@property (nonatomic) BOOL isEditing;

- (instancetype)initForNewAppointment:(BOOL)isNew;

@property (nonatomic, strong) Appointment *item;

@end