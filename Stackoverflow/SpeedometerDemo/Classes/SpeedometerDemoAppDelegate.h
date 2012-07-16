//
//  SpeedometerDemoAppDelegate.h
//  SpeedometerDemo

//

#import <UIKit/UIKit.h>

@class SpeedometerDemoViewController;

@interface SpeedometerDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SpeedometerDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SpeedometerDemoViewController *viewController;

@end

