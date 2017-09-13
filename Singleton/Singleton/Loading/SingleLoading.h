//
//  SingleLoading.h
//  Singleton
//
//  Created by qq on 2017/9/13.
//  Copyright © 2017年 fangxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SingleLoading : NSObject
{
    UIView *_bgView;
    
    UIImageView     *_loadingView;
    UILabel         *_textLabel;
}
@property(nonatomic,strong) UIImageView *loadingView;

+ (id)sharedInstance;
- (void)showInWindow;// 慎用  会存在Window
- (void)showInView:(UIView *)view; // 默认情况 也建议使用
- (void)showInView:(UIView *)view WithText:(NSString *)text;
- (void)showInView:(UIView *)view WithText:(NSString *)text WithFrame:(CGRect)frame;
- (void)hide;

@end
