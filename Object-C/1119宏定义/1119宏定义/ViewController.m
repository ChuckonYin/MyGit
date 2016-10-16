//
//  ViewController.m
//  1119宏定义
//
//  Created by ChuckonYin on 15/11/19.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
//#import <Foundation/NSObjCRuntime.h>

//1\min
#define mina(A,B) ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })
//2min
#define CYJoin(A,B) A##B  //"##"关联两个数值
#define MINb(A,B) CYMin(A,B,counter) //“counter”用于宏调用计数，并生成一个唯一的标签
#define CYMin(A,B,L) ({ __typeof__(A) CYJoin(__a,L) = (A); \
                        __typeof__(B) CYJoin(__b,L) = (B); \
                        (CYJoin(__a,L) < CYJoin(__b,L)) ? CYJoin(__a,L) : CYJoin(__b,L); \
}) 
//3平方或对象
#define CYSQUARE(X) CYSQUARECounter(X,__COUNTER__)
#define CYSQUARECounter(X,L) ({__typeof__(X) CYJoin(__x,L) = (X);\
                               CYJoin(__x,L)*CYJoin(__x,L);})

//NSLog
//个人版本，只能有单输出
#define CYLog(format,b) NSLog([@"%s" stringByAppendingString:format] ,__func__, b)
//标准NSLog,大括号解决if，for 等语句后省略大括号后，宏定义的语句调用不全的问题。do while 可解决if else语句当if执行完之后的分号等问题。编译时do while(0) 会被去掉，不会影响运行效率。
#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
        __LINE__, __func__);                                                        \
(NSLog)((format),##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)
//rect   size  point  //含有陷阱
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1、最小值
    int a = MIN(3, 6);
    //2、最小值
    int b = mina(77, 55);
    //3、最小值
    int c =MINb(2, 3);
    //4、平方
    int d = CYSQUARE(5);
    NSLog(@"%i__%i__%i__%i__",a, b, c, d);
    
    //__typeof__
    NSString *str  = @"字符串";\
    __typeof__(str) e; \
    __typeof(str) f;\
    typeof(str) g;
    NSLog(@"%@,%@,%@",e, f, g);
    //本文件的绝对路径
    NSString *filePath = [[NSString stringWithUTF8String:__FILE__] lastPathComponent];
    //NSLog
    NSArray *array = @[@"Hello", @"My", @"Macro"];
    NSLog (@"The array is %@", array);
    CYLog(@"%@",array);
    
    CGSize sz = CGSizeMake(100, 200);

    

}


@end
