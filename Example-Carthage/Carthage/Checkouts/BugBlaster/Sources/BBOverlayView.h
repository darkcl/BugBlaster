//
//  BBOverlayView.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import <UIKit/UIKit.h>

@protocol BBOverlayViewDelegate;

@interface BBOverlayView : UIView

@property (nonatomic, weak) id<BBOverlayViewDelegate> delegate;

@end
