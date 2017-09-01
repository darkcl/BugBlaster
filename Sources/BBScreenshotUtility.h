//
//  BBScreenshotUtility.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import <UIKit/UIKit.h>

@interface BBScreenshotUtility : NSObject

/**
 *  Captures a screenshot of the main UIWindow.
 */
+ (void)captureScreenshotOfMainWindow;

/**
 *  Returns an array of all the screenshots taken since
 *  since the last time Bug Blaster was shown.
 *
 *  @return NSArray of UIImages.
 */
+ (NSArray *)screenshots;

/**
 *  Returns the last captured screenshot.
 *
 *  @return UIImage of the last captured screenshot.
 */
+ (UIImage *)lastScreenshot;

/**
 *  Used to clean up. Removes all currently stored screenshots.
 */
+ (void)clearScreenshots;

@end
