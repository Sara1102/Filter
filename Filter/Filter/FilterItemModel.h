//
//  FilterItemModel.h
//  Practice
//
//  Created by Sara on 15/3/17.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterItemModel : NSObject
@property (assign, nonatomic) int  fid;
@property (strong, nonatomic) NSString*  name;
@property (strong, nonatomic) NSMutableArray*  sonArray;

- (void)setFilterItemByDic:(NSDictionary*)dic ;

@end
