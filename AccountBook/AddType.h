//
//  AddType.h
//  AccountBook
//
//  Created by junhaoshen on 16/1/13.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddType : UIViewController

@property(nonatomic,strong)NSString * string;
@property(nonatomic,strong) void(^myBlock)(NSString *);

@end
