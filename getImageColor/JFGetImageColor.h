//
//  JFGetImageColor.h
//  getImageColor
//
//  Created by 卢见福 on 15/12/1.
//  Copyright © 2015年 hao123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JFGetImageColor : NSObject

- (UIColor*)getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image formImageRect:(CGRect)Rect;

@end
