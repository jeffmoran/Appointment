# Appointment

This repository is a stripped down version of a client project that was
intended on being a social network for brokers.

I am removing the social features (as they ran on Parse) and leaving
only the appointment making function of the app.

As this project is almost three years old at the time of me writing
this, I will be updating old libraries, removing unused/deprecated code,
and optimizing speed.

## To do:
- Use autolayout throughout app so elements properly scale.
- Remove traces of "BrokersLab" name.
- ~~Remove "GoogleMapsKit" pod and use native Apple Maps solution.~~
- ~~Set Deployment Target to iOS 9.0 and update code accordingly.~~
- Need to have Maps function zoom in to search request, annotation needs to have accessory button that will take user to another app for directions. 
- Need to change info.plist string for location permissions.
- Implement DZNEmptyDataSet
- ~~Implement Chameleon~~

## Known bugs:
- ~~When clicking "Find on map" in the appointment detail view, the view is pushed twice.~~
- ~~Location isn't properly displayed on map (Google Maps API).~~
- Slight lag when creating new appointment.
- ~~Calendar event isn’t added properly — need to get Calendar permissions.~~
- ~~Contact isn’t added properly — need to get Contact permissions.~~
- Need new Reachability library

## Open Source Libraries
- [Chameleon](https://github.com/ViccAlexander/Chameleon)
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)
- [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField)
- [MCTReachability](https://github.com/ministrycentered/MCTReachability)
- [RNGridMenu](https://github.com/rnystrom/RNGridMenu)
- [TapkuLibrary](https://github.com/devinross/tapkulibrary)
