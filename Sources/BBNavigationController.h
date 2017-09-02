//
//  BBNavigationController.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 2/9/2017.
//
//

#import <UIKit/UIKit.h>

@class BBNavigationController;

@protocol BBNavigationControllerDelegate <NSObject>

@required

- (void)navigationControllerWillDismiss:(BBNavigationController *)controller;

@end

@interface BBNavigationController : UINavigationController

@property (nonatomic, weak) id<BBNavigationControllerDelegate> delegate;

@end
