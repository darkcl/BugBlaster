//
//  BBReport.h
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 2/9/2017.
//
//

#import <UIKit/UIKit.h>

@interface BBReport : NSObject

@property (nonatomic, strong) NSString *deviceVersion;

@property (nonatomic, strong) NSString *deviceModel;

@property (nonatomic, strong) NSString *appVersionNumber;

@property (nonatomic, strong) NSString *appBuildNumber;

@property (nonatomic, strong) NSArray <UIImage *> *images;

@property BOOL isNetworkReachable;

@property BOOL isPushEnable;

@property BOOL isGPSEnable;

@end
