# Liszt-SegmentControlExample
很好用分段控制器,扩展性高,用法简单,疯转全面
<img src="https://github.com/LisztGitHub/Liszt-SegmentControlExample/blob/master/Liszt.gif">
#
####Exmaple
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

        
      
      
