//
//  SingleLoading.m
//  Singleton
//
//  Created by qq on 2017/9/13.
//  Copyright © 2017年 fangxian. All rights reserved.
//

#import "SingleLoading.h"

@implementation SingleLoading

#pragma mark --单例的创建
//// 方法1 比较传统的写法  懒汉式
//+ (id)sharedInstance {
//    static id sharedInstance = nil;
//    @synchronized(sharedInstance){
//        if(sharedInstance == nil)
//        {
//            sharedInstance = [[self alloc] init];
//        }
//    }
//    return sharedInstance;
//}

//// 方法2：双重检查加锁  推荐使用
//+ (id)sharedInstance {
//    volatile static SingleLoading *singleInstance = nil;
//    if (singleInstance == nil) {
//        @synchronized(self) {
//            if (singleInstance == nil) {
//                singleInstance = [[self alloc] init];
//            }
//        }
//    }
//    return singleInstance;
//}

// 方法3: GCD的dispatch_once
+ (id)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self != nil)
    {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _bgView.backgroundColor=[UIColor clearColor];
        //        _bgView.backgroundColor=[UIColor blackColor];
        //        _bgView.alpha=0.4;
        
        _loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 350/2.0, 350/2.0)];
        
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
        for(NSInteger i = 1; i <=10; i++)
        {
            // image文件在 Assets里
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"页面内加载_动效序列帧0%li.png", (long)i]];
            [imageArray addObject:image];
        }
        
        _loadingView.animationImages = imageArray;
        _loadingView.animationDuration = 0.5f;
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_loadingView.frame)+6, 135, 20)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:12.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

// 慎用  会存在Window
- (void)showInWindow{
    if([[[UIApplication sharedApplication] windows] count] > 1)
    {
        [[SingleLoading sharedInstance] showInView:[[[UIApplication sharedApplication] windows] objectAtIndex:1]];
    }
    else
    {
        [[SingleLoading sharedInstance] showInView:[[UIApplication sharedApplication] keyWindow]];
    }
}

- (void)showInView:(UIView *)view
{
    [self showInView:view WithText:@"正在加载中，请稍候..."];
}

// 建议使用  只存在view 含导航条
- (void)showInView:(UIView *)view WithText:(NSString *)text
{
    NSLog(@"height=%f",view.frame.size.height); // translucent 属性原因   导航条64 可能存在这个误差
    [self showInView:view WithText:text WithFrame:CGRectMake((view.frame.size.width - _loadingView.frame.size.width) / 2, (view.frame.size.height - _loadingView.frame.size.height) / 2, _loadingView.frame.size.width, _loadingView.frame.size.height)];
}

- (void)showInView:(UIView *)view WithText:(NSString *)text WithFrame:(CGRect)frame
{
    [view addSubview:_bgView];
    
    _loadingView.frame = frame;
    [view addSubview:_loadingView];
    
    _textLabel.text = text;
    
    [_textLabel sizeToFit];
    
    _textLabel.center=CGPointMake(view.center.x, _loadingView.center.y+_loadingView.frame.size.height/2.0+10);
    [view addSubview:_textLabel];
    
    [_loadingView startAnimating];
    
}

- (void)hide
{
    [_loadingView stopAnimating];
    [_bgView removeFromSuperview];
    [_loadingView removeFromSuperview];
    [_textLabel removeFromSuperview];
}

@end
