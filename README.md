# JFGetImageColor
照片取色Demo

1.使用接口：

- (UIColor*)getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image formImageRect:(CGRect)Rect;
- 
2.使用例子：

//取色
    JFGetImageColor *comparison = [[JFGetImageColor alloc]init];
    self.view.backgroundColor = [comparison getPixelColorAtLocation:point inImage:self.imageView.image formImageRect:self.imageView.frame];
    
3.效果：

![oc](/res/img/blog/2015/1/getImageColor/imageColor1.png)
![oc](/res/img/blog/2015/1/getImageColor/imageColor2.png)
![oc](/res/img/blog/2015/1/getImageColor/imageColor3.png)
![oc](/res/img/blog/2015/1/getImageColor/imageColor4.png)
