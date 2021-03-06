//
//  HTKDraggableCollectionViewCell.m
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "HTKDraggableCollectionViewCell.h"
#import "HTKDragAndDropCollectionViewLayoutConstants.h"

@interface HTKDraggableCollectionViewCell () <UIGestureRecognizerDelegate>

/**
 * Pan gesture recognizer for dragging
 */
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

/**
 * Long press to engage the dragging
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

/**
 * Allows the pan gesture to begin or not
 */
@property (nonatomic) BOOL allowPan;

/**
 * Sets up the cell
 */
- (void)setupDraggableCell;

/**
 * Handles long press gesture (begins dragging)
 */
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture;

/**
 * Handles the pan gesture (performs actual dragging)
 */
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture;

@end

@implementation HTKDraggableCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupDraggableCell];
    }
    return self;
}

#pragma mark - Cell Setup

- (void)setupDraggableCell
{
    // Add our pan gesture to cell
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    // Add our long press to cell
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    // Wait time before we being dragging
    self.longPressGestureRecognizer.minimumPressDuration = 0.2;
    self.longPressGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.longPressGestureRecognizer];
}

#pragma mark - UIGestureRecognizer Delegates

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Check if panning is disabled
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && !_allowPan)
    {
        return NO;
    }
    
    // Determine if user can drag cell
    BOOL cellCanDrag = YES;
    return cellCanDrag;
}

#pragma mark - UIGestureRecognizer Handlers

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture
{
    switch (longPressGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            // Set initial alpha to show user they can
            // begin dragging.
            self.alpha = HTKDraggableCellInitialDragAlphaValue;
            self.allowPan = YES;
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            self.allowPan = YES;
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            self.allowPan = NO;
            self.alpha = 1.0;
            if ([self.draggingDelegate respondsToSelector:@selector(userDidEndDraggingCell:)])
            {
                [self.draggingDelegate userDidEndDraggingCell:self];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if ([self.draggingDelegate respondsToSelector:@selector(userDidBeginDraggingCell:)])
            {
                [self.draggingDelegate userDidBeginDraggingCell:self];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            if ([self.draggingDelegate respondsToSelector:@selector(userDidDragCell:withGestureRecognizer:)])
            {
                [self.draggingDelegate userDidDragCell:self withGestureRecognizer:panGesture];
            }
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        {
            // Set alpha back
            self.alpha = 1.0;
            if ([self.draggingDelegate respondsToSelector:@selector(userDidEndDraggingCell:)])
            {
                [self.draggingDelegate userDidEndDraggingCell:self];
            }
            break;
        }
            
        default:
            break;
    }
}

@end


