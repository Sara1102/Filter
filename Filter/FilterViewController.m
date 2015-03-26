//
//  FilterViewController.m
//  Filter
//
//  Created by Sara on 15/3/18.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import "FilterViewController.h"
#import "Filter/FilterView.h"
#import "FilterItemModel.h"


@interface FilterViewController ()<DidSelectFilter>
@property (weak, nonatomic) IBOutlet FilterView *filterView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterView.delegate = self;
    self.dataArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *headArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i< 2; i++) {
        if (i == 0) {
            NSDictionary *head = @{@"HeadTitle":@"全部分类",@"HeadType":@1};
            [headArray addObject:head];
        }else
        {
            NSDictionary *head = @{@"HeadTitle":@"按距离排序",@"HeadType":@0};
            [headArray addObject:head];
        }
    }
    [self.filterView setFilterHeaderStyle:headArray];
    
    [self setFilterViewData];
    
    
  
}
///筛选器数据
-(void)setFilterViewData
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    ///二级菜单
    NSMutableArray *sonArray = [[NSMutableArray alloc]init];
    
    for (int tow = 0; tow<9; tow++) {
        NSString *title = [NSString stringWithFormat:@"二级菜单%d",tow];
        
        FilterItemModel *item = [[FilterItemModel alloc]init];
        item.name = title;
        item.fid = tow;
        
        [sonArray addObject:item];
    }
    
     ///一级菜单
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]init];
      ///一级菜单(含有二级菜单)
    NSMutableArray *secondArray = [[NSMutableArray alloc]init];
    
    for (int one = 0; one<5; one++) {
        
        NSString *title = [NSString stringWithFormat:@"一级菜单%d",one];
        FilterItemModel *item = [[FilterItemModel alloc]init];
        item.name = title;
        item.fid = one;
        [firstArray addObject:item];
        item.sonArray = sonArray;
        [secondArray addObject:item];
    }
    

    
    ///只有一级菜单
    
     NSDictionary *daDic = [NSDictionary dictionaryWithObjectsAndKeys:firstArray,@"DataValue" ,[NSNumber numberWithInteger:firstArray.count],@"DataCount",nil ];
    
    ///含有二级菜单
   
    NSDictionary *daDic2 = [NSDictionary dictionaryWithObjectsAndKeys:secondArray,@"DataValue" ,[NSNumber numberWithInteger:secondArray.count],@"DataCount",nil ];
    [data addObject:daDic];
    [data addObject:daDic2];
    self.filterView.dataArray = data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)filterSelectNum:(NSInteger)num with:(FilterItemType)type withOneSelectIndex:(NSInteger)index
{
    ///获取数据
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }

    for (int i = 0;  i<10; i++) {
        NSString *string = [NSString stringWithFormat:@"第%lu个按钮，只有一级菜单，第%lu个",num,index];
        
        [self.dataArray addObject:string];
    }
    
    [self.tableView reloadData];
}

-(void)filterSelectNum:(NSInteger)num with:(FilterItemType)type withOneSelectIndex:(NSInteger)indexOne withTwoSelectIndex:(NSInteger)indexTwo
{
    
     ///获取数据
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }
    
    for (int i = 0;  i<10; i++) {
        NSString *string = [NSString stringWithFormat:@"第%lu个按，第一级菜单第%lu个，第一级菜单第%lu个",num,indexOne,indexTwo];
        
        [self.dataArray addObject:string];
    }
    
    [self.tableView reloadData];

}


#pragma mark Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELLID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.dataArray objectAtIndex:[indexPath row]];
    
    return cell;
}











@end
