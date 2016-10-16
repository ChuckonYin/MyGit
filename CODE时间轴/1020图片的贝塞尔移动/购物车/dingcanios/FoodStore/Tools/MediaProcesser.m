//
//  MediaProcesser.m
//  Ailv_UI_0902
//
//  Created by liuguopan on 14-10-27.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "MediaProcesser.h"
#import <AVFoundation/AVFoundation.h>
#import "Utilities.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;

#else

int bitmapInfo = kCGImageAlphaPremultipliedLast;

#endif

@implementation MediaProcesser

////  保存视频
//+ (ModelPhoto *)saveVideo:(NSURL *)videoURL object:(ModelPhoto *)photo
//{
//    //  保存到媒体库
//    BOOL isSuccess = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoURL.path);
//    if (isSuccess) {
//        UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, self, nil, NULL);
//    }
//    
//    NSString *localPath = [File getLocalPath];
//    if (!localPath.length) {
//        photo.returnString = @"文件路径错误!";
//    }
//    
//    NSData *data = [NSData dataWithContentsOfURL:videoURL];
//    if (!data || ((NSNull *)data) == [NSNull null]) {
//        photo.returnString = @"获取视频资源失败!";
//    }
//    
//    NSString *moviePath = [localPath stringByAppendingFormat:@"/%@.mp4", photo.time];
//    LOG_NAME(@"视频路径", moviePath)
//    isSuccess = [data writeToFile:moviePath atomically:YES];
//
//    //  取出视频中的一帧图片
//    UIImage *image = [MediaProcesser getImage:videoURL];
//    
//    //  处理图片，不保存image到相册
//    return [MediaProcesser saveImage:image object:photo saveType:NO];
//}
//
////  保存图片
//+ (ModelPhoto *)saveImage:(UIImage *)image object:(ModelPhoto *)photo
//{
//    Log(@"time %@", photo.time)
//    return [MediaProcesser saveImage:image object:photo saveType:YES];
//}
//
////  处理图片
//+ (ModelPhoto *)saveImage:(UIImage *)image object:(ModelPhoto *)photo saveType:(BOOL)isSavedPhotosAlbum
//{
//    photo.group_time = [photo.time substringToIndex:6];
//    
//    BOOL isSuccess = NO;
//
//    if (isSavedPhotosAlbum) {
//        //  保存照片到相册
//        UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
//    }
//    
//    if (image.size.width > image.size.height) {
//        [MediaProcesser image:image rotation:UIImageOrientationRight];
//    }
//    if (image.size.width > SCREEN_WIDTH || image.size.height > SCREEN_HEIGHT) {
//        image = [MediaProcesser imageByScalingToSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) image:image];
//    }
////    image = [MediaProcesser image:image rotation:UIImageOrientationLeft];
//    
//    NSString *localPath = [File getLocalPath];
//    if (!localPath.length) {
//        photo.returnString = @"文件路径错误!";
//    }
//    /**
//     *  因为拍照和从视频中抓取的一帧图片的像素不同，
//     *  所以无论裁减还是加水印都应区分对待(isSavedPhotosAlbum/isPhoto)
//     */
//    /*
//    //  裁减，写入本地
//    UIImage *thumbImg = [MediaProcesser clipImage:image type:isSavedPhotosAlbum];
//    NSString *thumbImgPath = [localPath stringByAppendingFormat:@"/%@_thumb.lvjpg", photo.time];
//    //  compressionQuality压缩系数
//    isSuccess = [UIImageJPEGRepresentation(thumbImg, 1.0) writeToFile:thumbImgPath atomically:YES];
//    if (!isSuccess) {
//        LOG(@"生成缩略图失败!")
//    } else {
//        photo.thumb = [NSString stringWithFormat:@"%@_thumb.lvjpg", photo.time];
//    }
//    
//    //  水印(时间戳的前12位-YYYYMMddHHmm)
//    NSString *subString = [photo.time substringToIndex:12];
//    NSString *watermark = [MediaProcesser getFormatDate:subString];
//    UIImage *newImg = [MediaProcesser addText:image text:watermark type:isSavedPhotosAlbum];
//    NSString *newImgPath = [localPath stringByAppendingFormat:@"/%@.lvjpg", photo.time];
//    isSuccess = [UIImageJPEGRepresentation(newImg, 1.0f) writeToFile:newImgPath atomically:YES];
//    if (!isSuccess) {
//        photo.returnString = @"图片写入本地出错！";
//    } else {
//        photo.file = [NSString stringWithFormat:@"%@.lvjpg", photo.time];
//    }
//    photo.returnString = @"保存成功!";
//     */
//    return photo;
//}
//
////  裁减图片，并生成新图片(200X200pixs)
//+ (UIImage *)clipImage:(UIImage *)image type:(BOOL)isPhoto
//{
//    CGFloat width = image.size.width;
//    CGFloat height = image.size.height;
//    
//    NSLog(@"image width %lf height %lf", width, height);
//    
//    CGRect rect;
////    if (isPhoto) {
////        rect = CGRectMake(0,
////                          (image.size.height - image.size.width) / 2,
////                          SCREEN_WIDTH,
////                          SCREEN_WIDTH);
////    } else {
////        rect = CGRectMake(width/2 - 5000.0f,
////                          height/2 - 5000.0f,
////                          10000.0f,
////                          10000.0f);
////    }
//    rect = CGRectMake(0,
//                      (image.size.height - image.size.width) / 2,
//                      SCREEN_WIDTH,
//                      SCREEN_WIDTH);
//    CGImageRef cr = CGImageCreateWithImageInRect(image.CGImage, rect);
//    
//	UIImage *newImage = [UIImage imageWithCGImage:cr];
//    CGImageRelease(cr);
//    return newImage;
//
//}
//// 2
//+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(newSize);
//    
//    // Tell the old image to draw in this newcontext, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}
//
//+ (UIImage *)imageByScalingToSize:(CGSize)targetSize image:(UIImage *)image
//{
//    UIImage *sourceImage = image;
//    UIImage *newImage = nil;
//    CGSize imageSize = sourceImage.size;
//    CGFloat width = imageSize.width;
//    CGFloat height = imageSize.height;
//    CGFloat targetWidth = targetSize.width;
//    CGFloat targetHeight = targetSize.height;
//    CGFloat scaleFactor = 0.0;
//    CGFloat scaledWidth = targetWidth;
//    CGFloat scaledHeight = targetHeight;
//    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
//    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
//        CGFloat widthFactor = targetWidth / width;
//        CGFloat heightFactor = targetHeight / height;
//        if (widthFactor < heightFactor)
//            scaleFactor = widthFactor;
//        else
//            scaleFactor = heightFactor;
//        scaledWidth  = width * scaleFactor;
//        scaledHeight = height * scaleFactor;
//        // center the image
//        if (widthFactor < heightFactor) {
//            
//            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//        } else if (widthFactor > heightFactor) {
//            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//        }
//    }
//    // this is actually the interesting part:
//    UIGraphicsBeginImageContext(targetSize);
//    CGRect thumbnailRect = CGRectZero;
//    thumbnailRect.origin = thumbnailPoint;
//    thumbnailRect.size.width  = scaledWidth;
//    thumbnailRect.size.height = scaledHeight;
//    [sourceImage drawInRect:thumbnailRect];
//    newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    if(newImage == nil) {
//        NSLog(@"could not scale image");
//    } else {
//        Log(@"new image width is %f height is %f", newImage.size.width, newImage.size.height)
//    }
//    return newImage ;
//}
//
////  加水印（有些方法iOS7.0以后使用会有警告）
//+ (UIImage *)addText:(UIImage *)img text:(NSString *)text1 type:(BOOL)isPhoto
//{
//    Log(@"text1111111 %@", text1)
//    //get image width and height
//    int w = img.size.width;
//    int h = img.size.height;
//    Log(@"w = %d  h = %d", w, h)
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    //create a graphic context with CGBitmapContextCreate
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, bitmapInfo);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
//    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
//    //  CGContextShowTextAtPoint的x,y需要调整
//    CGFloat scrW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat scrH = [UIScreen mainScreen].bounds.size.height;
////    if (isPhoto) {
////        if (abs(w - scrW * 2) < 20) {
////            CGContextSelectFont(context, "Times New Roman", 70 / 3, kCGEncodingMacRoman);
////            CGContextShowTextAtPoint(context,
////                                     w/4 * 3-strlen(text)*5,
////                                     40,
////                                     text,
////                                     strlen(text));
////
////        } else {
////            CGContextSelectFont(context, "Times New Roman", 70, kCGEncodingMacRoman);
////            CGContextShowTextAtPoint(context,
////                                     w/4 * 3-strlen(text)*5,
////                                     40,
////                                     text,
////                                     strlen(text));
////        }
////    } else {
////        CGContextSelectFont(context, "Times New Roman", 70 / 6, kCGEncodingMacRoman);
////        CGContextShowTextAtPoint(context,
////                                 w - strlen(text) * 5.5,
////                                 40 / 6,
////                                 text,
////                                 strlen(text));
////    }
//    CGContextSelectFont(context, "Times New Roman", 70 / 4, kCGEncodingMacRoman);
//    CGContextShowTextAtPoint(context,
//                             w/4 * 3-strlen(text)*4,
//                             30,
//                             text,
//                             strlen(text));
//    //Create image ref from the context
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//}
//
////  从视频中获取一帧图片
//+ (UIImage *)getImage:(NSURL *)videoURL
//{
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
//    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//    gen.appliesPreferredTrackTransform = YES;
//    CMTime time = CMTimeMakeWithSeconds(1.0, 600);
//    NSError *error = nil;
//    CMTime actualTime;
//    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
//    CGImageRelease(image);
//    return thumb;
//    
//}
////  旋转image
//+ (UIImage *)fixOrientation:(UIImage *)aImage
//{
//    // No-op if the orientation is already correct
//    if (aImage.imageOrientation == UIImageOrientationUp)
//        return aImage;
//    
//    // We need to calculate the proper transformation to make the image upright.
//    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//            
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//            
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//        default:
//            break;
//    }
//    
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//            
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//        default:
//            break;
//    }
//    
//    // Now we draw the underlying CGImage into a new context, applying the transform
//    // calculated above.
//    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
//                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
//                                             CGImageGetColorSpace(aImage.CGImage),
//                                             CGImageGetBitmapInfo(aImage.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
//            break;
//            
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
//            break;
//    }
//    
//    // And now we just create a new UIImage from the drawing context
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
//}
////  旋转
//+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
//{
//    long double rotate = 0.0;
//    CGRect rect;
//    float translateX = 0;
//    float translateY = 0;
//    float scaleX = 1.0;
//    float scaleY = 1.0;
//    
//    switch (UIImageOrientationLeft) {
//        case UIImageOrientationLeft:
//            rotate = M_PI_2;
//            rect = CGRectMake(0, 0, image.size.height, image.size.width);
//            translateX = 0;
//            translateY = -rect.size.width;
//            scaleY = rect.size.width/rect.size.height;
//            scaleX = rect.size.height/rect.size.width;
//            break;
//        case UIImageOrientationRight:
//            rotate = 3 * M_PI_2;
//            rect = CGRectMake(0, 0, image.size.height, image.size.width);
//            translateX = -rect.size.height;
//            translateY = 0;
//            scaleY = rect.size.width/rect.size.height;
//            scaleX = rect.size.height/rect.size.width;
//            break;
//        case UIImageOrientationDown:
//            rotate = M_PI;
//            rect = CGRectMake(0, 0, image.size.width, image.size.height);
//            translateX = -rect.size.width;
//            translateY = -rect.size.height;
//            break;
//        default:
//            rotate = 0.0;
//            rect = CGRectMake(0, 0, image.size.width, image.size.height);
//            translateX = 0;
//            translateY = 0;
//            break;
//    }
//    
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //做CTM变换
//    CGContextTranslateCTM(context, 0.0, rect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextRotateCTM(context, rotate);
//    CGContextTranslateCTM(context, translateX, translateY);
//    
//    CGContextScaleCTM(context, scaleX, scaleY);
//    //绘制图片
//    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
//    
//    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
//    
//    return newPic;
//}
//
////+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
////{
////    return [UIImage imageWithCGImage:image.CGImage scale:1.0f orientation:UIImageOrientationUp];
////}
//
////  转化事件格式 201410271631 --> 2014-10-27 16:31 (HH-24h)
//+ (NSString *)getFormatDate:(NSString *)time
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYYMMddHHmm"];
//    NSDate *date = [dateFormatter dateFromString:time];
//    
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    return [dateFormatter stringFromDate:date];
//}


@end
