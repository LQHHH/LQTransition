//
//  CollectionViewMain.h
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/17.
//  Copyright © 2018 hhh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewMain : UIViewController

@property (nonatomic, readonly) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

NS_ASSUME_NONNULL_END
