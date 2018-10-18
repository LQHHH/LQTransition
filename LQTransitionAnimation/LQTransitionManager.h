//
//  LQTransitionManager.h
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/10.
//  Copyright © 2018 hhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LQTransitionType){
    LQTransitionTypePresent = 0,
    LQTransitionTypeDismiss,
    LQTransitionTypePush,
    LQTransitionTypePop,
    LQTransitionTypeCiclePresent,
    LQTransitionTypeCircleDismiss
};

@interface LQTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGFloat modalHeightScale;//模态的高度占屏幕的百分比,默认是1
@property (nonatomic, assign) CGFloat fromVCTransiformScale;//默认是0.8

+(instancetype)transitionWithType:(LQTransitionType)type;

@end


