# Appointment

A simple utility application for brokers to create and manage their appointments.

## Installation
Provided that you have [CocoaPods](http://cocoapods.org) installed, please be sure to run

```bash
$ pod install
```
to install the libraries used in this project.

A Google Maps Geocoding API key is needed for automatically obtaining city information from a postal code. You can get one [here](https://developers.google.com/maps/documentation/geocoding/start).

Once obtained, create a header file titled `Config.h` and create a `NSString *const` like so.

```Objective-C
NSString *const googleAPIKey = @"API_KEY_HERE";
```

## Screenshots
<img src="/Screenshots/appointments.png" width="324px" height="576px" /> <img src="/Screenshots/detail.png" width="324px" height="576px" />

<img src="/Screenshots/menu.png" width="324px" height="576px" /> <img src="/Screenshots/map.png" width="324px" height="576px" />

## Open Source Libraries
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)
- [RNGridMenu](https://github.com/rnystrom/RNGridMenu)
