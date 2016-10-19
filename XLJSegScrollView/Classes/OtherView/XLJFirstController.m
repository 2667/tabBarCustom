//
//  XLJFirstController.m
//  XLJSegScrollView
//
//  Created by m on 2016/10/18.
//  Copyright © 2016年 XLJ. All rights reserved.
//

#import "XLJFirstController.h"
#import "XLJTestGepController.h"

@interface XLJFirstController ()

@end

@implementation XLJFirstController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XLJTestGepController *test = [XLJTestGepController new];
    
    [self.navigationController pushViewController:test animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"First";
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
