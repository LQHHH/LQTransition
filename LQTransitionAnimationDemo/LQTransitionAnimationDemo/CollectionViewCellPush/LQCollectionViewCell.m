//
//  LQCollectionViewCell.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/17.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "LQCollectionViewCell.h"

@interface LQCollectionViewCell ()

@property (nonatomic, readwrite) UIImageView *imageView;

@end

@implementation LQCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
    }
    return self;
}


#pragma mark - lazy

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"1"];
        _imageView.frame = self.bounds;
    }
    return _imageView;
}

@end
