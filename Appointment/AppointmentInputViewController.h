#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "Appointment.h"
#import "AppointmentStore.h"
#import "AppointmentsViewController.h"

@import ChameleonFramework;

@interface AppointmentInputViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray *petsArray;
	NSInteger fieldIndex;
	UIStepper *bedroomsStepper;
	UIStepper *bathroomsStepper;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) JVFloatLabeledTextField *nameField;
@property (strong, nonatomic) JVFloatLabeledTextField *emailField;
@property (strong, nonatomic) JVFloatLabeledTextField *phoneField;
@property (strong, nonatomic) JVFloatLabeledTextField *timeField;
@property (strong, nonatomic) JVFloatLabeledTextField *addressField;
@property (strong, nonatomic) JVFloatLabeledTextField *zipCodeField;
@property (strong, nonatomic) JVFloatLabeledTextField *moveindateField;
@property (strong, nonatomic) JVFloatLabeledTextField *priceField;
@property (strong, nonatomic) JVFloatLabeledTextField *neighborhoodField;
@property (strong, nonatomic) JVFloatLabeledTextField *aptsizeField;
@property (strong, nonatomic) JVFloatLabeledTextField *roomsField;
@property (strong, nonatomic) JVFloatLabeledTextField *bathsField;
@property (strong, nonatomic) JVFloatLabeledTextField *petsField;

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
@property (nonatomic, strong) UIImageView *inputTime;
@property (nonatomic, strong) UIImageView *inputAddress;
@property (nonatomic, strong) UIImageView *inputPets;

@property (nonatomic, strong) UIPickerView *pets_picker;
@property (nonatomic, strong) UIDatePicker *time_picker;
@property (nonatomic, strong) UIDatePicker *movein_picker;

@property (nonatomic, strong) Appointment *appointment;

@end
