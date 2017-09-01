#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BBContainerViewController.h"
#import "BBOverlayView.h"
#import "BBOverlayViewDelegate.h"
#import "BBScreenshotUtility.h"
#import "BBWindow.h"
#import "BugBlaster.h"

FOUNDATION_EXPORT double BugBlasterVersionNumber;
FOUNDATION_EXPORT const unsigned char BugBlasterVersionString[];

