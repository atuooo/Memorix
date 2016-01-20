//
//  HTKDragAndDropCollectionViewController.h
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDragAndDropCollectionViewLayout.h"
#import "HTKDraggableCollectionViewCell.h"

/**
 * CollectionViewController that should be sub-classed to implement
 * drag and drop of cells.
 */
@interface HTKDragAndDropCollectionViewController : UICollectionViewController <HTKDraggableCollectionViewCellDelegate>

@end