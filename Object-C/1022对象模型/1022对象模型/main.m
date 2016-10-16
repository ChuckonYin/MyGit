//
//  main.m
//  1022对象模型
//
//  Created by ChuckonYin on 15/10/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Child.h"

int main(int argc, const char * argv[]) {
    
    Child *child= [[Child alloc] init];
    
    
    
    return 0;
}

//(lldb) p *child
//(Child) $0 = {
//    Father = {
//        NSObject = {
//            isa = Child
//        }
//    }
//}
//(lldb)