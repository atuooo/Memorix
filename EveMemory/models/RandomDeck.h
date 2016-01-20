//
//  RadomDeck.h
//  EveMemory
//
//  Created by Atuooo on 14/11/5.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomDeck : NSObject

@property (nonatomic, strong) NSMutableArray *randomDeck;

- (void)creatRandomDeck;   // disrupt the order of deck

@end
