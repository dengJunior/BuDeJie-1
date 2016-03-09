//
//  YLGetCache.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLCacheManager.h"

@implementation YLCacheManager

+ (void)getCacheSizeCompletion:(void(^)(NSInteger totalSize))completionBlock{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [self getCacheSizeWithDirectoryPath:cache completion:completionBlock];
}
+ (void)getCacheSizeWithDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completionBlock{
    
    // 开启异步任务
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取default尺寸
        // 1.创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        // 判断下当前文件是否存在,是否是文件夹
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isExist || !isDirectory) {
            NSException *excp =  [NSException exceptionWithName:@"fileError" reason:@"传入文件不存在,或者不是文件夹,给我传文件夹过来" userInfo:nil];
            [excp raise];
        }
        // 2.获取文件夹中所有文件路径
        // Path:文件夹
        // 指定一个文件夹路径,就能获取这个文件夹中所有子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        // 2.1 遍历文件夹中所有子路径
        for (NSString *subPath in subPaths) {
            // 2.2 拼接文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            // 排除隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            // 排除文件夹
            BOOL isDirectory;
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            // 2.3 获取这个路径信息
            // attributesOfItemAtPath:只能获取文件尺寸,不能获取文件夹尺寸
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize += [attr fileSize];
        }
        // 一定要记得在主线程调用block
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(totalSize);
            }
        });
    });
}
+ (void)removeCacheDataCompletion:(void(^)())completionBlock{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [self removeDirectoryPath:cache completion:completionBlock];
}
+ (void)removeDirectoryPath:(NSString *)directoryPath completion:(void(^)())completionBlock{
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager *mgr = [NSFileManager defaultManager];
        // 判断下当前文件是否存在,是否是文件夹
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        
        if (!isExist || !isDirectory) {
            NSException *excp =  [NSException exceptionWithName:@"fileError" reason:@"传入文件不存在,或者不是文件夹,给我传文件夹过来" userInfo:nil];
            [excp raise];
        }
        
        // 获取文件夹中所有文件
        NSArray *contentPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
        
        // 遍历所有子路径
        for (NSString *contentPath in contentPaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:contentPath];
            [mgr removeItemAtPath:filePath error:nil];
        }

        // 一定要记得在主线程调用block
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock();
            }
        });
    });
}



@end
