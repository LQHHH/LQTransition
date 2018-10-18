//
//  PushViewController.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/17.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "PushViewController.h"
#import "LQTransitionManager.h"

@interface PushViewController ()



@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y);
    imageView.bounds = CGRectMake(0, 0, 280, 280);
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [LQTransitionManager transitionWithType:operation == UINavigationControllerOperationPush?LQTransitionTypePush:LQTransitionTypePop];
}



@end
