//
//  BBScreenshotUtility.m
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 1/9/2017.
//
//

#import "BBScreenshotUtility.h"

#import "BBWindow.h"

@interface BBScreenshotUtility ()
@property (nonatomic, strong) NSMutableArray *screenshots;
@end

@implementation BBScreenshotUtility

+ (instancetype)sharedInstance
{
    static BBScreenshotUtility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BBScreenshotUtility alloc] init];
        sharedInstance.screenshots = [NSMutableArray array];
    });
    
    return sharedInstance;
}

+ (void)captureScreenshotOfMainWindow
{
    UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(mainWindow.bounds.size,
                                               NO, [UIScreen mainScreen].scale);
    }
    else {
        UIGraphicsBeginImageContext(mainWindow.bounds.size);
    }
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        
        // Don't draw the Bug Blaster overlay
        if ([window isKindOfClass:[BBWindow class]]) {
            continue;
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [window.layer renderInContext:context];
        
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[BBScreenshotUtility sharedInstance].screenshots addObject:screenshot];
}

+ (NSArray *)screenshots
{
    NSArray *screenshots = [[BBScreenshotUtility sharedInstance].screenshots copy];
    return screenshots;
}

+ (UIImage *)lastScreenshot
{
    return [[BBScreenshotUtility sharedInstance].screenshots lastObject];
}

+ (void)clearScreenshots
{
    [[BBScreenshotUtility sharedInstance].screenshots removeAllObjects];
}

@end
