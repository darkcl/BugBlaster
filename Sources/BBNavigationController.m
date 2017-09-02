//
//  BBNavigationController.m
//  BugBlaster
//
//  Created by Yeung Yiu Hung on 2/9/2017.
//
//

#import "BBNavigationController.h"

@interface BBNavigationController ()

@end

@implementation BBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(navigationControllerWillDismiss:)]) {
        [self.delegate navigationControllerWillDismiss:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
