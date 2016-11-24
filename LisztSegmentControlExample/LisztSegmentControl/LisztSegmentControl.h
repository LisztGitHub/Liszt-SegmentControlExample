//
//  LisztSegmentControl.h
//  LisztSegmentControlExample
//
//  Created by Liszt on 16/11/24.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LisztSegmentDidSelectBlcok)(NSInteger index);

@interface LisztSegmentControl : UIView

/**
 *  重写初始化并传入初始参数
 *  @param controllers 控制器数组
 *  @param titles 标题数组
 */
- (instancetype)initWithFrame:(CGRect)frame withControllers:(NSArray <UIViewController *>*)controllers withTitles:(NSArray <NSString*>*)titles didSelect:(LisztSegmentDidSelectBlcok)selectBlock;

@end
