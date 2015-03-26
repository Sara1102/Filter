//
//  FilterHeaderItem.m
//  Practice
//
//  Created by Sara on 15/3/9.
//  Copyright (c) 2015年 Sara. All rights reserved.
//

#import "FilterHeaderItem.h"


@implementation FilterHeaderItem

-(void)initHeadItem:(NSDictionary *)headStyle
{

    if ([headStyle objectForKey:FilterViewHeadIcon]) {
        
        [self setImage:[UIImage imageNamed:[headStyle objectForKey:FilterViewHeadIcon]] forState:UIControlStateNormal];
    }
    NSString *titleString = [headStyle objectForKey:FilterViewHeadTitle];
    
    [self setTitle:titleString forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:245.0/255.0 green:67.0/255.0 blue:59.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    
    int typeNum = [[headStyle objectForKey:FilterViewHeadType] intValue];
    
    self.type = typeNum;
    [self addSubview:self.tipImageView];

}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
    
    CGRect tipFrame = self.tipImageView.frame;
    tipFrame.origin.x = (self.frame.size.width / 2 + titleSize.width / 2) + 6;
    
    self.tipImageView.frame = tipFrame;
}

-(UIImageView *)tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 18, 7, 4)];
        
        [_tipImageView setImage:[UIImage imageNamed:@"FilterItemDown"]];
        
    }
    return _tipImageView;
}


-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
         [self.tipImageView setImage:[UIImage imageNamed:@"FilterItemUp"]];
    }else
    {
        [self.tipImageView setImage:[UIImage imageNamed:@"FilterItemDown"]];
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
