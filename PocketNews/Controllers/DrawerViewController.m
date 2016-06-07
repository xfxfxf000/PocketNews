//
//  DrawerViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "DrawerViewController.h"

@interface DrawerViewController ()

@property(nonatomic,assign)BOOL IsLeft;
@property(nonatomic,assign)BOOL IsRight;
@property(nonatomic,assign)BOOL LeftDrawerIsShow;
@property(nonatomic,assign)BOOL RightDrawerIsShow;
@property(nonatomic,retain)UITapGestureRecognizer *tapLeft;
@property(nonatomic,retain)UITapGestureRecognizer *tapRight;
@property(nonatomic,retain)UISwipeGestureRecognizer *swipeLeft;
@end

@implementation DrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"11.jpg"]];
    }
    return self;
}
- (id)initWithLeftViewController:(UIViewController *)leftViewController centerViewController:(UIViewController *)centerViewController rightViewController:(UIViewController *)rightViewController
{
    self = [super init];
    if (self) {
        //加载左视图
        [self setLeftDrawerVC:leftViewController];
        [self.view addSubview:leftViewController.view];
        //加载右视图
        [self setRightDrawerVC:rightViewController];
        [self.view addSubview:rightViewController.view];
        //加载中间视图....中间视图一定要最后添加
        [self setCenterDrawerVC:centerViewController];
        //[self.view addSubview:_CenterDrawerVC.view];
        //设置左右抽屉的任意一个布尔值
        self.IsLeft = YES;
        self.IsRight = YES;
        //给定状态初始值
        self.LeftDrawerIsShow = NO;
        self.RightDrawerIsShow = NO;
        //将左控制器添加为子控制器,这样左边控制器才可以找到self
        [self addChildViewController:leftViewController];
        //将右控制器添加为子控制器,这样右边控制器才可以找到self
        [self addChildViewController:rightViewController];
    }
    return self;
}
//重写设置中间视图的set方法
- (void)setCenterDrawerVC:(UIViewController *)CenterDrawerVC
{
    if (_CenterDrawerVC == nil) {
        _CenterDrawerVC = CenterDrawerVC;
        [self.view addSubview:_CenterDrawerVC.view];
        [self addChildViewController:_CenterDrawerVC];
//        NSLog(@"不存在");
    }else{
        UIViewController *oldVC = _CenterDrawerVC;
        _CenterDrawerVC = CenterDrawerVC;
        [self.view addSubview:_CenterDrawerVC.view];
        [oldVC removeFromParentViewController];
        [oldVC.view removeFromSuperview];
        [self addChildViewController:_CenterDrawerVC];
    }
}
- (void)addSwipeGeustureToLeft
{
    if (_LeftDrawerIsShow) {
        self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftDrawerButton)];
        [_swipeLeft setDirection:UISwipeGestureRecognizerDirectionDown];
        [_CenterDrawerVC.view addGestureRecognizer:self.swipeLeft];
        
    }else{
        if (self.swipeLeft != nil) {
            [_CenterDrawerVC.view removeGestureRecognizer:_swipeLeft];
        }
    }
}
#pragma 点击手势方法
//当左抽屉处于打开状态的时候,在中间视图上添加单击手势,点击收回左抽屉
- (void)AddTapGestureToLeft
{
    if (_LeftDrawerIsShow) {
        self.tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftDrawerButton)];
        [_CenterDrawerVC.view addGestureRecognizer:self.tapLeft];
    }else{
        if (self.tapLeft != nil) {
            [_CenterDrawerVC.view removeGestureRecognizer:_tapLeft];
        }
    }
}
//当右抽屉处于打开状态的时候,在中间视图上添加单击手势,点击收回右抽屉
- (void)AddTapGestureToRight
{
    if (_RightDrawerIsShow) {
        self.tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightDrawerButton)];
        [_CenterDrawerVC.view addGestureRecognizer:self.tapRight];
    }else{
        if (self.tapRight != nil) {
            [_CenterDrawerVC.view removeGestureRecognizer:_tapRight];
        }
    }
}
#pragma mark - 动画
- (void)changeFrameForLeftView{
    CATransition * animation = [[CATransition alloc ]init];
    animation.duration = .2f;
    [_CenterDrawerVC.view.layer addAnimation:animation forKey:@"animation"];
    //设置静态变量，第一次调用的时候赋值，再次调用的时候不会赋值，但是可以用它做运算
    CGFloat x = _CenterDrawerVC.view.frame.origin.x;
    CGFloat y = _CenterDrawerVC.view.frame.origin.y;
    CGFloat width = _CenterDrawerVC.view.frame.size.width;
    CGFloat height = _CenterDrawerVC.view.frame.size.height;
    if (x < 150) {
        for (int i = x ; i <= 150 ; i +=50 ) {
            _CenterDrawerVC.view.frame = CGRectMake(i, y, width, height);
        }
        return;
    }
    if (x == 150 ) {
        for (int i = x ; i >= 0 ; i -=50 ) {
            _CenterDrawerVC.view.frame = CGRectMake(i, y, width, height);
        }
    }
}
- (void)changeFrameForRightView{
    CATransition * animation = [[CATransition alloc ]init];
    animation.duration = .1f;
    [_CenterDrawerVC.view.layer addAnimation:animation forKey:@"animation"];
    //设置静态变量，第一次调用的时候赋值，再次调用的时候不会赋值，但是可以用它做运算
    CGFloat x = _CenterDrawerVC.view.frame.origin.x;
    CGFloat y = _CenterDrawerVC.view.frame.origin.y;
    CGFloat width = _CenterDrawerVC.view.frame.size.width;
    CGFloat height = _CenterDrawerVC.view.frame.size.height;
    if (x > -260) {
        for (int i = x ; i >= -260 ; i -=20 ) {
            _CenterDrawerVC.view.frame = CGRectMake(i, y, width, height);
        }
        return;
    }
    if (x == -260 ) {
        for (int i = x ; i <= 0 ; i +=20 ) {
            _CenterDrawerVC.view.frame = CGRectMake(i, y, width, height);
        }
    }
}
//有待修改
- (void)newFrame{
    //设置静态变量，第一次调用的时候赋值，再次调用的时候不会赋值，但是可以用它做运算
    static int x = 1;
    if (_CenterDrawerVC.view.frame.origin.x  >= 150) {
        x = -x ;
        //缩放，左边的值为增加或减少width，右值为增加或减少length(1为原始尺寸)
        _CenterDrawerVC.view.transform =CGAffineTransformMakeScale(-1 , 1);
    }
    if (_CenterDrawerVC.view.frame.origin.x <=0 ) {
        x = -x;
        _CenterDrawerVC.view.transform = CGAffineTransformMakeScale(1 , 1);
    }
    CGRect frame = _CenterDrawerVC.view.frame;
    _CenterDrawerVC.view.frame = frame;
}
#pragma 左右button的点击事件
//左边点击事件
-(void)tapLeftDrawerButton
{
    NSLog(@"调用");
    
    _RightDrawerVC.view.hidden = YES;
    _LeftDrawerVC.view.hidden = NO;
    if (!self.IsLeft) {

//        _CenterDrawerVC.view.frame = CGRectMake(0, 0, 320, 480);
        [self changeFrameForLeftView];
        _IsLeft = YES;
        _LeftDrawerIsShow = NO;
        [self AddTapGestureToLeft];
        [self addSwipeGeustureToLeft];
    }else{
//        _CenterDrawerVC.view.frame = CGRectMake(150, 0, 320, 480);
        [self changeFrameForLeftView];
        _IsLeft = NO;
        _LeftDrawerIsShow = YES;
        [self AddTapGestureToLeft];
        [self addSwipeGeustureToLeft];
    }
}
//右边点击事件
- (void)tapRightDrawerButton
{
    _LeftDrawerVC.view.hidden = YES;
    _RightDrawerVC.view.hidden = NO;
    if (!self.IsRight) {
//        _CenterDrawerVC.view.frame = CGRectMake(0, 0, 320, 568);
        [self changeFrameForRightView];
        _IsRight = YES;
        _RightDrawerIsShow = NO;
        [self AddTapGestureToRight];
    }else{
//        _CenterDrawerVC.view.frame = CGRectMake(-250, 60, 320, 400);
        [self changeFrameForRightView];
        _RightDrawerIsShow = YES;
        _IsRight = NO;
        [self AddTapGestureToRight];
    }
}
#pragma 关闭左右抽屉的快捷方法
//关闭左抽屉,方便调用
- (void)closeLeftDrawer
{
    _CenterDrawerVC.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    _IsLeft = YES;
    _LeftDrawerIsShow = NO;
    [self AddTapGestureToLeft];
}
//关闭右抽屉,方便调用
- (void)closeRightDrawer
{
    _CenterDrawerVC.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    _IsRight = YES;
    _RightDrawerIsShow = NO;
    [self AddTapGestureToRight];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end