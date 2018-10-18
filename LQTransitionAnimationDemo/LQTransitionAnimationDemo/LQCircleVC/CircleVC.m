//
//  CircleVC.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/17.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "CircleVC.h"
#import "CircleEndVC.h"

@interface CircleVC ()
@property (nonatomic, weak) UIButton *button;
@end

@implementation CircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"2"];
    imageView.frame = CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT);
    [self.view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;
    [button setFrame:CGRectMake(100, 100, 50,50)];
    [button setTitle:@"点击跳转" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
}

- (void)present {
    CircleEndVC *vc = [CircleEndVC new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (CGRect)buttonFrame{
    return _button.frame;
}


@end
