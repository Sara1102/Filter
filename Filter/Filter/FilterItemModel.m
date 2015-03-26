//
//  FilterItemModel.m
//  Practice
//
//  Created by Sara on 15/3/17.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import "FilterItemModel.h"

@implementation FilterItemModel

-(void)setFilterItemByDic:(NSDictionary *)dic
{
    self.fid = [[dic objectForKey:@"fid"] intValue];
    self.name = [dic objectForKey:@"name"];
    NSMutableArray *array =  [[NSMutableArray alloc]init];
    
    if ([[dic objectForKey:@"sonArray"] isKindOfClass:[NSArray class]] ) {
        for (NSDictionary *son in [dic objectForKey:@"sonArray"]) {
            FilterItemModel *filterItem = [[FilterItemModel alloc]init];
            [filterItem setFilterItemByDic:son];
            [array addObject:son];
        }
    }
    self.sonArray = array;
}

@end
