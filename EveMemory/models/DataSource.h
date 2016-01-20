//
//  DataSource.h
//  EveMemory
//
//  Created by Atuooo on 2/9/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *sortedArray;

@property (nonatomic) NSInteger testNum;

+ (DataSource *)shareDataSource;

@end
