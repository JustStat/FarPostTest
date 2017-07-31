//
//  FPTCacheManager.h
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FPTCacheManagerDelegate <NSObject>

@end

@interface FPTCacheManager : NSObject

+ (NSArray *)urls;

+ (NSData *)getImageFromDBWithURL:(NSString *)url;
+ (void)saveImageToDBWithURL:(NSString *)url image:(NSData *)data;
+ (void)clearCache;

@end
