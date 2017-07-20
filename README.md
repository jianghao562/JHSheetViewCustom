##仿微信，一款相当实用的控件！

先导入项目工程并实现sheet协议
```
 #import "JHSheetActionView.h"
 @interface ViewController ()<JHSheetActionViewDelegate>
 ```
 初始化及实现delegate
 ```
- (IBAction)onClickStartButton:(UIButton *)btn{
    
   JHSheetActionView *sheetView= [[JHSheetActionView alloc] init];
    sheetView.sheetItems=@[@[@"标题1",@"标题2"],@[@"取消"]];
    sheetView.delegate=self;
    [sheetView showView];
    
}
#pragma mark - SheetDelegate
-(void)didSelectCellForRowIndex:(NSInteger)index
{
    
    NSLog(@"选择了第%zd个item",index);
    
}
`````
![image](https://github.com/jianghao562/JHSheetViewCustom/blob/master/GifFile/55555.gif)
