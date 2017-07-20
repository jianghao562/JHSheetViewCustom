//
//  JHSheetActionView.m
//  OCTest
//
//  Created by Jiang Hao on 2017/7/12.
//  Copyright © 2017年 Jiang Hao. All rights reserved.
//

#import "JHSheetActionView.h"
#import "Masonry.h"
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define  animationDuration 0.3
#define  cellHeight 50
#define  sectionMargin 5
#define  kFont [UIFont systemFontOfSize:17]
@interface JHSheetActionView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView * parentView;
@property(nonatomic,weak)UITableView * tableView;
@end

@implementation JHSheetActionView

//添加子控件
-(void)loadSubViews
{
     [[UIApplication sharedApplication].keyWindow addSubview:self];
    __weak typeof(self)weakSelf=self;

    CGFloat parentViewH=[_sheetItems.firstObject count]*cellHeight+ [_sheetItems.lastObject count]*cellHeight+sectionMargin;
    [weakSelf mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsZero);
      }];
   //底层View
    UIView * parentView=[[UIView alloc] init];
    self.parentView=parentView;
    [weakSelf addSubview:parentView];
    [parentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.offset(0);
        make.height.mas_equalTo(parentViewH);
        //make.height.mas_equalTo(155);
        make.top.equalTo(weakSelf.mas_bottom);
    }];
    //列表View
    UITableView *tableView=[[UITableView alloc] init];
    tableView.scrollEnabled=NO;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=cellHeight;
    tableView.backgroundColor=RGB(146, 149, 206);
    self.tableView=tableView;
    [parentView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
 
}
//展示蒙板
-(void)showView
{
    [self loadSubViews];
    self.backgroundColor=[UIColor colorWithWhite:0.f alpha:0.5];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMark)];
    tap.delegate=self;
    [self addGestureRecognizer:tap];
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
      
       self.parentView.transform=CGAffineTransformMakeTranslation(0, -self.parentView.frame.size.height);
        
    }];
    
}


//关闭蒙版
-(void)closeMark

{
    [UIView animateWithDuration:0.4 animations:^{
        self.parentView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.alpha=0.0;
        [self.parentView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

//解决手势冲突问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   if ([touch.view isKindOfClass:self.class]) return YES;
    
   return NO;
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sheetItems.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sheetItems[section] count];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //最后的cell
   
    JHSheetCell *cell=[[JHSheetCell alloc] init];
    if (indexPath.row==[_sheetItems[indexPath.section] count]-1) cell.isHideLine=YES;
    else cell.isHideLine=NO;
    cell.titleText=_sheetItems[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([_delegate respondsToSelector:@selector(didSelectCellForRowIndex:)]) {
        
        if (indexPath.section==0)[_delegate didSelectCellForRowIndex:indexPath.row+1];
        else [self closeMark];
      
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) return 5.0f;
    
    return 0.1f;

}
@end

#pragma mark - JHSheetCell

@interface JHSheetCell()
@property(weak,nonatomic)UILabel *labelView;
@end

@implementation JHSheetCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *labelView=[[UILabel alloc] init];
         _labelView=labelView;
         labelView.font=kFont;
         labelView.textColor=[UIColor blackColor];
         [self.contentView addSubview:_labelView];
        [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.center.equalTo(self);
       }];
        _isHideLine=NO;
        UIView *vw=[[UIView alloc] init];
        vw.backgroundColor=RGBA(205, 210, 222,0.5);
        UIView *bw= [[UIView alloc] init];
        bw.backgroundColor=RGBA(119, 120, 121, 0.5);
        self.backgroundView=vw;
        self.selectedBackgroundView=bw;
    }

    return self;
}


//设置cell标题
-(void)setTitleText:(NSString *)titleText
{
    _titleText=titleText;
    
    self.labelView.text=titleText;
    

}


-(void)drawRect:(CGRect)rect
{
    if (_isHideLine) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //直线宽度
   // CGContextSetLineWidth(context, 0.1);
    //设置颜色
    [RGBA(191, 198, 210, 1.0) set];
    CGContextAddRect(context,CGRectMake(0, rect.size.height-0.3, rect.size.width,0.3));
    CGContextStrokePath(context);
    

}


@end





