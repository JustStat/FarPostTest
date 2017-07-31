//
//  FPTCacheManager.m
//  FarPostTest
//
//  Created by Kirill Varlamov on 30.07.17.
//  Copyright © 2017 Kirill Varlamov. All rights reserved.
//

#import "FPTCacheManager.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation FPTCacheManager {
    
}

+ (NSArray *)urls
{
    static NSArray *urls;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        urls = @[@"https://images4.alphacoders.com/206/thumb-350-20658.jpg", @"https://images3.alphacoders.com/235/thumb-350-235575.jpg", @"https://images4.alphacoders.com/572/thumb-350-5726.jpg", @"https://images2.alphacoders.com/678/thumb-350-67800.jpg", @"https://images.alphacoders.com/519/thumb-350-51953.jpg", @"https://images5.alphacoders.com/374/thumb-350-374329.jpg"];
    });
    
    return urls;
}

+ (NSData *)getImageFromDBWithURL:(NSString *)url {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Image"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"url == %@", url]];
    
    NSError *error = nil;
    NSArray *images = (NSArray<NSManagedObject *> *)[context executeFetchRequest:request error:&error];
    
    if (!images) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        return nil;
    }
    if (images.count == 0) {
        return nil;
    }
    
    return (NSData *)[images[0] valueForKey:@"image"];
}

+ (void)saveImageToDBWithURL:(NSString *)url image:(NSData *)data {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = [delegate persistentContainer].viewContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:context];
    NSManagedObject *image = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    [image setValue:url forKey:@"url"];
    [image setValue:data forKey:@"image"];
    
    [context performBlockAndWait:^{
        
        NSError *error = nil;
        [context save:&error];
        
    }];
}

+ (void)clearCache {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Image"];
    
    NSError *error = nil;
    NSArray *images = (NSArray<NSManagedObject *> *)[context executeFetchRequest:request error:&error];
    
    for (int i = 0; i < images.count; i++) {
        [context deleteObject:images[i]];
    }
    if ([context save:&error] == NO) {
        
    }
}

@end
