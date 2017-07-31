
//
//  FPTCollectionViewCell.m
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import "FPTCollectionViewCell.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "FPTCacheManager.h"

@implementation FPTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.imageView];
        
        //Setting Constraints for cell
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.imageView.leadingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.leadingAnchor].active = YES;
        [self.imageView.trailingAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.trailingAnchor].active = YES;
        [self.imageView.topAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.topAnchor].active = YES;
        [self.imageView.bottomAnchor constraintEqualToAnchor: self.contentView.layoutMarginsGuide.bottomAnchor].active = YES;
    }
    return self;
}

- (void)prepareForReuse {
    self.imageView.image = nil;
}

- (void)setImageWithURL:(NSString *)url {
    if (!(self.imageView.image = [UIImage imageWithData:[FPTCacheManager getImageFromDBWithURL:url]])) {
        [self.imageView setImage:[UIImage imageNamed:@"test"]];
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData *data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:url]];
            if (data == nil)
                return;
            [FPTCacheManager saveImageToDBWithURL:url image:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageView setImage:[UIImage imageWithData:data]];
            });
        });
    }
}

@end
