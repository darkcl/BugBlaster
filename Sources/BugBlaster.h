//
//  BugBlaster.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import <UIKit/UIKit.h>

//! Project version number for BugBlaster.
FOUNDATION_EXPORT double BugBlasterVersionNumber;

//! Project version string for BugBlaster.
FOUNDATION_EXPORT const unsigned char BugBlasterVersionString[];

@interface BugBlaster : NSObject

/**
 *  Shows the Bug Blaster window immediately. The window level
 *  will default to UIWindowLevelStatusBar - 1.
 */
+ (void)showBugBlaster;

/**
 *  Hides the Bug Blaster window.
 */
+ (void)hideBugBlaster;

@end
