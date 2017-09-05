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

typedef UIViewController * _Nonnull(^BugBlasterConfigurationBlock)(NSArray<UIImage *> * _Nonnull images);

@interface BugBlaster : NSObject

+ (void)showBugBlaster;

+ (void)showBugBlasterWithConfiguration:(nullable BugBlasterConfigurationBlock)configurationBlock;

+ (void)hideBugBlaster;

#pragma mark - Settings

+ (void)setReportEmail:(nonnull NSString *)email;

+ (nullable NSString *)reportEmail;

@end
