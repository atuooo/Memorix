//
//  CardView.m
//  EveMemory
//
//  Created by Atuooo on 14/11/5.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import "CardView.h"
#import "DataSource.h"
#include "NSUserDefaults_Keys.h"

@interface CardView () 

@property (nonatomic) BOOL isBegin;
@property (nonatomic) CGFloat cardviewRatio;

@property (nonatomic) CGRect mainRect;
@property (strong, nonatomic) NSMutableAttributedString *oneC;
@property (strong, nonatomic) NSMutableAttributedString *twoC;
@property (strong, nonatomic) NSMutableAttributedString *threeC;
@property (strong, nonatomic) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation CardView

#pragma mark ============ Card View ================

- (void)setCardCount:(NSInteger)cardCount
{
    _cardCount = cardCount;
    [self setNeedsDisplay];
}

- (void)setCardviewRatio:(CGFloat)cardviewRatio
{
    _cardviewRatio = cardviewRatio;
    [self setNeedsDisplay];
}

- (void)setIsBegin:(BOOL)isBegin
{
    _isBegin = isBegin;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawDect:_perNum];
}

#pragma mark ============= deck(bezierPath) ==============

#define CARD_HEIGHT_SCALE  200 / 667
#define CORNER_SCALE       12
CGFloat tempX ,tempW, textW, tempY, tempH, tempP;

- (CGFloat)cardHeigth { return self.bounds.size.height * CARD_HEIGHT_SCALE * self.cardviewRatio;}
- (CGFloat)cardWidth  { return [self cardHeigth] * 0.6;}
- (CGFloat)cardCorner { return [self cardHeigth] * 3/50;}

- (void)drawDect:(NSInteger)num
{
//    [self drawCardRect:num];
    [self drawBackground:num];
    
    // ProgressProcotol delegate
    
    if ([self.delegate respondsToSelector:@selector(showTheProgress)])
    {
        [self.delegate showTheProgress];
    }
}

- (void)drawCardRect:(NSInteger)num
{
    [[UIColor blackColor] setStroke];
    [[UIColor whiteColor] setFill];
    
    tempY = (self.bounds.size.height-[self cardHeigth])/2;
    tempH = [self cardHeigth];
    textW = [_oneC size].width;
    tempP = [self cardCorner]+textW;
    
    if (num == 1) {
        tempX = (self.bounds.size.width-[self cardWidth])/2;
        
        _mainRect = CGRectMake(tempX, tempY, [self cardWidth], tempH);
        UIBezierPath *onePath = [UIBezierPath bezierPathWithRoundedRect:_mainRect cornerRadius:[self cardCorner]];
        [onePath stroke];
        [onePath fill];
        [onePath addClip];
    }
    
    if (num == 2) {
        tempW = [self cardWidth]+tempP;
        tempX = (self.bounds.size.width-tempW)/2;
        
        _mainRect = CGRectMake(tempX, tempY, tempW, tempH);
        UIBezierPath *twoPath = [UIBezierPath bezierPathWithRoundedRect:_mainRect cornerRadius:[self cardCorner]];
        [twoPath stroke];
        [twoPath fill];
        [twoPath addClip];
        
        CGRect oneRect = CGRectMake(tempX+tempP, tempY, tempW, tempH);
        UIBezierPath *onePath = [UIBezierPath bezierPathWithRoundedRect:oneRect cornerRadius:[self cardCorner]];
        [onePath stroke];
    }
    
    if (num == 3) {
        if (_cardCount > 51) {
            
            tempX = (self.bounds.size.width-[self cardWidth])/2;
            
            _mainRect = CGRectMake(tempX, tempY, [self cardWidth], tempH);
            UIBezierPath *onePath = [UIBezierPath bezierPathWithRoundedRect:_mainRect cornerRadius:[self cardCorner]];
            [onePath stroke];
            [onePath fill];
            [onePath addClip];
        }
        else
        {
            tempW = [self cardWidth]+2*tempP;
            tempX = (self.bounds.size.width-tempW)/2;
            _mainRect = CGRectMake(tempX, tempY, tempW, tempH);
            UIBezierPath *threePath = [UIBezierPath bezierPathWithRoundedRect:_mainRect cornerRadius:[self cardCorner]];
            [threePath stroke];
            [threePath fill];
            [threePath addClip];
            
            CGRect twoRect = CGRectMake(tempX+tempP, tempY, tempW, tempH);
            UIBezierPath *twoPath = [UIBezierPath bezierPathWithRoundedRect:twoRect cornerRadius:[self cardCorner]];
            [twoPath stroke];
            
            CGRect oneRect = CGRectMake(tempX+tempP*2, tempY, tempW, tempH);
            UIBezierPath *onePath = [UIBezierPath bezierPathWithRoundedRect:oneRect cornerRadius:[self cardCorner]];
            [onePath stroke];
        }
    }
}

- (void)drawBackground:(NSInteger)num
{
    if (_isBegin) {
        UIImage *backImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_back", (long)num]];
        
        [self contentInCard:num Index:_perNum];
        [self drawCardRect:num];
        [backImage drawInRect:_mainRect];
    }
    else
    {
        [self contentInCard:num Index:_cardCount];
        [self drawCardRect:num];
        [self drawCardSuit:num];
    }
}

