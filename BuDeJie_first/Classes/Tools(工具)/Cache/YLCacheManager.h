//
//  YLGetCache.h
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLCacheManager : NSObject
+ (void)getCacheSizeCompletion:(void(^)(NSInteger totalSize))completionBlock;
+ (void)getCacheSizeWithDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completionBlock;
+ (void)removeCacheDataCompletion:(void(^)())completionBlock;
+ (void)removeDirectoryPath:(NSString *)directoryPath completion:(void(^)())completionBlock;

@end
