#import <UIKit/UIKit.h>

@class Appointment;
@class InputTextField;

@protocol AppointmentListViewControllerDelegate;

@interface AppointmentInputViewController : UIViewController  {
	NSArray *petsArray;
	NSInteger fieldIndex;
	
	UIScrollView *scrollView;
	UIView *contentView;
	
	NSLayoutConstraint *scrollViewBottomConstraint;
	
	InputTextField *nameField;
	InputTextField *emailField;
	InputTextField *phoneField;
	InputTextField *timeField;
	InputTextField *addressField;
	InputTextField *zipCodeField;
	InputTextField *moveindateField;
	InputTextField *priceField;
	InputTextField *neighborhoodField;
	InputTextField *aptsizeField;
	InputTextField *roomsField;
	InputTextField *bathsField;
	InputTextField *petsField;
	
	UITextView *notesTextView;
	
	UIPickerView *petsPicker;
	UIDatePicker *timePicker;
	UIDatePicker *moveInPicker;
	
	UIImageView *inputName;
	UIImageView *inputEmail;
	UIImageView *inputPhone;
	UIImageView *inputMoveInDate;
	UIImageView *inputPrice;
	UIImageView *inputNeighborhood;
	UIImageView *inputZip;
	UIImageView *inputAptSize;
	UIImageView *inputRooms;
	UIImageView *inputBaths;
	UIImageView *inputTime;
	UIImageView *inputAddress;
	UIImageView *inputPets;
	UIImageView *inputNotes;
}

@property (nonatomic, strong) Appointment *appointment;
@property (nonatomic, weak) id<AppointmentListViewControllerDelegate> delegate;

@end