- (void)drawCardSuit:(NSInteger)num
{
    CGFloat sizeC = [self cardCorner]/2;
    
    if (num == 1) {
        CGRect cornerBounds;
        cornerBounds.origin = CGPointMake(tempX+sizeC, tempY+sizeC);
        cornerBounds.size = [_oneC size];
        [_oneC drawInRect:cornerBounds];
        
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
        CGContextRotateCTM(context, M_PI);
        [_oneC drawInRect:cornerBounds];
    }
    
    if (num == 2) {
        CGRect oneBounds;
        oneBounds.origin = CGPointMake(tempX+tempP+sizeC, tempY+sizeC);
        oneBounds.size = [_oneC size];
        [_oneC drawInRect:oneBounds];
        
        CGRect twoBounds;
        twoBounds.origin = CGPointMake(tempX+sizeC, tempY+sizeC);
        twoBounds.size = [_twoC size];
        [_twoC drawInRect:twoBounds];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
        CGContextRotateCTM(context, M_PI);
        [_oneC drawInRect:twoBounds];
    }
    
    if (num ==3) {
        
        if (_cardCount > 51)
        {
            
            CGRect cornerBounds;
            cornerBounds.origin = CGPointMake(tempX+sizeC, tempY+sizeC);
            cornerBounds.size = [_oneC size];
            [_oneC drawInRect:cornerBounds];
            
            CGContextRef context =UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
            CGContextRotateCTM(context, M_PI);
            [_oneC drawInRect:cornerBounds];
        }
        else
        {
            CGRect oneBounds;
            oneBounds.origin = CGPointMake(tempX+tempP*2+sizeC, tempY+sizeC);
            oneBounds.size = [_oneC size];
            [_oneC drawInRect:oneBounds];
            
            CGRect twoBounds;
            twoBounds.origin = CGPointMake(tempX+tempP+sizeC, tempY+sizeC);
            twoBounds.size = [_twoC size];
            [_twoC drawInRect:twoBounds];
            
            CGRect threeBounds;
            threeBounds.origin = CGPointMake(tempX+sizeC, tempY+sizeC);
            threeBounds.size = [_threeC size];
            [_threeC drawInRect:threeBounds];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
            CGContextRotateCTM(context, M_PI);
            [_oneC drawInRect:threeBounds];
        }
    }
}

- (void)contentInCard:(NSInteger)num Index:(NSInteger)index
{
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cardHeigth] / 160];
    
    if (num == 1)
    {
        _oneC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(index-_perNum)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                              NSParagraphStyleAttributeName: self.paragraphStyle }];
       
    }
    
    if (num == 2)
    {
        _oneC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(index-_perNum)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                              NSParagraphStyleAttributeName: self.paragraphStyle }];
        _twoC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(index-_perNum+1)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                              NSParagraphStyleAttributeName: self.paragraphStyle }];
    }
    
    if (num == 3)
    {
        if (_cardCount == 54)
        {
            self.cardCount = 52;
            _oneC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(51)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                                            NSParagraphStyleAttributeName: self.paragraphStyle }];
        }
        else
        {
            _oneC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(index-_perNum)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                                             NSParagraphStyleAttributeName: self.paragraphStyle }];
            _twoC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(index-_perNum+1)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                                             NSParagraphStyleAttributeName: self.paragraphStyle }];
            _threeC = [[NSMutableAttributedString alloc] initWithString:[self getSuit:(index-_perNum+2)] attributes:@{ NSFontAttributeName: cornerFont,
                                                                                    NSParagraphStyleAttributeName: self.paragraphStyle }];
        }
    }
}

- (NSString *)getSuit:(NSInteger)num
{
    if (_cardCount == 52)
    {
        _cardCount = 52;
    }
    
    return [NSString stringWithFormat:@"%@\n%@", [self.deck.randomDeck[num] substringFromIndex:1],
                                                 [self.deck.randomDeck[num] substringToIndex:1]];

}

- (NSMutableParagraphStyle *)paragraphStyle
{
    if (!_paragraphStyle)
    {
        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        _paragraphStyle.alignment = NSTextAlignmentCenter;
    } return _paragraphStyle;
}

#pragma mark ============== Card Gesture ================

- (void)pinchCardView:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if ((gestureRecognizer.state == UIGestureRecognizerStateCancelled) ||
        (gestureRecognizer.state == UIGestureRecognizerStateEnded))
    {
        
        self.cardviewRatio *= gestureRecognizer.scale;
    }
}

- (void)swipeCardView:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (_isBegin)
    {
        NSDate *startDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:startDate forKey:KeyOfStartDate];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.cardCount = _perNum;
        self.isBegin = NO;
    }
    else
    {
        if (_cardCount < 52) {
            self.cardCount += _perNum;
        }
    }
}

- (void)leftSwipeInCardView:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (_cardCount == _perNum)
    {
        self.cardCount = _perNum;
    }
    else
    {
        if ((_cardCount == 52) && (_perNum == 3))
        {
            self.cardCount = 51;
        }
        else if (self.cardCount == 0)
        {
            self.cardCount = 0;
        }
        else
        {
            self.cardCount -= _perNum;
        }
    }
}

#pragma mark ============== setup view ================

- (void)setup
{
    _perNum = [[NSUserDefaults standardUserDefaults] integerForKey:KeyOfPerNum];
    
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    _cardviewRatio = 1;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cardHeigth] / 160];
    _oneC = [[NSMutableAttributedString alloc] initWithString:@"10\n♣" attributes:@{ NSFontAttributeName: cornerFont,
                                                                                         NSParagraphStyleAttributeName: self.paragraphStyle }];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    
    NSDate *startDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:startDate forKey:KeyOfStartDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _deck = [[RandomDeck alloc] init];
    [_deck creatRandomDeck];
    [[NSUserDefaults standardUserDefaults] setObject:_deck.randomDeck forKey:KeyOfMineDeck];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _isBegin = YES;
}

@end
