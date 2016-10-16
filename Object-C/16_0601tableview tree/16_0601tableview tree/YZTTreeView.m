//
//  YZTTreeView.m
//  16_0601tableview tree
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "YZTTreeView.h"

@interface YZTTreeView()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation YZTTreeView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    for (int i=0; i++; i<) {
        <#statements#>
    }
}


@end
