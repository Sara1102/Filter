//
//  FilterHeaderItem.h
//  Practice
//
//  Created by Sara on 15/3/9.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum FilterItemType_
{
    FilterItemType_Distance,///根据距离筛选
    FilterItemType_AllType,///全部分类
    
}FilterItemType;

#define FilterViewHeadIcon @"HeadIcon"
#define FilterViewHeadTitle @"HeadTitle"
#define FilterViewHeadType @"HeadType"

@interface FilterHeaderItem : UIButton
///下拉框的样式
@property (nonatomic, assign) FilterItemType type;
@property (nonatomic, strong) UIImageView *tipImageView;

-(void)initHeadItem:(NSDictionary *)headStyle;




@end
