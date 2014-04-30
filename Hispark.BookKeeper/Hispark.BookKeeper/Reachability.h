


                /*  Name: Ranjith Kumar
                    Date of Started:05/07/2013
                    Date of Last Modified:05/07/2013
                    Class Name: Reachability[To Check the Internet connectivity]
                    */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

struct sockaddr_in;

typedef enum {
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
} NetworkStatus;
#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"

@interface Reachability: NSObject

+ (Reachability*) reachabilityWithHostName: (NSString*) hostName;

+ (Reachability*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

+ (Reachability*) reachabilityForInternetConnection;

+ (Reachability*) reachabilityForLocalWiFi;

- (BOOL) startNotifier;
- (void) stopNotifier;

- (NetworkStatus) currentReachabilityStatus;
- (BOOL) connectionRequired;

@end

