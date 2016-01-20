//
//  CardView.h
//  EveMemory
//
//  Created by Atuooo on 14/11/5.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomDeck.h"

@protocol ProgressProtocol <NSObject>

- (void)showTheProgress;

@end

@interface CardView : UIView

@property (nonatomic, assign) id <ProgressProtocol> delegate;

@property (nonatomic) NSInteger cardCount;
@property (nonatomic) NSInteger perNum;
@property (strong, nonatomic) RandomDeck *deck;

- (void)pinchCardView:(UIPinchGestureRecognizer *)gestureRecognizer;
- (void)swipeCardView:(UISwipeGestureRecognizer *)gestureRecognizer;
- (void)leftSwipeInCardView:(UISwipeGestureRecognizer *)gestureRecognizer;

@end
