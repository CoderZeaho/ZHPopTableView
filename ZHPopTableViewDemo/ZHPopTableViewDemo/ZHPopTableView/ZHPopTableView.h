//
//  ZHPopTableView.h
//  ZHPopTableViewDemo
//
//  Created by Zeaho on 2017/9/19.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHPopTableViewDelegate <NSObject>

- (void)createMusicPlaylist;

@end

@interface ZHPopTableView : UIView

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) id<ZHPopTableViewDelegate> delegate;

@property (nonatomic, assign, readonly) BOOL display;

@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)showInView:(UIView *)inView;

- (void)dismissAnimated:(BOOL)animated;

- (void)dismissAnimated:(BOOL)animated completion:(void (^)())completion;


@end
