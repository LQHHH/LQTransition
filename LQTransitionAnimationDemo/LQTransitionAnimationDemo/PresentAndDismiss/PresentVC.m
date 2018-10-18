//
//  PresentVC.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/10.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "PresentVC.h"
#import "DismissVC.h"
#import "LQGestureTransition.h"

@interface PresentVC () 

@property (nonatomic, strong) LQGestureTransition *presentGesture;

@end

@implementation PresentVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] init];
    [button setFrame:CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT/2, 100, 50)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"present" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.presentGesture = [LQGestureTransition gestureTransitionWithType:LQGestureTransitionTypePresent direction:LQGestureTransitionGestureDirectionUp];
    self.presentGesture.modalScale = 0.5;
    [self.view addGestureRecognizer:self.presentGesture.panGesture];
    typeof(self)weakSelf = self;
    _presentGesture.presentBlock = ^(){
        [weakSelf click];
    };
}

- (void)click {
    DismissVC *vc = [DismissVC new];
    vc.presentTransition = self.presentGesture;
    [self presentViewController:vc animated:YES completion:nil];
}





@end
