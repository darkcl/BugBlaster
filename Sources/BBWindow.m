//
//  BBWindow.m
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import "BBWindow.h"

#import "BBOverlayView.h"

#import <objc/runtime.h>

#import "BBScreenshotUtility.h"

#import <MessageUI/MessageUI.h>

#import "BBNavigationController.h"

@interface BBWindow () <MFMailComposeViewControllerDelegate, BBNavigationControllerDelegate>

@property (nonatomic, weak) UIWindow *keyWindowBeforeModal;

@property (nonatomic, assign) BOOL isShowingModal;
@property (nonatomic, strong) BBOverlayView *overlayView;

@property (nonatomic, copy) BugBlasterConfigurationBlock configurationBlock;

@end

static IMP __original_imp_statusBarControllingWindow;
UIWindow * __swizzled_statusBarControllingWindow(id self, SEL _cmd)
{
    UIWindow *window = ((UIWindow *(*)(id,SEL))__original_imp_statusBarControllingWindow)(self, _cmd);
    if ([window isKindOfClass:[BBWindow class]]) {
        window = [[UIApplication sharedApplication] keyWindow];
    }
    
    return window;
}

@implementation BBWindow


#pragma mark - Initialization

- (id)init
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize_];
    }
    
    return self;
}

- (instancetype)initWithConfiguration:(BugBlasterConfigurationBlock)configurationBlock{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:frame];
    
    self.configurationBlock = configurationBlock;
    
    return self;
}


- (void)initialize_
{
    self.windowLevel = UIWindowLevelAlert + 1;
    
    // See notes at top of file for why we are swizzling.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        IMP swizzledMethodImp = (IMP)__swizzled_statusBarControllingWindow;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        Method originalMethod = class_getClassMethod([self class], @selector(_statusBarControllingWindow));
#pragma clang diagnostic pop
        
        __original_imp_statusBarControllingWindow = method_setImplementation(originalMethod, swizzledMethodImp);
    });
    
    self.rootViewController = [[UIViewController alloc] init];
    
    self.overlayView = [[BBOverlayView alloc] init];
    self.overlayView.delegate = self;
    [self.rootViewController.view addSubview:self.overlayView];
}

#pragma mark - Touch

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL isPointInside;
    
    // If the Bug Hunt modal is being shown, behave normally...
    if (self.isShowingModal) {
        isPointInside = [super pointInside:point withEvent:event];
    }
    
    // Else, only capture touches on the Bug Hunt button...
    else {
        point = [self convertPoint:point toView:self.overlayView];
        isPointInside = [self.overlayView pointInside:point withEvent:event];
    }
    
    return isPointInside;
}

#pragma mark - BBOverlayViewControllerDelegate

- (void)overlayViewReceicedTap:(UIView *)overlayView
{
    // If the user hasn't been manually taking screenshots (via the overlay
    // gesture), take one for them.
    if ([BBScreenshotUtility screenshots].count == 0) {
        [BBScreenshotUtility captureScreenshotOfMainWindow];
    }
    
    self.keyWindowBeforeModal = [[UIApplication sharedApplication] keyWindow];
    
    if(self.configurationBlock != nil) {
        UIViewController *customViewController = self.configurationBlock([BBScreenshotUtility screenshots]);
        BBNavigationController *navVC = [[BBNavigationController alloc] initWithRootViewController:customViewController];
        navVC.bugBlasterDelegate = self;
        [self.rootViewController presentViewController:navVC
                                              animated:YES
                                            completion:^{
                                                self.isShowingModal = YES;
                                            }];
    }else{
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            mailVC.mailComposeDelegate = self;
            
            NSInteger idx = 0;
            
            for (UIImage *image in [BBScreenshotUtility screenshots]) {
                [mailVC addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:[NSString stringWithFormat:@"image%i", (int)idx]];
                idx++;
            }
            
            [self.rootViewController presentViewController:mailVC
                                                  animated:YES
                                                completion:^{
                                                    self.isShowingModal = YES;
                                                }];
        }
    }
    
    
    
}

- (void)overlayViewReceicedDoubleTap:(UIView *)overlayView
{
    // Save a screenshot for later...
    [BBScreenshotUtility captureScreenshotOfMainWindow];
    [self performScreenshotAnimation];
}

- (void)performScreenshotAnimation
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIImageView *screenshotImageView = [[UIImageView alloc] initWithFrame:screenBounds];
    screenshotImageView.image = [BBScreenshotUtility lastScreenshot];
    [self.rootViewController.view insertSubview:screenshotImageView
                                   belowSubview:self.overlayView];
    
    CGRect destinationRect = CGRectInset(self.overlayView.frame, 20, 20);
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         screenshotImageView.frame = destinationRect;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [screenshotImageView removeFromSuperview];
                         }
                     }];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error{
    [self.rootViewController dismissViewControllerAnimated:YES
                                                completion:^{
                                                    self.isShowingModal = NO;
                                                    
                                                    if ([self isKeyWindow]) {
                                                        [self.keyWindowBeforeModal makeKeyAndVisible];
                                                    }
                                                    
                                                    [BBScreenshotUtility clearScreenshots];
                                                }];
}

#pragma mark - BBNavigationControllerDelegate

- (void)navigationControllerWillDismiss:(BBNavigationController *)controller{
    self.isShowingModal = NO;
    
    if ([self isKeyWindow]) {
        [self.keyWindowBeforeModal makeKeyAndVisible];
    }
    
    [BBScreenshotUtility clearScreenshots];
}

@end
