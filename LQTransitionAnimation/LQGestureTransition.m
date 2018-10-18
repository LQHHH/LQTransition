//
//  LQGestureTransition.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/10.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "LQGestureTransition.h"

@interface LQGestureTransition ()

@property (nonatomic, assign) LQGestureTransitionType type;
@property (nonatomic, assign) LQGestureTransitionGestureDirection direction;
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *panGesture;

@end

@implementation LQGestureTransition

+ (instancetype)gestureTransitionWithType:(LQGestureTransitionType)type direction:(LQGestureTransitionGestureDirection)direction {
    return [[LQGestureTransition alloc] initWithTransitionWithType:type direction:direction];
}

- (instancetype)initWithTransitionWithType:(LQGestureTransitionType)type direction:(LQGestureTransitionGestureDirection)direction {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.type = type;
    self.direction = direction;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.modalScale = 1;
    
    return self;
}

- (UIPanGestureRecognizer *)panGesture {
    return _panGesture;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture {
    CGFloat persent = 0;
    
    switch (_direction) {
        case LQGestureTransitionGestureDirectionLeft:{
            CGFloat x = -[panGesture translationInView:panGesture.view].x;
            persent = x / panGesture.view.frame.size.width;
            break;
        }
       
        case LQGestureTransitionGestureDirectionRight: {
            CGFloat x = [panGesture translationInView:panGesture.view].x;
            persent = x / panGesture.view.frame.size.width;
            break;
        }
        case LQGestureTransitionGestureDirectionUp: {
            CGFloat y = -[panGesture translationInView:panGesture.view].y;
            persent = y / panGesture.view.frame.size.height*self.modalScale;
            break;
        }
        case LQGestureTransitionGestureDirectionDown: {
            CGFloat y = [panGesture translationInView:panGesture.view].y;
            persent = y / panGesture.view.frame.size.height*self.modalScale;
            break;
        }
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.isGesture = YES;
            [self startGesture];
            break;
        }
            
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:persent];
            break;
        }
            
        case UIGestureRecognizerStateEnded:{
            self.isGesture = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }
            else {
                [self cancelInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
    
}

- (void)startGesture {
    switch (_type) {
        case LQGestureTransitionTypePresent:{
            if (self.presentBlock) {
                self.presentBlock();
            }
            break;
        }
        
        case LQGestureTransitionTypeDismiss: {
            if (self.dismissBlock) {
                self.dismissBlock();
            }
            break;
        }
        case LQGestureTransitionTypePush: {
            if (self.pushBlock) {
                self.pushBlock();
            }
            break;
        }
        case LQGestureTransitionTypePop: {
            if (self.popBlock) {
                self.popBlock();
            }
            break;
        }
    }
}

@end
