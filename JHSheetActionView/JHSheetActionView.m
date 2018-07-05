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
#define iPhoneX        CGRectGetHeight([[UIScreen mainScreen] bounds])==812
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
    //适配iPhoneX
    CGFloat markValue=iPhoneX?20.0f:0.0f;
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
        make.top.equalTo(weakSelf.mas_bottom);
    }];
    //底部view
    UIView *vw=[[UIView alloc] init];
    vw.backgroundColor=_bgViewColor?_bgViewColor: [UIColor whiteColor];
    [parentView addSubview:vw];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMark)];
    [vw addGestureRecognizer:tap];
    [vw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(markValue);
    }];
    //列表View
    UITableView *tableView=[[UITableView alloc] init];
    tableView.estimatedSectionHeaderHeight=tableView.estimatedSectionFooterHeight=0.0f;
    tableView.scrollEnabled=NO;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=cellHeight;
    tableView.backgroundColor=_markViewColor?_markViewColor:RGB(146, 149, 206);
    self.tableView=tableView;
    [parentView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(vw.mas_top);
        make.height.mas_equalTo(parentViewH);
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
  
    JHSheetCell *cell=[[JHSheetCell alloc] init];
    if (indexPath.row==[_sheetItems[indexPath.section] count]-1){
        cell.isHideLine=YES;
    }
    else {
       cell.isHideLine=NO;
        cell.divColor=_divColor;
    }
    cell.titleText=_sheetItems[indexPath.section][indexPath.row];
    cell.backgroundColor=_bgViewColor?_bgViewColor:[UIColor whiteColor];
    if (indexPath.section==1) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0){
        if ([_delegate respondsToSelector:@selector(didSelectCellForRowIndex:)]) {
             [_delegate didSelectCellForRowIndex:indexPath.row+1];
        }
        if (_callBackCellForRowIndex) {
            _callBackCellForRowIndex(indexPath.row+1);
        }

    }
    //退出蒙版
    [self closeMark];
    
   
    
    
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
    //设置颜色
    UIColor *divColor=_divColor?_divColor:RGB(233, 234, 229);
    [divColor set];
    CGContextAddRect(context,CGRectMake(0, rect.size.height-0.5, rect.size.width,0.5));
    CGContextStrokePath(context);
    
    
}

@end






