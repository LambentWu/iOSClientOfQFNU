//
//  MainController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//
#import "QFNUAboutUsController.h"
#import "QFNUBackController.h"
#import "QFNUCConsultController.h"
#import "QFNUCommunityController.h"
#import "QFNULoginController.h"
#import "QFNUNewController.h"
#import "QFNULookController.h"
#import "QFNUToolController.h"

#import "MainController.h"
#import "MainHeadScrollView.h"
#import "MainButtonModel.h"
#import "MainButtonView.h"
#import "MJExtension.h"

@interface MainController ()

@property (nonatomic,strong) MainHeadScrollView* scrollView;
@property (nonatomic, strong) NSArray* dataArr;

@property(nonatomic,strong)UIView* allMainBtnView;
@end

@implementation MainController

-(NSArray*)dataArr{
    if (_dataArr ==nil) {
        NSString* dataPath = [[NSBundle mainBundle]pathForResource:@"MainButtonData" ofType:@"plist"];
        self.dataArr = [NSArray arrayWithContentsOfFile:dataPath];
        NSMutableArray* tempArray = [NSMutableArray array];
        for (NSDictionary* dic in self.dataArr) {
            MainButtonModel* model = [MainButtonModel btnWihtDict:dic];
            [tempArray addObject:model];
        }
        self.dataArr = tempArray;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (MainButtonModel* btnView in self.dataArr) {
        NSLog(@"%@",btnView.name);
    }

    [self setMainHeadScrollView];
    [self setButtonView];
    
}



-(void)setMainHeadScrollView{
    self.scrollView = [[MainHeadScrollView alloc]initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width-20, 200) ImagesCount:5];
    //点击图片的回调＃＃＃＃＃＃＃＃＃＃
    [self.scrollView tapImageViewBlock:^(NSInteger tag) {
        NSLog(@"点击图片Block回调  %zd",tag);
        
    }];
    [self.view addSubview:self.scrollView];
}


-(void)setButtonView{
    CGFloat Bwidth = self.view.frame.size.width;
    CGFloat Bheight = self.view.frame.size.height;
    NSLog(@"%f,%f",Bheight,Bwidth);
    UIView* allMainBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,Bheight*0.5,Bwidth,Bheight*0.5)];
    
    _allMainBtnView = allMainBtnView;
    _allMainBtnView.backgroundColor = [UIColor brownColor];
    NSInteger allCols = 4;
    
    // 2.商品的宽度 和 高度
    CGFloat width = 80;
    CGFloat height = 80;
    // 3.求出水平间距 和 垂直间距
    CGFloat allMainBtnviewWidth = self.allMainBtnView.frame.size.width;
    CGFloat allMainBtnviewHeight = self.allMainBtnView.frame.size.height;
    CGFloat hMargin = (allMainBtnviewWidth - allCols * width) / (allCols -1);
    CGFloat vMargin = (allMainBtnviewHeight - 4*height) / 1;
    for (int i=0;i<12;i++) {
    // 4. 设置索引
    NSInteger index = self.allMainBtnView.subviews.count;
    
    // 5.求出x值
    CGFloat x = (hMargin + width) * (index % allCols);
    CGFloat y = (vMargin + height) * (index / allCols);
    
    /***********************2.创建一个商品*****************************/
        MainButtonView *btnView = [[MainButtonView alloc] initWithModel:self.dataArr[index]];
        
        btnView.frame = CGRectMake(x, y, width, height);
        NSLog(@"dataArrrrrrr:%@",_dataArr[index]);
        
       // btnView.backgroundColor = [UIColor blueColor];
        [self.allMainBtnView addSubview:btnView];
    }
    
    [self.view addSubview:_allMainBtnView];
    
 


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
