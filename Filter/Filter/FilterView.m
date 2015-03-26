//
//  FilterView.m
//  Practice
//
//  Created by Sara on 15/3/9.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import "FilterView.h"
#import "FilterHeaderItem.h"
#import "FilterItemModel.h"

static const NSString *selectItem = @"item";
static const NSString *selectItemOne = @"one";
static const NSString *selectItemtwo = @"two";



@implementation FilterView

-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    }
    
    return _headView;
}

-(UIImageView *)maskImageView
{
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [_maskImageView setHidden:YES];
        [_maskImageView setBackgroundColor:[UIColor blackColor]];
        [_maskImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AllClose)];
        [_maskImageView addGestureRecognizer:tap];
        
        [_maskImageView setAlpha:0.5];
        
    }
    return _maskImageView;
}

-(UITableView *)oneClassTableView
{
    if (!_oneClassTableView) {
        
        _oneClassTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 0)];
        [_oneClassTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _oneClassTableView.delegate = self;
        _oneClassTableView.dataSource = self;
        
    }
    return _oneClassTableView;
}

-(UITableView *)towClassTableView1
{
    if (!_towClassTableView1) {
        
        _towClassTableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width/2, 0)];
        [_towClassTableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _towClassTableView1.delegate = self;
        _towClassTableView1.dataSource = self;
        
    }
    return _towClassTableView1;
}

-(UITableView *)towClassTableView2
{
    if (!_towClassTableView2) {
        
        _towClassTableView2 = [[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 40, [UIScreen mainScreen].bounds.size.width/2, 0)];
        
        [_towClassTableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _towClassTableView2.delegate = self;
        _towClassTableView2.dataSource = self;

        
    }
    return _towClassTableView2;
}


-(UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setFrame:CGRectMake(0, -15, [UIScreen mainScreen].bounds.size.width, 15)];
        [_bottomBtn setImage:[UIImage imageNamed:@"FilterItemBottom"] forState:UIControlStateNormal];
        
        [_bottomBtn addTarget:self action:@selector(toCloseFilter:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomBtn setBackgroundColor:[UIColor whiteColor]];
        
    }
    
    return _bottomBtn;
}

#pragma mark data

-(void)setSelectData:(NSInteger)one setTow:(NSInteger)two KeyNum:(NSInteger)keyNum
{
    
    NSString *select = [NSString stringWithFormat:@"item%ld",(unsigned long)keyNum];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:one],selectItemOne ,[NSNumber numberWithInteger:two],selectItemtwo ,nil];
    [self.selectType setObject:dic forKey:select];
}

#pragma mark viewStyle

/// 设置筛选头部样式{HeadIcon:xxxx,HeadTitle:xx,HeadType":xx}
-(void)setFilterHeaderStyle:(NSMutableArray *)headStyleArray
{
    
    
    [self addSubview:self.maskImageView];
    [self addSubview:self.oneClassTableView];
    [self addSubview:self.towClassTableView1];
    [self addSubview:self.towClassTableView2];
    
    [self addSubview:self.bottomBtn];
    [self addSubview:self.headView];
    self.selectType = [[NSMutableDictionary alloc]init];
 
    float itemWidth = [UIScreen mainScreen].bounds.size.width/ headStyleArray.count;
    float itemX = 0;
    for (NSDictionary *headStyle in headStyleArray) {
        
        FilterHeaderItem *item = [FilterHeaderItem buttonWithType:UIButtonTypeCustom];
        
        [item addTarget:self action:@selector(toFilterData:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger indexNum = [headStyleArray indexOfObject:headStyle];
        
        item.tag = 700 + indexNum;
        [item setFrame:CGRectMake(itemX, 0, itemWidth, 40)];
        [item initHeadItem:headStyle];
        
        itemX = itemX + itemWidth;
        
        [self.headView addSubview:item];
        
        if (indexNum != headStyleArray.count-1) {
            
            UIImageView *vLine = [[UIImageView alloc]initWithFrame:CGRectMake(itemX, 11, 0.5, 19)];
            [vLine setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:229.0/255.0]];
            [self.headView addSubview:vLine];
            
        }
        
        
    }
    
    
    UIImageView *bLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [bLine setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:229.0/255.0]];
    [self.headView addSubview:bLine];
    
    
}





