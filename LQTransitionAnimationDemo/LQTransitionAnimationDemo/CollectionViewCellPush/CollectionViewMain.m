//
//  CollectionViewMain.m
//  LQTransitionAnimationDemo
//
//  Created by hongzhiqiang on 2018/10/17.
//  Copyright © 2018 hhh. All rights reserved.
//

#import "CollectionViewMain.h"
#import "LQCollectionViewCell.h"
#import "PushViewController.h"

@interface CollectionViewMain () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, readwrite) NSIndexPath *currentIndexPath;

@end

@implementation CollectionViewMain

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     self.currentIndexPath = indexPath;
    PushViewController * vc = [PushViewController new];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSIndexPath *)currentIndexPath {
    return _currentIndexPath;
}

#pragma mark - lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-50)/4, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 100) collectionViewLayout:layout];
        [_collectionView registerClass:[LQCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
