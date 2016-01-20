//
//  RadomDeck.m
//  EveMemory
//
//  Created by Atuooo on 14/11/5.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import "RandomDeck.h"

@implementation RandomDeck

- (NSMutableArray *)creatOriginalDeck
{
    NSMutableArray *originalDeck = [[NSMutableArray alloc] init];
    
    NSArray *ranks = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    NSArray *suits = @[@"♥",@"♦",@"♠",@"♣"];
    
    for (NSString *suit in suits)
    {
        for (NSString *rank in ranks)
        {
            [originalDeck addObject:[suit stringByAppendingString:rank]];
        }
    }
    
    return originalDeck;
}

- (void)creatRandomDeck  // disrupt the order of deck
{
    NSMutableArray *tempDeck = [[NSMutableArray alloc] initWithArray:[self creatOriginalDeck]];
    _randomDeck = [[NSMutableArray alloc] init];
    
    int random = 0;
    for (int i = 0; i < 52; i++)
    {
        random = arc4random_uniform((int)[tempDeck count]);
        [_randomDeck addObject:[tempDeck objectAtIndex:random]];
        [tempDeck removeObjectAtIndex:random];
    }
}

@end
