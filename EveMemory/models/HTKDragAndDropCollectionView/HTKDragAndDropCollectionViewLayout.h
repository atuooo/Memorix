//
//  HTKDragAndDropCollectionViewLayout.h
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * CollectionViewLayout that supports drag and drop of UICollectionViewCells.
 * Currently supports multiple sections but no section header/footers. (In progress)
 * It does not create a "ghost" or "dummy" cell to move around while dragging.
 */
@interface HTKDragAndDropCollectionViewLayout : UICollectionViewLayout

#pragma mark - Layout Properties

/**
 * Item size to display. Required.
 */
@property (nonatomic) CGSize itemSize;

/**
 * Line spacing between each "row" of items.
 */
@property (nonatomic) CGFloat lineSpacing;

/**
 * Minimum spacing between each item in a row.
 */
@property (nonatomic) CGFloat minimumInteritemSpacing;

/**
 * Section insets for each section.
 */
@property (nonatomic) UIEdgeInsets sectionInset;

#pragma mark - Dragging Properties

/**
 * IndexPath that's currently being dragged. Nil if not dragging.
 */
@property (nonatomic, strong) NSIndexPath *draggedIndexPath;

/**
 * Home/Initial frame for dragged cell. Used to put dragged cell back in
 * place if it's not dragged to another indexPath.
 */
@property (nonatomic) CGRect draggedCellFrame;

/**
 * Final indexPath the dragged ended up at (new indexPath).
 */
@property (nonatomic, strong) NSIndexPath *finalIndexPath;

/**
 * Center of the cell being dragged. Set this to update it's center.
 */
@property (nonatomic) CGPoint draggedCellCenter;

/**
 * Lets you know if a cell is currently being dragged or not
 */
@property (nonatomic, readonly) BOOL isDraggingCell;

/**
 * Called after user drags cell. Will determine if item needs to move
 * out of the way for the dragged cell.
 */
- (void)exchangeItemsIfNeeded;

/**
 * Resets dragging. Called when user ends dragging of a cell.
 */
- (void)resetDragging;

@end


