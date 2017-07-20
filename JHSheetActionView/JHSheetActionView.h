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
@property(strong,nonatomic)NSArray *sheetItems;
@property(nonatomic,weak) id <JHSheetActionViewDelegate>delegate;
-(void)showView;
@end
@interface JHSheetCell : UITableViewCell
@property(copy,nonatomic)NSString *titleText;
@property(assign,nonatomic)BOOL isHideLine;

@end
