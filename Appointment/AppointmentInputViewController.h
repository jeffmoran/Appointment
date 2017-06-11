#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "AppointmentStore.h"
#import "InputTextField.h"

@import ChameleonFramework;

@interface AppointmentInputViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray *petsArray;
	NSInteger fieldIndex;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSLayoutConstraint *scrollViewHeightConstraint;

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) InputTextField *nameField;
@property (strong, nonatomic) InputTextField *emailField;
@property (strong, nonatomic) InputTextField *phoneField;
@property (strong, nonatomic) InputTextField *timeField;
@property (strong, nonatomic) InputTextField *addressField;
@property (strong, nonatomic) InputTextField *zipCodeField;
@property (strong, nonatomic) InputTextField *moveindateField;
@property (strong, nonatomic) InputTextField *priceField;
@property (strong, nonatomic) InputTextField *neighborhoodField;
@property (strong, nonatomic) InputTextField *aptsizeField;
@property (strong, nonatomic) InputTextField *roomsField;
@property (strong, nonatomic) InputTextField *bathsField;
@property (strong, nonatomic) InputTextField *petsField;

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
