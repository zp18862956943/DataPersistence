//
//  ViewController.m
//  数据持久化
//
//  Created by 周鹏 on 2016/11/24.
//  Copyright © 2016年 周鹏. All rights reserved.
//

#import "ViewController.h"
#import "DbPath.h"
#import "Teachers.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    //因为DbPath是单例，地址始终没释放掉，所以如果其他地方可以不用再写这句话，除非要换数据库的情况下，必须重新写
    [DbPath shareInstance].dbPath = [[DbPath shareInstance]dbPathWithDirectoryName:nil dbName:@"MyAccount1"];
   
    [Teachers createTableWithTableName:@"user0"];

    NSMutableArray *Tarr = [NSMutableArray array];
    for (int i = 0;i < 100 ;i++) {
        Teachers *teacher = [[Teachers alloc]init];
        teacher.name = [NSString stringWithFormat:@"Tome%d",i];
        teacher.age = i + 30;
        teacher.sex = i % 2 == 0?YES:NO;
        teacher.account = [NSString stringWithFormat:@"%d",1491501020 + i];
        [Tarr addObject:teacher];
    }

    [Teachers saveObjects:Tarr WithTableName:@"user0"];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
//        [Teachers dropTableWithTableName:@"user1"];

    NSLog(@"==%@",[DbPath shareInstance].dbPath);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
