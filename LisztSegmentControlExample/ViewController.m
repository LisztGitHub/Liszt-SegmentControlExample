//
//  ViewController.m
//  LisztSegmentControlExample
//
//  Created by Liszt on 16/11/24.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "ViewController.h"
#import "LisztSegmentControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor magentaColor];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor magentaColor];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor magentaColor];
    
    LisztSegmentControl *segmentControl = [[LisztSegmentControl alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) withControllers:@[vc1,vc2] withTitles:@[@"地区群",@"主题群"] didSelect:^(NSInteger index) {
        NSLog(@"index:%li",index);
    }];
    [self.view addSubview:segmentControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
