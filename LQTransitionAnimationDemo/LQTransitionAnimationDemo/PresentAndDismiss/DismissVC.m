//
//  DismissVC.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/10.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "DismissVC.h"
#import "LQTransitionManager.h"
#import "LQGestureTransition.h"

@interface DismissVC () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) LQGestureTransition *dismissGesture;

@end

@implementation DismissVC

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [[UIButton alloc] init];
    [button setFrame:CGRectMake((SCREEN_WIDTH-100)/2, 100, 100, 50)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.dismissGesture = [LQGestureTransition gestureTransitionWithType:LQGestureTransitionTypeDismiss direction:LQGestureTransitionGestureDirectionDown];
    [self.view addGestureRecognizer:self.dismissGesture.panGesture];
    self.dismissGesture.modalScale = 0.5;
    typeof(self)weakSelf = self;
    _dismissGesture.dismissBlock = ^(){
        [weakSelf click];
    };
}

- (void)click {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    LQTransitionManager *manager = [LQTransitionManager transitionWithType:LQTransitionTypePresent];
    //manager.fromVCTransiformScale = 1;
    manager.modalHeightScale = 0.5;
    return manager;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [LQTransitionManager transitionWithType:LQTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.dismissGesture.isGesture ? self.dismissGesture :nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.dismissGesture.isGesture ? self.presentTransition:nil;
}
@end
