//
//  JHSheetActionView.h
//  OCTest
//
//  Created by Jiang Hao on 2017/7/12.
//  Copyright © 2017年 Jiang Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHSheetActionViewDelegate <NSObject>
//对外点击cell对应的索引
-(void)didSelectCellForRowIndex:(NSInteger)index;
@end

@interface JHSheetActionView : UIView
@property(strong,nonatomic)NSArray *sheetItems;//添加列表内容
@property(strong,nonatomic)UIColor *markViewColor;//取消顶部的mark颜色
@property(strong,nonatomic)UIColor *bgViewColor;//每条列表的背景色
@property(strong,nonatomic)UIColor * divColor;//分割线颜色
@property(nonatomic,weak) id <JHSheetActionViewDelegate>delegate;
@property(nonatomic,copy) void(^callBackCellForRowIndex)(NSInteger index);
-(void)showView;
@end
@interface JHSheetCell : UITableViewCell
@property(copy,nonatomic)NSString *titleText;
@property(assign,nonatomic)BOOL isHideLine;
@property(strong,nonatomic)UIColor * divColor;
@end
