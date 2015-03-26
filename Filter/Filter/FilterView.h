//
//  FilterView.h
//  Practice
//
//  Created by Sara on 15/3/9.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FilterViewDataValue @"DataValue"
#define FilterViewDataCount @"DataCount"



#import "FilterHeaderItem.h"

@protocol DidSelectFilter <NSObject>

@optional
-(void)filterSelectNum:(NSInteger)num with:(FilterItemType)type withOneSelectIndex:(NSInteger)index ;

-(void)filterSelectNum:(NSInteger)num with:(FilterItemType)type withOneSelectIndex:(NSInteger)indexOne withTwoSelectIndex:(NSInteger)indexTwo;



@end

@interface FilterView : UIView<UITableViewDataSource,UITableViewDelegate,DidSelectFilter>




@property (nonatomic, assign) id<DidSelectFilter>delegate;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *maskImageView;
///只有一级菜单
@property (nonatomic, strong) UITableView *oneClassTableView;
///含有二级菜单的一级菜单
@property (nonatomic, strong) UITableView *towClassTableView1;
///含有二级菜单的二级菜单
@property (nonatomic, strong) UITableView *towClassTableView2;
///底部收起按钮
@property (nonatomic, strong) UIButton *bottomBtn;

/*
 筛选列表
 HeadIcon:
 HeadTitle:包含每个tag 一级菜单长度，主要方便读取
 HeadType:
 */

-(void)setFilterHeaderStyle:(NSMutableArray *)headStyleArray;

/*
 当前选中
 item:头部按钮
 one：一级菜单选中indexNum；
 two：二级菜单选中indexNum；
*/
@property (nonatomic, strong) NSMutableDictionary *selectType;

/*
 筛选列表
 DataValue:包含每个tag 各级菜单数组
 DataCount:包含每个tag 一级菜单长度，主要方便读取
 */


@property (nonatomic, strong) NSMutableArray *dataArray;




@end



