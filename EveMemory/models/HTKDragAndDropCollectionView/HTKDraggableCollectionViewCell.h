//
//  HTKDraggableCollectionViewCell.h
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import <UIKit/UIKit.h>

///**
// * Cell identifier for the cell.
// */
//static NSString *HTKDraggableCollectionViewCellIdentifier = @"HTKDraggableCollectionViewCellIdentifier";

/**
 * Delegate for dragging the cell.
 */
@protocol HTKDraggableCollectionViewCellDelegate <NSObject>

/**
 * Called when user starts to drag
 */
- (void)userDidBeginDraggingCell:(UICollectionViewCell *)cell;

/**
 * Called when user ends dragging.
 */
- (void)userDidEndDraggingCell:(UICollectionViewCell *)cell;

/**
 * Called while user is dragging the cell
 */
- (void)userDidDragCell:(UICollectionViewCell *)cell withGestureRecognizer:(UIPanGestureRecognizer *)recognizer;

@optional

/**
 * Determines if dragging can begin for cell. Defaults to YES.
 */
- (BOOL)userCanDragCell:(UICollectionViewCell *)cell;

@end

/**
 * UICollectionViewCell that provides dragging and delegates for the different
 * dragging states. Subclass this along with the custom drag and drop layout
 * to provide drag and drop functionality.
 */
@interface HTKDraggableCollectionViewCell : UICollectionViewCell

/**
 * Delegate for dragging the cell.
 */
@property (nonatomic, weak) id <HTKDraggableCollectionViewCellDelegate> draggingDelegate;

@end

