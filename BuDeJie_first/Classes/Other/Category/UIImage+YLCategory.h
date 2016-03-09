//
//  UIImage+YLCategory.h
//  图片拉伸
//
//  Created by 张银龙 on 14/12/8.
//  Copyright © 2014年 张银龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLCategory)
/** 拉伸图片 */
+ (UIImage *)resizableImage:(NSString *)imgName;
/** 根据颜色生成一张尺寸为1*1的相同颜色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/** 图片高亮无默认颜色 */
+ (instancetype)imageOriginalName:(NSString *)imageName;
/** 无边框裁剪圆 */
+ (UIImage*)imageClipWithName:(NSString*)name;
/** 无边框裁剪圆 */
+ (UIImage*)imageClipWithImage:(UIImage*)image;
/** 有边框裁剪圆 */
+ (UIImage*)imageClipWithBorder:(CGFloat)border color:(UIColor*)color image:(UIImage*)image;
/** 切圆角 */
+ (UIImage*)imageClipWithRounded:(CGFloat)RoundedRect image:(UIImage*)image;
// 返回一张抗锯齿图片
// 本质：在图片生成一个透明为1的像素边框
/** 在周边加一个边框为1的透明像素 */
- (UIImage *)imageAntialias;
/** 保存图片到自定义相册 */
- (void)yl_saveToCustomAlbumWithCompletionHandler:(void (^)(BOOL success, NSError *error))handler;
@end
