//
//  FPTCollectionViewController.m
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import "FPTCollectionViewController.h"
#import "FPTCollectionViewFlowLayout.h"
#import "FPTCollectionViewCell.h"
#import "FPTCacheManager.h"

@interface FPTCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView * collectionView;

@end

@implementation FPTCollectionViewController {
    NSMutableArray *currentImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    currentImages = [[FPTCacheManager urls] mutableCopy];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.collectionView setCollectionViewLayout:[[FPTCollectionViewFlowLayout alloc] initWithFrame:self.collectionView.bounds]];
    [self.collectionView registerClass:[FPTCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView.leadingAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.leadingAnchor].active = YES;
    [self.collectionView.trailingAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.trailingAnchor].active = YES;
    [self.collectionView.topAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.topAnchor].active = YES;
    [self.collectionView.bottomAnchor constraintEqualToAnchor: self.view.layoutMarginsGuide.bottomAnchor].active = YES;
    
    self.collectionView.refreshControl = [[UIRefreshControl alloc] init];
    [self.collectionView.refreshControl setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView.refreshControl setTintColor:[UIColor blackColor]];
    [self.collectionView.refreshControl addTarget:self action:@selector(refreshCollectionData) forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [(FPTCollectionViewFlowLayout *)self.collectionView.collectionViewLayout updateCellSizeForFrame:self.collectionView.bounds];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
}

- (void)refreshCollectionData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        currentImages = [[FPTCacheManager urls] mutableCopy];
        [FPTCacheManager clearCache];
        [self.collectionView reloadData];
        [self.collectionView.refreshControl endRefreshing];
    });
}

#pragma mark - UICollectionViewDelegateMethods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *lIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:lIndexPath];
    
    
    [UIView animateWithDuration:1.0 animations:^{
        cell.frame = CGRectMake(CGRectGetMaxX(collectionView.frame), cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        cell.alpha = 0;
        [collectionView performBatchUpdates:^ {
            [currentImages removeObjectAtIndex:indexPath.row];
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }completion:nil];

    }];
    
}

#pragma mark - UICollectionViewDataSourceMethods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return currentImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FPTCollectionViewCell *cell = (FPTCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setImageWithURL:currentImages[indexPath.row]];
    return cell;
}

#pragma mark - FPTDownloadManagerDelegate

- (void)managerHasDownloadedImage:(NSData *)data {
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
