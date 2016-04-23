/*!
 * MCTReachability.m
 *
 * Copyright (c) 2014 Ministry Centered Technology
 *
 * Created by Skylar Schipper on 5/21/14
 */

#import "MCTReachability.h"

#if MCTReachabilityDebugLog && DEBUG
#   define MCTReachabilityLog(msg, ...) printf("MCTReachability> %s\n",[[NSString stringWithFormat:msg, ##__VA_ARGS__] UTF8String])
#else
#   define MCTReachabilityLog(msg, ...)
#endif

@interface MCTReachability ()

@property (nonatomic) SCNetworkReachabilityRef reach;
@property (nonatomic, readwrite, getter = isRunning) BOOL running;

- (void)mct_reachChanged:(SCNetworkReachabilityFlags)flags;

@end

static void MCTReachabilityHandler(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info);
static NSString *MCTReachabilityFlagsString(SCNetworkReachabilityFlags flags);
static void MCTReachabilityPrintFlags(SCNetworkReachabilityFlags flags, const char *comment);

@implementation MCTReachability

+ (instancetype)newReachability {
    struct sockaddr_in addr;
    bzero(&addr, sizeof(addr));
    addr.sin_len = sizeof(addr);
    addr.sin_family = AF_INET;
    return [self newReachabilityWithAddress:&addr];
}
+ (instancetype)newReachabilityWithURL:(NSURL *)URL {
    return [self newReachabilityWithHostName:[URL host]];
}
+ (instancetype)newReachabilityWithHostName:(NSString *)hostName {
    SCNetworkReachabilityRef reach = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [hostName UTF8String]);
    if (reach != NULL) {
        MCTReachability *reachability = [[[self class] alloc] init];
        reachability.reach = reach;
        return reachability;
    }
    return nil;
}
+ (instancetype)newReachabilityWithAddress:(const struct sockaddr_in *)address {
    SCNetworkReachabilityRef reach = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    if (reach != NULL) {
        MCTReachability *reachability = [[[self class] alloc] init];
        reachability.reach = reach;
        return reachability;
    }
    return nil;
}


- (BOOL)startNotifier {
    if ([self isRunning]) {
        MCTReachabilityLog(@"Already running notifier");
        return YES;
    }
    
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    if (SCNetworkReachabilitySetCallback(self.reach, MCTReachabilityHandler, &context)) {
        if (SCNetworkReachabilityScheduleWithRunLoop(self.reach, CFRunLoopGetMain(), kCFRunLoopDefaultMode)) {
            MCTReachabilityLog(@"Started notifier");
            self.running = YES;
            return YES;
        }
    }
    return NO;
}
- (BOOL)stopNotifier {
    if (![self isRunning] && self.reach != NULL) {
        if (SCNetworkReachabilityUnscheduleFromRunLoop(self.reach, CFRunLoopGetMain(), kCFRunLoopDefaultMode)) {
            MCTReachabilityLog(@"Stopped notifier");
            self.running = NO;
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark - Changes
- (void)mct_reachChanged:(SCNetworkReachabilityFlags)flags {
    MCTReachabilityPrintFlags(flags, "Reachability Flags Changed");
    
    MCTReachabilityNetworkStatus status = [self mct_getReachabilityStatusFromFlags:flags];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MCTReachabilityStatusChangedNotification object:self userInfo:@{kMCTReachabilityStatus: @(status)}];
    
    if (self.changeHandler) {
        typeof(self) __weak welf = self;
        self.changeHandler(welf, status);
    }
}

#pragma mark -
#pragma mark - Memory
- (void)dealloc {
    [self stopNotifier];
    [self mct_releaseReachRef];
}
- (void)mct_releaseReachRef {
    if (self.reach != NULL) {
        CFRelease(_reach);
        _reach = NULL;
    }
}

#pragma mark -
#pragma mark - Status
- (BOOL)mct_getFlags:(SCNetworkReachabilityFlags *)flags {
    if (SCNetworkReachabilityGetFlags(self.reach, flags)) {
        return YES;
    }
    return NO;
}
- (MCTReachabilityNetworkStatus)status {
    SCNetworkReachabilityFlags flags;
    if ([self mct_getFlags:&flags]) {
        return [self mct_getReachabilityStatusFromFlags:flags];
    }
    
    return MCTReachabilityNetworkNotReachable;
}

- (MCTReachabilityNetworkStatus)mct_getReachabilityStatusFromFlags:(SCNetworkReachabilityFlags)flags {
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
        return MCTReachabilityNetworkNotReachable;
    }
    
    MCTReachabilityNetworkStatus status = MCTReachabilityNetworkNotReachable;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
        status = MCTReachabilityNetworkReachableViaWiFi;
    }
    if ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0 || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0) {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
            status = MCTReachabilityNetworkReachableViaWiFi;
        }
    }
#if	TARGET_OS_IPHONE
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        status = MCTReachabilityNetworkReachableViaWWAN;
    }
#endif
    
    return status;
}

- (NSString *)mct_debugFlagsString {
    SCNetworkReachabilityFlags flags;
    if ([self mct_getFlags:&flags]) {
        return MCTReachabilityFlagsString(flags);
    }
    return @"Flags Failed";
}

- (BOOL)isReachableWiFi {
    return (self.status == MCTReachabilityNetworkReachableViaWiFi);
}
- (BOOL)isReachableWWAN {
#if	TARGET_OS_IPHONE
    return (self.status == MCTReachabilityNetworkReachableViaWWAN);
#else
    return NO;
#endif
}
- (BOOL)isReachable {
    return ([self isReachableWiFi] || [self isReachableWWAN]);
}

- (BOOL)isUnReachable {
    return (self.status == MCTReachabilityNetworkNotReachable);
}

@end

NSString *const MCTReachabilityStatusChangedNotification = @"MCTReachabilityStatusChangedNotification";
NSString *const kMCTReachabilityStatus = @"status";

/**
 *  C
 */
static void MCTReachabilityHandler(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info) {
    if (info == NULL) {
        MCTReachabilityLog(@"Can't handle change, info was nil");
        return;
    }
    MCTReachability *reach = (__bridge MCTReachability *)info;
    if (!reach || ![reach isKindOfClass:[MCTReachability class]]) {
        MCTReachabilityLog(@"Can't hand reach change: Info was %@",info);
        return;
    }
    [reach mct_reachChanged:flags];
}
static void MCTReachabilityPrintFlags(SCNetworkReachabilityFlags flags, const char *comment) {
    MCTReachabilityLog(@"Flags: %@ %s", MCTReachabilityFlagsString(flags), comment);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static NSString *MCTReachabilityFlagsString(SCNetworkReachabilityFlags flags) {
#if	TARGET_OS_IPHONE
    char wwan = (flags & kSCNetworkReachabilityFlagsIsWWAN)				  ? 'W' : '-';
#else
    char wwan = '-';
#endif
    char tran = (flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-';
    char reac = (flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-';
    char requ = (flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-';
    char traf = (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-';
    char inte = (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-';
    char dema = (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-';
    char loca = (flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-';
    char dire = (flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-';
    return [NSString stringWithFormat:@"%c%c %c%c%c%c%c%c%c",wwan,tran,reac,requ,traf,inte,dema,loca,dire];
}
#pragma clang diagnostic pop
