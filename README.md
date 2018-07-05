#仿微信sheetView，一款相当实用的控件！</br>
引入pod
```
pod 'JHSheetActionView'

```
1.使用block
```
 JHSheetActionView *sheetView= [[JHSheetActionView alloc] init];
    sheetView.sheetItems=@[@[@"标题1",@"标题2,@"标题3"],@[@"取消"]];
     sheetView.callBackCellForRowIndex = ^(NSInteger index) {
      NSLog(@"选择了第%zd个item",index);
    };
    [sheetView showView];
```
2.使用delegate
```
 #import "JHSheetActionView.h"
 @interface ViewController ()<JHSheetActionViewDelegate>
   JHSheetActionView *sheetView= [[JHSheetActionView alloc] init];
    sheetView.sheetItems=@[@[@"标题1",@"标题2"],@[@"取消"]];
    sheetView.delegate=self;
    [sheetView showView];   
}
#pragma mark - SheetDelegate
-(void)didSelectCellForRowIndex:(NSInteger)index{
      NSLog(@"选择了第%zd个item",index);    
    }
@end
`````
![image](https://github.com/jianghao562/JHSheetViewCustom/blob/master/GifFile/55555.gif)
