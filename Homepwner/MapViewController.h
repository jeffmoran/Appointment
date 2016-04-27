#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
	BOOL firstLaunch;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString *addressName;
@end