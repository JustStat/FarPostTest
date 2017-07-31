//
//  FPTCollectionViewFlowLayout.h
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPTCollectionViewFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWithFrame:(CGRect)frame;
- (void)updateCellSizeForFrame:(CGRect)frame;

@end
