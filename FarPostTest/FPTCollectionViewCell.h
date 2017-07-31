//
//  FPTCollectionViewCell.h
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPTCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

- (void)setImageWithURL:(NSString *)url;

@end