-(void)showFilter:(FilterItemType)type with:(NSInteger)indexNum
{
    
    CGRect viewFrame = self.frame;
    viewFrame.size.height = [UIScreen mainScreen].bounds.size.height;
    
    self.frame = viewFrame;
    
    [self.bottomBtn setHidden:NO];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexNum];
    CGRect bottomframe = self.bottomBtn.frame;
    bottomframe.origin.y = [[dic objectForKey:FilterViewDataCount] intValue] * 40 + 40;
    
   
   
    if (type == FilterItemType_Distance) {
        
        CGRect frame = self.oneClassTableView.frame;
        frame.size.height =  [[dic objectForKey:FilterViewDataCount] intValue] * 40;
        
        [UIView animateWithDuration:0.3 animations:^
        {
            self.oneClassTableView.tag = indexNum;
            [self.oneClassTableView reloadData];
            [self.oneClassTableView setFrame:frame];
            
            [self selectFliterStyle:self.oneClassTableView];
            
        } completion:^(BOOL finished)
        {
             self.bottomBtn.frame = bottomframe;
        }];
        
        
    }else
    {
        CGRect frame1 = self.towClassTableView1.frame;
        frame1.size.height =  [[dic objectForKey:FilterViewDataCount] intValue] * 40;
        CGRect frame2 = self.towClassTableView2.frame;
        frame2.size.height =  [[dic objectForKey:FilterViewDataCount] intValue] * 40;
  
        [UIView animateWithDuration:0.3 animations:^
         {
             self.towClassTableView1.tag = indexNum;
             self.towClassTableView2.tag = indexNum;
             [self.towClassTableView1 reloadData];
             [self.towClassTableView2 reloadData];
             
             [self.towClassTableView1 setFrame:frame1];
             [self.towClassTableView2 setFrame:frame2];
             
             [self selectFliterStyle:self.towClassTableView1];
             [self selectFliterStyle:self.towClassTableView2];
             
         } completion:^(BOOL finished)
         {
             self.bottomBtn.frame = bottomframe;
         }];

    }
 
}



-(void)closeFilter:(FilterItemType)type with:(NSInteger)indexNum
{
    
    CGRect viewFrame = self.frame;
    viewFrame.size.height = 40;
    
    self.frame = viewFrame;

    [self.bottomBtn setHidden:YES];
    CGRect bottomframe = self.bottomBtn.frame;
    bottomframe.origin.y = -15;
    self.bottomBtn.frame = bottomframe;
    if (type == FilterItemType_Distance) {
        CGRect frame = self.oneClassTableView.frame;
        frame.size.height =  0;
        [UIView animateWithDuration:0.3 animations:^{
            [self.oneClassTableView setFrame:frame];
            

        }];
        
        
    }else
    {
        CGRect frame1 = self.towClassTableView1.frame;
        frame1.size.height = 0;
        CGRect frame2 = self.towClassTableView2.frame;
        frame2.size.height =  0;
        [UIView animateWithDuration:0.3 animations:^{
            [self.towClassTableView1 setFrame:frame1];
            [self.towClassTableView2 setFrame:frame2];
            
        }];
        
    }
}

