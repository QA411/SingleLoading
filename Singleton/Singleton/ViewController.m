//
//  ViewController.m
//  Singleton
//
//  Created by qq on 2017/9/13.
//  Copyright © 2017年 fangxian. All rights reserved.
//

#import "ViewController.h"
#import "SingleLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"我是首页";
    
}


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
