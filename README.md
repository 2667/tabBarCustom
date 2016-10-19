##★★★★自定义tabBar★★★★★★★

###前言：
有的时候需求要对tabBar进行自定义的时候，感觉还是有很多不明白的地方，特此写一个demo来记录，大家可以借鉴这个思路仿写一个属于自己的tabBar。我写的并不好，有错误的地方，请大家指出来，我好马上修改，谢谢。

思路是自定义`tabBarController`中设置2个一个是`ViewController`子视图和`tabBar` 在`ViewController`中设置4个子视图

####一、设置所有子视图

```
//添加所有子视图
- (void)setAllChildViewController
{
    
    
    //第一页
    XLJFirstController *first = [[XLJFirstController alloc] init];
    
    [self setOneChildViewController:first withNormalImage:[UIImage imageNamed:@"tabbar_home"] withSelectedImage:[UIImage imageNamed:@"tabbar_home_selected"] withTitle:@"first"];
    
    //第二页
    XLJSecondController *second = [[XLJSecondController alloc] init];
    
    [self setOneChildViewController:second withNormalImage:[UIImage imageNamed:@"tabbar_message_center"] withSelectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] withTitle:@"second"];

    //第四页
    XLJFourController *four = [[XLJFourController alloc] init];
    
    [self setOneChildViewController:four withNormalImage:[UIImage imageNamed:@"tabbar_discover"] withSelectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] withTitle:@"four"];

    //第五页
    XLJFiveController *five = [[XLJFiveController alloc] init];
    
    [self setOneChildViewController:five withNormalImage:[UIImage imageNamed:@"tabbar_profile"] withSelectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] withTitle:@"five"];

}

####二、设置自定义tabBar

```
```
//自定义tabBar,自定义的方法类似
- (void)setUpTabBar
{
    XLJTabBar *tabBar = [[XLJTabBar alloc] initWithFrame:self.tabBar.bounds];
    
    tabBar.backgroundColor = [UIColor lightGrayColor];
    tabBar.delegate = self;
    tabBar.items = self.items;
    
    [self.tabBar addSubview:tabBar];
}

```
#### 1. 在自定义tabBar的时候，创建XLJTabBar类，让它继承自UIView,这个类要做哪些事情呢？主要做布局的事情，有普通的按钮和一个图片的按钮，他们的事件通过代理的方式来实现。
位置的计算方法(其它方法根据自己的来写):

```
//调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];   
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    
    int i = 0;
    //设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttonmArray) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    //设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
}

```

####三、移除系统的`tabBarButton`的方法

```
/移除系统自带的tarBar
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
```

####四、处理`Navigation`手势滑动的问题

```

#import "XLJNavigationController.h"
#import "UIBarButtonItem+XLJButtonItem.h"

@interface XLJNavigationController ()<UINavigationControllerDelegate>
//用于返回手势标记
@property (nonatomic, strong) id popDelegate;

@end

@implementation XLJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}


//导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        //实现滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

```

####五、未解决问题`appearanceWhenContainedIn`在iOS9以后这个就会出现警告的问题,希望知道的朋友帮忙解决.iOS9以后说是用这个但是不会，一用就崩溃了。

```
 UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIBarButtonItem class]]];
```
![](https://github.com/marlonxlj/tabBarCustom/blob/master/tabBar.gif)
