//
//  BBContainerViewController.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import <UIKit/UIKit.h>

@class BBContainerViewController;

@protocol BBContainerViewControllerDelegate <NSObject>

@required
- (void)containerViewControllerWillDismiss:(BBContainerViewController *)containerViewController;

@end

@protocol BBContainerViewControllerChildDelegate <NSObject>

@required
- (void)childViewControllerWillDismiss:(UIViewController *)childViewController;

@end

@interface BBContainerViewController : UIViewController<BBContainerViewControllerChildDelegate>

@property (nonatomic, weak) id<BBContainerViewControllerDelegate> delegate;

@end
