//
//  JFGetImageColor.m
//  getImageColor
//
//  Created by 卢见福 on 15/12/1.
//  Copyright © 2015年 hao123. All rights reserved.
//

#import "JFGetImageColor.h"

@implementation JFGetImageColor


//获取图片点point处的像素颜色
- (UIColor*)getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image formImageRect:(CGRect)Rect {
    
    //获得图片上下文
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage inIamgeRect:Rect];
    if (cgctx == NULL) { return nil;}
    
    //获取重绘图片大小
    size_t w = Rect.size.width;
    size_t h = Rect.size.height;
    
    CGRect rect = {{0,0},{w,h}};
    
    //重绘图片
    CGContextDrawImage(cgctx, rect, inImage);
    
    //获得图片ARGB色彩分量
    unsigned char* data = CGBitmapContextGetData (cgctx);
    
    NSLog(@"length = %llu",strlen(CGBitmapContextGetData (cgctx)));
//    NSLog(@"------%s----",data);
    NSLog(@"%f,%f,%f,%f",Rect.origin.x,Rect.origin.y,Rect.size.width,Rect.size.height);
     NSLog(@"x:%f y:%f", point.x, point.y);
    
    if (data != NULL) {
        //offset为偏移量，用于定位数组中的对应像素信息
        int offset = 4*((w*round(point.y))+round(point.x));
        NSLog(@"offset = %d",offset);
        
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,
              blue,alpha);
        
        NSLog(@"x:%f y:%f", point.x, point.y);
        
        //取得该色
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:
                 (blue/255.0f) alpha:(alpha/255.0f)];
    }
    
    //释放上下文空间
    CGContextRelease(cgctx);
    
    if (data) { free(data); }
    
    return color;
    
}

//创建图片上下文空间
- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef)inImage inIamgeRect:(CGRect)rect {
    
    CGContextRef    context = NULL;
    
    CGColorSpaceRef colorSpace;
    
    void *          bitmapData;
    
    int             bitmapByteCount;
    
    int             bitmapBytesPerRow;
    
    //根据rect参数绘制
    int pixelsWide = rect.size.width;
    int pixelsHigh = rect.size.height;
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
        
    {
        
        fprintf(stderr, "Error allocating color space\n");
        
        return NULL;
        
    }
    //开辟空间
    bitmapData = malloc( bitmapByteCount );
    
    if (bitmapData == NULL)
        
    {
        
        fprintf (stderr, "Memory not allocated!");
        
        CGColorSpaceRelease( colorSpace );
        
        return NULL;
        
    }
    //参数2 为枚举值 kCGImageAlphaPremultipliedFirst
    context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, 2);
    
    if (context == NULL)
        
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    //释放空间
    CGColorSpaceRelease( colorSpace );
    return context;
}


@end
