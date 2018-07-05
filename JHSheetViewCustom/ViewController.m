//
//  ViewController.m
//  JHSheetViewCustom
//
//  Created by Jiang Hao on 2017/3/14.
//  Copyright © 2017年 Jiang Hao. All rights reserved.
//

#import "ViewController.h"
#import "JHSheetActionView.h"

@interface ViewController ()<JHSheetActionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn
;
@property (weak, nonatomic) IBOutlet UITextField *PWField;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    }


- (IBAction)onClickStartButton:(UIButton *)btn{
    
   JHSheetActionView *sheetView= [[JHSheetActionView alloc] init];
    
    sheetView.sheetItems=@[@[@"标题1",@"标题2",@"标题3"],@[@"取消"]];
    //使用block
    // sheetView.callBackCellForRowIndex = ^(NSInteger index) {
    // NSLog(@"选择了第%zd个item",index);
   // };
    //使用delegate
    sheetView.delegate=self;
    [sheetView showView];
    
}

-(void)didSelectCellForRowIndex:(NSInteger)index
{

    NSLog(@"选择了第%zd个item",index);

}



@end
