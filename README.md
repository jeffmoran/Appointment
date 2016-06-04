# Appointment

This repository is a stripped down version of a client project that was
intended on being a social network for brokers.

I am removing the social features (as they ran on Parse) and leaving
only the appointment making function of the app.

As this project is almost three years old at the time of me writing
this, I will be updating old libraries, removing unused/deprecated code,
and optimizing performance.

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
![Main screen](/Screenshots/1.jpg?raw=true)
![Detail view](/Screenshots/2.jpg?raw=true)
![Menu](/Screenshots/3.jpg?raw=true)
![Maps view](/Screenshots/4.jpg?raw=true)

## To do:
- Use autolayout throughout app so elements properly scale.
- Implement new Reachability library.
- Redesign ```AppointmentCleanViewController```
- Need to be able to update appointment from detail view.
- New menu button.
- Need to have Maps function zoom in to search request, annotation needs to have accessory button that will allow user to get overlay of route as well as step-by-step directions.
- Need to change info.plist string for location permissions.
- Remove traces of "BrokersLab" name.
- Need to add icon for zip/postal code
- ~~Implement ```DZNEmptyDataSet``` on main screen.~~
- ~~Need to implement API to detect zip code and automatically fill out city/state info.~~
- ~~Remove "```GoogleMapsKit```" pod and use native Apple Maps solution.~~
- ~~Set Deployment Target to iOS 9.0 and update code accordingly.~~
- ~~Implement ```Chameleon```~~

## Known bugs:
- Slight lag when creating new appointment.
- ~~DZNEmptyDateSet is not centered when first opening the application.~~
- ~~When clicking "Find on map" in the appointment detail view, the view is pushed twice.~~
- ~~Location isn't properly displayed on map.~~
- ~~Calendar event isn’t added properly — need to get Calendar permissions.~~
- ~~Contact isn’t added properly — need to get Contact permissions.~~
- ~~“Unbalanced calls to begin/end appearance transitions for” bug~~

## Open Source Libraries
- [Chameleon](https://github.com/ViccAlexander/Chameleon)
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)
- [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField)
- [MCTReachability](https://github.com/ministrycentered/MCTReachability)
- [RNGridMenu](https://github.com/rnystrom/RNGridMenu)
- [TapkuLibrary](https://github.com/devinross/tapkulibrary)
