//
//  BBWindow.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import <UIKit/UIKit.h>

#import "BugBlaster.h"

#import "BBOverlayViewDelegate.h"

@interface BBWindow : UIWindow <BBOverlayViewDelegate>

- (instancetype _Nonnull )initWithConfiguration:(nullable BugBlasterConfigurationBlock)configurationBlock;

@end
