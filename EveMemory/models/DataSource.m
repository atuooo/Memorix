//
//  DataSource.m
//  EveMemory
//
//  Created by Atuooo on 2/9/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+ (DataSource *)shareDataSource
{
    static DataSource *dataSource = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
            dataSource = [DataSource new];
        });
    
    return dataSource;
}

//+ (DataSource *)shareDataSource
//{
//    static DataSource *dataSource = nil;
//    
//    if (dataSource == nil)
//    {
//        dataSource = [[DataSource alloc] init];
//    }
//    
//    return dataSource;
//}

@end
