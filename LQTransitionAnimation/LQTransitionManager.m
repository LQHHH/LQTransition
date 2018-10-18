//
//  LQTransitionManager.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/10.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "LQTransitionManager.h"
#import "CollectionViewMain.h"
#import "LQCollectionViewCell.h"
#import "PushViewController.h"
#import "CircleVC.h"

@interface LQTransitionManager () <CAAnimationDelegate>

@property (nonatomic, assign) LQTransitionType type;

@end

@implementation LQTransitionManager

+ (instancetype)transitionWithType:(LQTransitionType)type {
    LQTransitionManager *manager = [[LQTransitionManager alloc] init];
    manager.type = type;
    manager.modalHeightScale = 1;
    return manager;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case LQTransitionTypePresent:
            [self present:transitionContext];
            break;
            
        case LQTransitionTypeDismiss:
            [self dismiss:transitionContext];
            break;
        case LQTransitionTypePush:
            [self push:transitionContext];
            break;
        case LQTransitionTypePop:
            [self pop:transitionContext];
            break;
        case LQTransitionTypeCiclePresent:
            [self circlePresent:transitionContext];
            break;
        case LQTransitionTypeCircleDismiss:
            [self circleDismiss:transitionContext];
            break;
    }
}

- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *snapView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    snapView.frame = fromViewController.view.frame;
    fromViewController.view.hidden = YES;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:snapView];
    [containerView addSubview:toViewController.view];
    
    toViewController.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, self.modalHeightScale * containerView.frame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:0 animations:^{
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, -( self.modalHeightScale * containerView.frame.size.height));
        snapView.transform = CGAffineTransformMakeScale(self.fromVCTransiformScale == 0?0.8:self.fromVCTransiformScale, self.fromVCTransiformScale == 0?0.8:self.fromVCTransiformScale);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            fromViewController.view.hidden = NO;
            [snapView removeFromSuperview];
        }
    }];
   
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *snapView = [transitionContext containerView].subviews[0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:0 animations:^{
        fromViewController.view.transform = CGAffineTransformIdentity;
        snapView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            return;
        }
        [transitionContext completeTransition:YES];
        toViewController.view.hidden = NO;
        [snapView removeFromSuperview];
    }];
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    CollectionViewMain * fromVc = (CollectionViewMain *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PushViewController *toVc = (PushViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LQCollectionViewCell *cell = (LQCollectionViewCell *)[fromVc.collectionView cellForItemAtIndexPath:fromVc.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    
    cell.imageView.hidden = YES;
    toVc.view.alpha = 0;
    toVc.imageView.hidden = YES;
    
    [containerView addSubview:toVc.view];
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:0 animations:^{
        tempView.frame = [toVc.imageView convertRect:toVc.imageView.bounds toView:containerView];
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVc.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    PushViewController *fromVC = (PushViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CollectionViewMain * toVC = (CollectionViewMain *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LQCollectionViewCell *cell = (LQCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    cell.imageView.hidden = YES;
    fromVC.imageView.hidden = NO;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:0 animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        cell.imageView.hidden = NO;
        //[fromVC.view removeFromSuperview];
        [tempView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}


-(void)circlePresent:(id<UIViewControllerContextTransitioning>)transitionContext {
   UINavigationController *nav = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CircleVC *fromVC = (CircleVC *)nav.viewControllers.lastObject;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:fromVC.buttonFrame];
    CGFloat x = MAX(fromVC.buttonFrame.origin.x, containerView.frame.size.width - fromVC.buttonFrame.origin.x);
    CGFloat y = MAX(fromVC.buttonFrame.origin.y, containerView.frame.size.height - fromVC.buttonFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)circleDismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     CircleVC *toVC = (CircleVC *)nav.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];

    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:toVC.buttonFrame];
  
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
     [transitionContext completeTransition:YES];
}

@end
