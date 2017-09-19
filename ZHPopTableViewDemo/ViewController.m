//
//  ViewController.m
//  ZHPopTableViewDemo
//
//  Created by Zeaho on 2017/9/19.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ViewController.h"
#import "ZHPopTableView.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) ZHPopTableView *popTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"点击蓝色空白区域";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.56 green:0.84 blue:1.00 alpha:1.00];
}

- (ZHPopTableView *)popTableView {
    if (!_popTableView) {
        _popTableView = [[ZHPopTableView alloc] initWithFrame:[[self view] bounds]];
    }
    return _popTableView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![[self popTableView] display]) {
        AppDelegate *tempDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[self popTableView] showInView:[tempDelegate window]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
