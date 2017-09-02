//
//  BBOverlayViewDelegate.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import <UIKit/UIKit.h>

@protocol BBOverlayViewDelegate <NSObject>

@required
- (void)overlayViewReceicedTap:(UIView *)overlayView;
- (void)overlayViewReceicedDoubleTap:(UIView *)overlayView;

@end
