//
//  CommentViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "CommentModal.h"
#import "HttpRequest.h"
#import "UIImageView+WebCache.h"
#import "EditViewController.h"

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
}
@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self uiconfig];
    _dataArray = [[NSMutableArray alloc]init ];
    [HttpRequest requestWithUrlString:[NSString stringWithFormat:kCommentString,_contentUrl] target:self action:@selector(requestFinisted:)];
}
- (void)uiconfig{
    [self addTitleViewWithName:@"评论"];
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
//    [self addItemWithTitle:nil imageName:nil action:@selector(rightItemClick) location:NO];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT- 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:_tableView];
}
- (void)requestFinisted:(HttpRequest *)request
{
    if (request.downloadData) {
        id result = [NSJSONSerialization JSONObjectWithData:request.downloadData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * mdict = (NSDictionary *)result;
        NSArray * array = [mdict objectForKey:@"list"];
        for (NSDictionary * dict in array) {
            NSLog(@"dict:%@",dict);
            CommentModal * modal = [[CommentModal alloc]init ];
            [modal setValuesForKeysWithDictionary:dict];
            NSLog(@"modal:%@",modal.userNickName);
            [_dataArray addObject:modal];
        }
        NSLog(@"result:%@",_dataArray);
        [_tableView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"Cell";
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    CommentModal * madal = [_dataArray objectAtIndex:indexPath.row];
    if ([madal.userIconUrl isKindOfClass:[NSString class]]) {
        [cell.iconUrl setImageWithURL:[NSURL URLWithString:madal.userIconUrl]];
        cell.iconUrl.layer.cornerRadius = 15;
        cell.iconUrl.clipsToBounds = YES;
    }
    cell.titleLabel.text = madal.userNickName;
    cell.commnetLabel.text = madal.reviewContent;
    cell.timeLabel.text = madal.createTime;
    cell.praiseLabel.text = [NSString stringWithFormat:@"%d",[madal.supportNum integerValue]];
    cell.badLabel.text = [NSString stringWithFormat:@"%d",[madal.againstNum integerValue]];
    
    cell.target1 = self;
    cell.action1 = @selector(supportClick:);
    cell.target2 = self;
    cell.action2 = @selector(againstClick:);
    cell.target3 = self;
    cell.action3 = @selector(editClick:);
    cell.index = indexPath.row;
    
    return cell;

}
- (void)supportClick:(CommentCell *)cell
{
    CommentModal * modal = [_dataArray objectAtIndex:cell.index];
    cell.praiseLabel.text = [NSString stringWithFormat:@"%d",[modal.supportNum integerValue ]+ 1];
    cell.praiseLabel.textColor = [UIColor colorWithRed:195.0/255 green:36.0/255 blue:39.0/255 alpha:1];
    [cell.praiseBtn setBackgroundImage:[UIImage imageNamed:@"dArticlecomment_praise"] forState:UIControlStateNormal];
    cell.badBtn.userInteractionEnabled = NO;
}
- (void)againstClick:(CommentCell *)cell
{
    CommentModal * modal = [_dataArray objectAtIndex:cell.index];
    cell.badLabel.text = [NSString stringWithFormat:@"%d",[modal.againstNum integerValue ]+ 1];
    cell.badLabel.textColor = [UIColor colorWithRed:195.0/255 green:36.0/255 blue:39.0/255 alpha:1];
    [cell.badBtn setBackgroundImage:[UIImage imageNamed:@"dArticlecomment_bad"] forState:UIControlStateNormal];
    cell.praiseBtn.userInteractionEnabled = NO;
}
- (void)editClick:(CommentCell *)cell
{
    CommentModal * modal = [_dataArray objectAtIndex:cell.index];
    EditViewController * evc = [[EditViewController alloc]init ];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:evc];
    evc.textString = [NSString stringWithFormat:@"//@%@:%@",modal.userNickName,modal.reviewContent];
    [self.navigationController presentViewController:nvc animated:YES completion:^{
        
    }];
}
- (void)leftItemClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
