//
//  ViewController.m
//  Singleton
//
//  Created by qq on 2017/9/13.
//  Copyright © 2017年 fangxian. All rights reserved.
//

#import "ViewController.h"
#import "SingleLoading.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"我是首页";
    
    // 创建SingleLoading对象load
    SingleLoading *load = [[SingleLoading alloc] init];
    // 调用对象方法
    [load objectLoad];
    // 本质：让对象发送消息
    objc_msgSend(load, @selector(objectLoad));
    
    
    // 调用类方法的方式：两种
    // 第一种通过类名调用
    [SingleLoading beginLoad];
    // 第二种通过类对象调用
    [[SingleLoading class] beginLoad];
    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 本质：让类对象发送消息
    objc_msgSend([SingleLoading class], @selector(beginLoad));
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    unsigned int count = 0;
//    Class *classes = objc_copyClassList(&count);
//    for (int i = 0; i < count; i++) {
//        const char *cname = class_getName(classes[i]);
//        NSLog(@"当前工程加载的类%s\n", cname);
//    }
//}


- (IBAction)clickOnBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[SingleLoading sharedInstance] showInView:self.view];
    }else{
        [[SingleLoading sharedInstance] hide];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
