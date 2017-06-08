# Appointment

A simple utility application for real estate to create and manage their appointments.

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
<img src="/Screenshots/1.png" width="324px" height="576px" />
<img src="/Screenshots/2.png" width="324px" height="576px" />
<img src="/Screenshots/3.png" width="324px" height="576px" />
<img src="/Screenshots/4.png" width="324px" height="576px" />

## Open Source Libraries
- [Chameleon](https://github.com/ViccAlexander/Chameleon)
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)
- [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField)
- [RNGridMenu](https://github.com/rnystrom/RNGridMenu)
- [TapkuLibrary](https://github.com/devinross/tapkulibrary)
