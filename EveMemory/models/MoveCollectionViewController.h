//
//  MoveCollectionViewController.h
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDragAndDropCollectionViewController.h"

@interface MoveCollectionViewController : HTKDragAndDropCollectionViewController

@property (nonatomic, strong) NSMutableArray *originalDeck;

@property (nonatomic) NSInteger backCount;

@end
