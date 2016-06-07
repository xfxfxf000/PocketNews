//
//  FavouriteViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "FavouriteViewController.h"
#import "ArticalViewController.h"
#import "TopModel.h"
#import "CommonCell.h"
#import "UIImageView+WebCache.h"

#import "DBManager.h"

@interface FavouriteViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray * _dataArray;
    NSMutableArray * _deleteArray;
    UIAlertView * alert;
    BOOL isDelete;
    BOOL isMore;
}
@end

@implementation FavouriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define kTitleViewHeight 30
- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataArray = [[NSMutableArray alloc]init ];
    _deleteArray = [[NSMutableArray alloc]init ];
    isDelete = NO;
    isMore = NO;
	
    [self addTitleViewWithName:@"我的收藏"];
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
    
    UIBarButtonItem * item1 = [self addItemWithTitle:nil imageName:@"del_btn" target:self action:@selector(moreItemClick)];
    UIBarButtonItem * item2 = [self addItemWithTitle:nil imageName:nil target:self action:@selector(deleteItemClick)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
//    CGFloat width = [DeviceManager currentScreenWidth];
//    CGFloat height = [DeviceManager currentScreenHeight];
    
    _tableView.frame = CGRectMake(0, 0, WIDTH,HEIGHT);
}
- (void)leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)deleteItemClick
{
    if(isMore == YES){
        isMore = NO;
        [_dataArray removeObjectsInArray:_deleteArray];
        for (TopModel * model in _deleteArray) {
            [[DBManager shareManager]deleteDataWithArticleId:model.articleId];
        }
        [_tableView reloadData];
    }
    else{
        isMore = YES;
    }
}
- (void)moreItemClick
{
    alert = [[UIAlertView alloc]initWithTitle:@"收藏管理" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"批量删除",@"全部删除", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _tableView.editing = YES;
        isMore = YES;
    }
    else if (buttonIndex == 2) {
        _tableView.editing = YES;
        [[DBManager shareManager]deleteAllData];
        [_dataArray removeAllObjects];
        [_tableView reloadData];
    }
    else {
        NSLog(@"取消");
    }
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [_dataArray removeObjectsInArray:_deleteArray];
        for (TopModel * model in _deleteArray) {
            [[DBManager shareManager]deleteDataWithArticleId:model.articleId];
        }
        [_tableView reloadData];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArray = [NSMutableArray arrayWithArray:[[DBManager shareManager]fetchAllData]];
    [_tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TopModel * modal = [_dataArray objectAtIndex:indexPath.row];
        [[DBManager shareManager]deleteDataWithArticleId:modal.articleId];
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        tableView.editing = NO;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"Cell";
    CommonCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommonCell" owner:self options:nil]lastObject];
    }
    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
    if (model.firstPicUrl.length == 0) {
        cell.titleLabel.frame = CGRectMake(10, 0, 300, 50);
        cell.infoLabel.frame = CGRectMake(10, 60, 300, 20);
        cell.textIamgeView.hidden = YES;
    }
    else{
        cell.titleLabel.frame = CGRectMake(100, 0, 210, 50);
        cell.infoLabel.frame = CGRectMake(100, 60, 210, 20);
        cell.textIamgeView.hidden = NO;
        [cell.textIamgeView setImageWithURL:[NSURL URLWithString:model.firstPicUrl] placeholderImage:[UIImage imageNamed:@"bglogo.png"]];
        if (model.isHot.integerValue == 1) {
            cell.hotImageView.image = [UIImage imageNamed:@"isHot"];
        }
    }
    cell.titleLabel.text = model.title;
    cell.infoLabel.text = model.sourceName;
    cell.commentLabel.text = [NSString stringWithFormat:@"%d评论",model.reviewNum.intValue];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView.editing ) {
        NSLog(@"editing!");
        TopModel * modal = [_dataArray objectAtIndex:indexPath.row];
        modal.isMark = YES;
        [_deleteArray addObject:modal];
    }
    else{
        TopModel * model = [_dataArray objectAtIndex:indexPath.row];
        ArticalViewController * avc = [[ArticalViewController alloc]init ];
        avc.modal = model;
        [self.navigationController pushViewController:avc animated:YES];

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
