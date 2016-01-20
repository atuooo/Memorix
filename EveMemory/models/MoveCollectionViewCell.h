//
//  MoveCollectionViewCell.h
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDraggableCollectionViewCell.h"

@interface MoveCollectionViewCell : HTKDraggableCollectionViewCell

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end
