//
//  ViewController.m
//  16_0524tableviewcell
//
//  Created by ChuckonYin on 16/5/24.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

const NSString *cellConfirmDeleteCustomCell = @"cellConfirmDeleteCustomCell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableViewCell *editingCell;

@property (nonatomic, strong) NSArray *pageContent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self createContentPages];
}

- (void) createContentPages
{
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (int i = 1; i < 3; i++)
    {
        NSString *contentString = [NSString stringWithFormat:@"Chapter %d This is the page %d of content displayed using UIPageViewController in iOS 5.", i, i];
        
        [pageStrings addObject:contentString];
    }
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
}



#pragma mark - UITableViewDelegate

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
        cell.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (editingStyle) {
        case UITableViewCellEditingStyleNone: {

            break;
        }
        case UITableViewCellEditingStyleDelete: {
            
            break;
        }
        case UITableViewCellEditingStyleInsert: {
            
            break;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    for (UIView *v in cell.subviews) {
        if ([v isKindOfClass:[NSClassFromString(@"UITableViewCellContentView") class]]) {
            [v addObserver:self forKeyPath:@"frame" options: NSKeyValueObservingOptionNew |
             NSKeyValueObservingOptionOld context:nil];
        }
    }
    return [self configConfirmDeleteCustomViewSpaceString];
}


- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
    _editingCell = [tableView cellForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 400, 30)];
//    view.backgroundColor = [UIColor yellowColor];
    
    for (UIView *v in _editingCell.subviews) {
        if ([v isKindOfClass:[NSClassFromString(@"UITableViewCellDeleteConfirmationView") class]]) {
//            if (CGRectEqualToRect(v.frame, CGRectMake(0, 0, 100, 20))) return;
//            v.frame = CGRectMake(0, 0, 100, 20);
            [self addSubView:[self configConfirmDeleteCustomView] toTableViewCellDeleteConfirmationView:v];
        }
    }
}

- (void)addSubView:(UIView *)view toTableViewCellDeleteConfirmationView:(UIView *)confirmationView{
    if (objc_getAssociatedObject(confirmationView, (__bridge const void *)(cellConfirmDeleteCustomCell))) {
        return;
    }
    [confirmationView addSubview:view];
    objc_setAssociatedObject(confirmationView, (__bridge const void *)(cellConfirmDeleteCustomCell), view, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)configConfirmDeleteCustomViewSpaceString{
    //40*5
    NSMutableString *string = @"".mutableCopy;
    for (int i=0; i<40; i++) {
        [string appendString:@" "];
    }
    return string;     
}


- (UIView *)configConfirmDeleteCustomView{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    contentView.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0+i*75, 0, 74, 44)];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@[@"置顶", @"未读", @"删除"][i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
    }
    return contentView;
}

- (void)confirm:(UIButton *)btn{
    NSLog(@"%@", btn);
}


@end






