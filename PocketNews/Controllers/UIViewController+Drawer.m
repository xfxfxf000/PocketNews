//
//  UIViewController+Drawer.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "UIViewController+Drawer.h"

@implementation UIViewController (Drawer)

-(DrawerViewController *)xukunDrawerViewController{
    
    if([self.parentViewController isKindOfClass:[DrawerViewController class]]){
        
        return (DrawerViewController*)self.parentViewController;
        
    }else if([self.parentViewController isKindOfClass:[UINavigationController class]] &&
             [self.parentViewController.parentViewController isKindOfClass:[DrawerViewController class]]){
        
        return (DrawerViewController*)[self.parentViewController parentViewController];
        
    }else{
        
        return nil;
    }
}
@end
