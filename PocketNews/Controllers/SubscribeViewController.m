//
//  SubscribeViewController.m
//  BreakingNews
//
//  Created by qianfeng on 14-9-11.
//  Copyright (c) 2014年 djxin. All rights reserved.
//

#import "SubscribeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "SubscribeModal.h"
#import "SubscribeCell.h"
#import "ColumnModel.h"
#import "ValueTransfer.h"

@interface SubscribeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
}
@end

@implementation SubscribeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTitleViewWithName:@"订阅管理"];
    [self addItemWithTitle:nil imageName:@"userAcc_backArrow" action:@selector(leftItemClick) location:YES];
    
    _dataArray = [[NSMutableArray alloc]init ];
	
    [self uiconfig];
    
    [self useAFNetworking];
}
- (void)uiconfig{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"SubscribeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    
}
- (void)useAFNetworking
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html", nil];
    [manager GET:kSubcribeString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSLog(@"response:%@",responseObject );
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary * mdict = (NSDictionary *)responseObject;
                NSArray * array  =[ mdict objectForKey:@"Rows"];
                for (NSDictionary * dict  in array) {
                    SubscribeModal * modal = [[SubscribeModal alloc]init ];
                    [modal setValuesForKeysWithDictionary:dict];
                    for (SubscribeModal * o in _exitArray) {
                        NSUInteger index = [_exitArray indexOfObject:modal.title];
                        if (index != NSNotFound) {
                            modal.isSubscribe = NO;
                        }
                    }
                    [_dataArray addObject:modal];
                }
            }
            [_tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"Cell";
    SubscribeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    SubscribeModal * modal = [_dataArray objectAtIndex:indexPath.row];
    [cell.leftImageView setImageWithURL:[NSURL URLWithString:modal.thumbImgUrl]];
    cell.titleLabel.text = modal.title;
    if (modal.isSubscribe == YES) {
        [cell.rightImageView setImage:[UIImage imageNamed:@"selected"]];
    }
    else{
        [cell.rightImageView setImage:[UIImage imageNamed:@"noselected"]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeCell * cell = (SubscribeCell *)[tableView cellForRowAtIndexPath:indexPath];
    SubscribeModal * modal = [_dataArray objectAtIndex:indexPath.row];
    if (modal.isSubscribe) {
        [cell.rightImageView setImage:[UIImage imageNamed:@"noselected"]];
        modal.isSubscribe = NO;
    }
    else{
        [cell.rightImageView setImage:[UIImage imageNamed:@"selected"]];
        modal.isSubscribe = YES;
    }
}

- (void)leftItemClick
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (SubscribeModal * modal in _dataArray) {
        if (modal.isSubscribe == YES) {
            [array addObject:modal];
        }
    }
    [ValueTransfer shareValue].valueArray = array;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
