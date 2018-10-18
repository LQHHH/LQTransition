//
//  LQGestureTransition.h
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/10.
//  Copyright © 2018 hhh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureBlock)(void);

typedef NS_ENUM(NSUInteger, LQGestureTransitionType) {
    LQGestureTransitionTypePresent = 0,
    LQGestureTransitionTypeDismiss,
    LQGestureTransitionTypePush,
    LQGestureTransitionTypePop
};

typedef NS_ENUM(NSUInteger, LQGestureTransitionGestureDirection){
    LQGestureTransitionGestureDirectionLeft = 0,
    LQGestureTransitionGestureDirectionRight,
    LQGestureTransitionGestureDirectionUp,
    LQGestureTransitionGestureDirectionDown
};

@interface LQGestureTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isGesture;
@property (nonatomic, copy) GestureBlock presentBlock;
@property (nonatomic, copy) GestureBlock dismissBlock;
@property (nonatomic, copy) GestureBlock pushBlock;
@property (nonatomic, copy) GestureBlock popBlock;
@property (nonatomic, assign) CGFloat modalScale;//模态弹出的高度占屏幕高度的百分比,默认是1
@property (readonly) UIPanGestureRecognizer *panGesture;

+ (instancetype)gestureTransitionWithType:(LQGestureTransitionType)type direction:(LQGestureTransitionGestureDirection)direction;

- (instancetype)initWithTransitionWithType:(LQGestureTransitionType)type direction:(LQGestureTransitionGestureDirection)direction;

@end

