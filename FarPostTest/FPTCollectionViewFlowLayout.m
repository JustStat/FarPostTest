//
//  FPTCollectionViewFlowLayout.m
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import "FPTCollectionViewFlowLayout.h"

@implementation FPTCollectionViewFlowLayout

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        [self updateCellSizeForFrame:frame];
        [self setScrollDirection:UICollectionViewScrollDirectionVertical];
        [self setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return self;
}

- (void)updateCellSizeForFrame:(CGRect)frame {
    CGFloat width = frame.size.width - 20;
    self.itemSize = CGSizeMake(width, width);
}

@end