-(void)selectFliterStyle:(UITableView *)tableView
{

    
     NSDictionary *sD = [self.selectType objectForKey:[NSString stringWithFormat:@"item%ld",(unsigned long)tableView.tag] ];
    if (tableView == self.oneClassTableView||tableView == self.towClassTableView1)
    {
 
        NSInteger selectIndex =  [[sD objectForKey:selectItemOne] integerValue];
        NSIndexPath *index = [NSIndexPath indexPathForRow:selectIndex inSection:0];
        
        [tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else
    {
        NSInteger selectIndex =  [[sD objectForKey:selectItemtwo] integerValue];
        NSIndexPath *index = [NSIndexPath indexPathForRow:selectIndex inSection:0];
        
        [tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}


//-(void)

#pragma mark todo
-(void)toFilterData:(FilterHeaderItem *)button
{
    
    button.selected = !button.selected;
    
    if (button.selected) {
        
        [self AllClose:button all:NO];
        
        self.maskImageView.hidden = NO;
      
        
        NSString *select = [NSString stringWithFormat:@"item%ld",(unsigned long)button.tag - 700];
        
        if (![self.selectType objectForKey:select]) {
            if (button.type == FilterItemType_Distance ) {

                [self setSelectData:0 setTow:0 KeyNum:button.tag - 700];
            }else
            {
                [self setSelectData:0 setTow:0 KeyNum:button.tag - 700];
            }
            
        }
        
        [self showFilter:button.type with:button.tag-700];
        
        
    }else
    {
        self.maskImageView.hidden = YES;
        
        [self closeFilter:button.type with:button.tag-700];
    }
}

-(void)toCloseFilter:(UIButton *)button
{
    [self AllClose:nil all:YES];
}

-(void)AllClose
{
    [self AllClose:nil all:YES];
}


-(void)AllClose:(FilterHeaderItem *)button all:(BOOL)all
{
    for (FilterHeaderItem *item in [self.headView subviews]) {
        
        if ([item isKindOfClass:[FilterHeaderItem class]]) {
            
            BOOL equel = (item!= button);
            
            if (all) {
                equel = YES;
            }
            
            if (item!= button && item.selected ==YES) {
                item.selected = NO;
                self.maskImageView.hidden = YES;
                [self closeFilter:item.type with:item.tag];
            }
            
            
        }
        
    }
}


#pragma mark TabelView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.oneClassTableView||tableView == self.towClassTableView1)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:tableView.tag];
        return [[dic objectForKey:FilterViewDataCount] intValue];
    }else
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:tableView.tag];
        NSArray *data = [dic objectForKey:FilterViewDataValue];
        NSDictionary *sD = [self.selectType objectForKey:[NSString stringWithFormat:@"item%ld",(unsigned long)tableView.tag] ];
        FilterItemModel *info = [data objectAtIndex:[[sD objectForKey:selectItemOne] integerValue]];
        return info.sonArray.count;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [self.dataArray objectAtIndex:tableView.tag];
    if (tableView == self.oneClassTableView||tableView == self.towClassTableView1) {
        
        static NSString *oneCellID = @"oneCellID";
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:oneCellID];
        if (!oneCell) {
            oneCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCellID];
            oneCell.textLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
            oneCell.textLabel.font = [UIFont systemFontOfSize:13];
            
            [oneCell.contentView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
            
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
            [line setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0]];
            [oneCell addSubview:line];
            
            UIView *selectBk = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
            [selectBk setBackgroundColor:[UIColor whiteColor]];
            
            oneCell.selectedBackgroundView  = selectBk;
            oneCell.textLabel.highlightedTextColor = [UIColor colorWithRed:245/255 green:67/255 blue:59/255 alpha:1.0];
            
            
        }
        NSArray *data = [dic objectForKey:FilterViewDataValue];

        FilterItemModel *info = [data objectAtIndex:[indexPath row]];
        [oneCell.textLabel setText:info.name];
   
        return oneCell;
        
        
    }else if (tableView == self.towClassTableView2)
    {
        static NSString *twoCellID = @"twoCellID";
        UITableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:twoCellID];
        if (!twoCell) {
            twoCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twoCellID];
            twoCell.textLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
            twoCell.textLabel.font = [UIFont systemFontOfSize:13];
            
            
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
            [line setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0]];
            [twoCell addSubview:line];
            twoCell.textLabel.highlightedTextColor = [UIColor colorWithRed:245.0/255.0 green:67.0/255.0 blue:59.0/255.0 alpha:1.0];
            
            UIView *selectBk = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
            [selectBk setBackgroundColor:[UIColor whiteColor]];
            twoCell.selectedBackgroundView  = selectBk;
        }
        NSArray *data = [dic objectForKey:FilterViewDataValue];
    
        NSDictionary *sD = [self.selectType objectForKey:[NSString stringWithFormat:@"item%ld",(unsigned long)tableView.tag] ];
        FilterItemModel *info = [data objectAtIndex:[[sD objectForKey:selectItemOne] integerValue]];
        
        FilterItemModel *infoS = [info.sonArray objectAtIndex:[indexPath row]];
        
        [twoCell.textLabel setText: infoS.name];
        
        return twoCell;
        

    }
    
    return nil;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FilterHeaderItem *item = (FilterHeaderItem *)[self.headView viewWithTag:700 + tableView.tag];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:tableView.tag];
    
    NSArray *data = [dic objectForKey:FilterViewDataValue];
  

    
    if (tableView == self.oneClassTableView) {
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(filterSelectNum:with:withOneSelectIndex:)]) {
            
            [self.delegate filterSelectNum:tableView.tag with:FilterItemType_Distance withOneSelectIndex:[indexPath row]];
        }

        [self setSelectData:[indexPath row] setTow:0 KeyNum:tableView.tag];
        
        FilterItemModel *info = [data objectAtIndex:[indexPath row]];
        [item setTitle:info.name forState:UIControlStateNormal];
        
        
        [self AllClose:nil all:YES];

    }else if (tableView == self.towClassTableView1)
    {
        
        [self setSelectData:[indexPath row] setTow:0 KeyNum:tableView.tag];
        
        self.towClassTableView2.tag = tableView.tag;
        
        [self.towClassTableView2 reloadData];
        
        [self selectFliterStyle:self.towClassTableView2];
        
        
        FilterItemModel *info = [data objectAtIndex:[indexPath row]];
        [item setTitle:info.name forState:UIControlStateNormal];

    }else if (tableView == self.towClassTableView2)
    {
        
        NSString *select = [NSString stringWithFormat:@"item%ld",(unsigned long)tableView.tag ];
        
        NSDictionary *selectDic = [self.selectType objectForKey:select];
        NSInteger oneTag = [[selectDic objectForKey:selectItemOne] integerValue];
        
        [self setSelectData:oneTag setTow:[indexPath row] KeyNum:tableView.tag];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(filterSelectNum:with:withOneSelectIndex:withTwoSelectIndex:)]) {
            
            [self.delegate filterSelectNum:tableView.tag  with:FilterItemType_AllType withOneSelectIndex:oneTag withTwoSelectIndex:[indexPath row]];
        }
        
        
        [self AllClose:nil all:YES];
        
        NSDictionary *sD = [self.selectType objectForKey:[NSString stringWithFormat:@"item%ld",(unsigned long)tableView.tag] ];
        FilterItemModel *info = [data objectAtIndex:[[sD objectForKey:selectItemOne] integerValue]];
        
        FilterItemModel *infoS = [info.sonArray objectAtIndex:[indexPath row]];
        
        
        [item setTitle:infoS.name forState:UIControlStateNormal];

    }
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
