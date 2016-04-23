#import "BrokersLabAppDelegate.h"
#import "AppointmentsViewController.h"
#import "BrokersLabItemStore.h"

@implementation BrokersLabAppDelegate

@synthesize window = _window;

#define appID @"Bu7x1jKV9deq0AgAdVsKqfwuowMXpPVaARlmnDFL"
#define clKey @"YBgX0VSO4FNEfPWYQag0WJWqHI7pyASj6T6YaQjL"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000]];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{    
    BOOL success = [[BrokersLabItemStore sharedStore] saveChanges];
    if(success) {
        NSLog(@"Saved all of the BrokersLabItems");
    } else {
        NSLog(@"Could not save any of the BrokersLabItems");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    NSUInteger demo = 0;
//    
//    switch( demo )
//    {
//        default:
//        case 1:
//        {
//            // Create transition with a given style that begins immediately
//            [GCOLaunchImageTransition transitionWithDuration:5.0 style:GCOLaunchImageTransitionAnimationStyleZoomIn];
//            
//            break;
//        }
//        case 2:
//        {
//            // Create transition with an near-infinite delay that requires manual dismissal via notification
//            [GCOLaunchImageTransition transitionWithInfiniteDelayAndDuration:0.5 style:GCOLaunchImageTransitionAnimationStyleFade];
//            
//            // Dissmiss the launch image transition by posting a notification after a few seconds
//            [self performSelector:@selector(finishLaunchImageTransitionNow) withObject:nil afterDelay:3.0];
//            
//            break;
//        }
//            
//        case 3:
//        {
//            // Create fully customizable transition including an optional activity indicator
//            // The 'activityIndicatorPosition' is a percentage value ('CGPointMake( 0.5, 0.5 )' being the center)
//            // See https://github.com/gonecoding/GCOLaunchImageTransition for more documentation
//            
//            [GCOLaunchImageTransition transitionWithDelay:5.0 duration:0.5 style:GCOLaunchImageTransitionAnimationStyleZoomOut activityIndicatorPosition:CGPointMake( 0.5, 0.9 ) activityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            
//            break;
//        }
//    }

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end