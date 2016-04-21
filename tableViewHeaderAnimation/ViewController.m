//
//  ViewController.m
//  tableViewHeaderAnimation
//
//  Created by 换一换 on 16/4/20.
//  Copyright © 2016年 张洋. All rights reserved.
//

#import "ViewController.h"

#define kHeight      [[UIScreen mainScreen] bounds].size.height
#define kWidth       [[UIScreen mainScreen] bounds].size.width
#define kBarHeight              (64.f)
#define HeaderHeight 260
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *headerBackImg;
@property (nonatomic, strong) UIImageView *avatarImg;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initUI
{
    self.view.backgroundColor = RGB(240, 240, 240 , 1);
    
    [self.view addSubview:self.myTableView];
    
    
    //去掉navigation 背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //添加背景view
    CGRect backViewFrame = CGRectMake(0, -20, kWidth, kBarHeight);
    UIView *backView = [[UIView alloc] initWithFrame:backViewFrame];
    backView.backgroundColor = RGB(255, 217, 70, 0);
    
    [self.navigationController.navigationBar addSubview:backView];
    _backView = backView;
    
    self.navigationItem.title = @"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(50, 50, 50, 1)}];
    
    //设置tableview header
    
    CGRect headerFrame = CGRectMake(0, 0, kWidth, HeaderHeight);
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:headerFrame];
    headerView.backgroundColor = RGB(255, 255, 255, 1);
    headerView.layer.masksToBounds = YES;
   
    
    UIImageView *headerBackImg = [[UIImageView alloc] init];
    headerBackImg.bounds = headerFrame;
    headerBackImg.center = headerView.center;
    headerBackImg.image = [UIImage imageNamed:@"back"];
    

    self.headerView = headerView;
    self.headerBackImg = headerBackImg;
    //防止挡住tableview 内容
    [self.headerView addSubview:self.headerBackImg];
    
    self.headerView.layer.masksToBounds = YES;
    
    
    CGRect avatarFrame = CGRectMake(12, self.headerView.bounds.size.height-80-12, 80, 80);
    
    UIImageView *avatarImg = [[UIImageView alloc] initWithFrame:avatarFrame];
    avatarImg.layer.cornerRadius = 40;
    avatarImg.layer.masksToBounds = YES;
    avatarImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    avatarImg.layer.borderWidth = 2;
    avatarImg.image = [UIImage imageNamed:@"icon"];
    [self.headerView addSubview:avatarImg];
    self.avatarImg = avatarImg;
    
    
  
    UIView *contentView = [[UIView alloc] initWithFrame:headerFrame];
    [contentView addSubview:self.headerView];
    
    
    self.myTableView.tableHeaderView = contentView;
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentY = scrollView.contentOffset.y;
    CGFloat alpha = contentY / 200.0f;
    _backView.backgroundColor = RGB(255, 217, 70, alpha);
    
    if (contentY < -kBarHeight) {
        //增加的高度
        CGFloat addHeight = - (contentY + kBarHeight);
        //改变系数
        CGFloat scale = (HeaderHeight + addHeight) / HeaderHeight;
        //改变frame
        CGRect headerFrame = CGRectMake(0, -addHeight, kWidth, HeaderHeight + addHeight);
        self.headerView.frame = headerFrame;
        
        
        CGRect headerImgFrame = CGRectMake(-(kWidth * scale - kWidth)/2.0f, 0, kWidth * scale, HeaderHeight + addHeight);
        
        self.headerBackImg.frame = headerImgFrame;
        
        
        CGRect avatarFrame = CGRectMake(15, self.headerView.bounds.size.height - 80 - 15, 80 , 80);
        self.avatarImg.frame = avatarFrame;
        
        
    }
    
    
}
#pragma mark -- TableViewDataSoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    
    cell.textLabel.text = @"友谊的小船说翻就翻";
    
    return cell;
}

#pragma mark --
-(UITableView *)myTableView
{
    
    if (_myTableView == nil) {
        CGRect myTableViewFrame = CGRectMake(0, -kBarHeight, kWidth, kHeight + kBarHeight);
        _myTableView = [[UITableView alloc] initWithFrame:myTableViewFrame style:UITableViewStylePlain];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
