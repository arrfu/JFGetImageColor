//
//  ViewController.m
//  getImageColor
//
//  Created by 卢见福 on 15/12/1.
//


#import "ViewController.h"
#import "JFGetImageColor.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.imageIndex = 0;
    self.imageView.userInteractionEnabled = YES; // ImageView默认不响应事件
    [self imageColorPicker];
    [self addButton];
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"%@",gestureRecognizer);
    return YES;
}

/**
 * 获取图片颜色
 */
- (void)imageColorPicker {
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",self.imageIndex]];
    self.imageView.image = image;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActon:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.imageView addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panActon:)];
    [self.imageView addGestureRecognizer:panGesture];
    
}

/**
 * 点击手势
 */
- (void)tapActon:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.imageView];
    NSLog(@"tap = %@",tap);
    
    //取色
    JFGetImageColor *comparison = [[JFGetImageColor alloc]init];
    self.view.backgroundColor = [comparison getPixelColorAtLocation:point inImage:self.imageView.image formImageRect:self.imageView.frame];
}

/**
 * 拖动手势
 */
-(void)panActon:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self.imageView];
    NSLog(@"pan");
    
    NSLog(@"%f,%f,%f,%f",point.x,point.y,self.imageView.bounds.origin.x,self.imageView.bounds.origin.y);
    
    if ([self isTouchPointAvaiable:point atImageRect:self.imageView.bounds]) {
        //取色
        JFGetImageColor *comparison = [[JFGetImageColor alloc]init];
        self.view.backgroundColor = [comparison getPixelColorAtLocation:point inImage:self.imageView.image formImageRect:self.imageView.bounds];
    }
}

/**
 * CGPath创建一个区域，区域是由路径做两点间线段并闭合成的区域，
 * 然后就可以用CGPath相关函数CGPathContainsPoint判断点是否在区域里了。
 *比如这里创建了一个简单的矩形。它的frame为(4, 4, 10, 10)。 四个顶点的坐标分别为(4, 4), (4, 14), (14, 14), (14, 4)
 */
-(BOOL)isTouchPointAvaiable:(CGPoint)touchPoint atImageRect:(CGRect)rect{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat w = rect.size.width-1;
    CGFloat h = rect.size.height-1;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, x, y);
    CGPathAddLineToPoint(pathRef, NULL, x, y + h);
    CGPathAddLineToPoint(pathRef, NULL, x + w, y + h);
    CGPathAddLineToPoint(pathRef, NULL, x + w, y);
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    CGPathCloseSubpath(pathRef);
    
    if (CGPathContainsPoint(pathRef, NULL, touchPoint, NO)) {
        NSLog(@"point in path");
        return YES;
    }
    
    NSLog(@"point out of path");
    
    return NO;
}

/**
 * 添加imageView
 */
-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height-140)];
        [self.view addSubview:_imageView];
    }
    
    return _imageView;
}

/**
 * 添加按钮btn
 */
-(void)addButton{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5-40, [UIScreen mainScreen].bounds.size.height-80, 80, 50)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"下一张" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(NextAction) forControlEvents:UIControlEventTouchDown];
}

/**
 * 下一张
 */
- (void)NextAction{
    if (self.imageIndex < 14) {
        self.imageIndex ++;
    }
    else{
        self.imageIndex = 0;
    }
    [self imageColorPicker];
}




@end
