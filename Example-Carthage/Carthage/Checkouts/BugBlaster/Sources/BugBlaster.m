//
//  BugBlaster.m
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import "BugBlaster.h"
#import "BBWindow.h"
#import "BBScreenshotUtility.h"

@interface BugBlaster ()

@property (nonatomic, weak) UIWindow *mainAppWindow;
@property (nonatomic, strong) BBWindow *bugBlasterWindow;

@end

@implementation BugBlaster


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mainAppWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return self;
}

/**
 *  This is a private method. We don't want people to actually use an
 *  instance of BugHunt. Instead, we want them to use the interface we've
 *  provided in the header file.
 */
+ (instancetype)sharedInstance
{
    static BugBlaster *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Factory Methods

+ (void)showBugBlaster
{
    [BugBlaster showBugBlasterAtLevel:UIWindowLevelStatusBar - 1];
}

+ (void)showBugBlasterAtLevel:(NSInteger)windowLevel
{
    BugBlaster* bugBlaster = [BugBlaster sharedInstance];
    
    if (bugBlaster.bugBlasterWindow == nil) {
        bugBlaster.bugBlasterWindow = [[BBWindow alloc] init];
    }
    
    bugBlaster.bugBlasterWindow.windowLevel = windowLevel;
    [bugBlaster.bugBlasterWindow makeKeyAndVisible];
    
    // We just want bugHunt to be visible, not key.
    [bugBlaster.mainAppWindow makeKeyAndVisible];
}

+ (void)hideBugBlaster
{
    [BugBlaster hideBugBlasterAndDeallocate:YES];
}

+ (void)hideBugBlasterAndDeallocate:(BOOL)shouldDeallocate
{
    [BBScreenshotUtility clearScreenshots];
    
    BugBlaster* bugBlaster = [BugBlaster sharedInstance];
    bugBlaster.bugBlasterWindow.hidden = YES;
    [bugBlaster.mainAppWindow makeKeyAndVisible];
    
    if (shouldDeallocate) {
        bugBlaster.bugBlasterWindow = nil;
    }
}

@end
