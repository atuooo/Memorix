//
//  StartView.m
//  EveMemory
//
//  Created by Atuooo on 14/12/10.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import "StartView.h"
#import "ViewController.h"
#import "NSUserDefaults_Keys.h"

@interface StartView ()

@property (nonatomic) CGRect mainRect;
@property (strong, nonatomic) NSMutableAttributedString *oneC;
@property (strong, nonatomic) NSMutableAttributedString *twoC;
@property (strong, nonatomic) NSMutableAttributedString *threeC;
@property (strong, nonatomic) NSMutableParagraphStyle *paragraphStyle;

@property (strong, nonatomic) ViewController *deleteVC;

@end

@implementation StartView

- (void)setPerNum:(NSInteger)theNum
{
    _perNum = theNum;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawDect:_perNum];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _perNum = [[NSUserDefaults standardUserDefaults] integerForKey:KeyOfPerNum];
}

#pragma mark ============= BezierPath =============


#define CARD_HEIGHT_SCALE  200 / 667
#define CORNER_SCALE       12
CGFloat tempX ,tempW, textW, tempY, tempH, tempP;

- (CGFloat)cardHeigth { return self.bounds.size.height * CARD_HEIGHT_SCALE;}
- (CGFloat)cardWidth  { return [self cardHeigth] * 0.6;}
- (CGFloat)cardCorner { return [self cardHeigth] * 3/50;}

- (void)drawDect:(NSInteger)num
{
    [self contentInCard:num];
    [self drawCardRect:num];
    [self drawCardSuit:num];
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

- (void)contentInCard:(NSInteger)num
{
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cardHeigth] / 160];
    NSString *cardSuit = [NSString stringWithFormat:@"A\n♣"];   // @[@"♥",@"♦",@"♠",@"♣"]
    
    _oneC = [[NSMutableAttributedString alloc] initWithString:cardSuit attributes:@{ NSFontAttributeName: cornerFont,
                                                                                                      NSParagraphStyleAttributeName: self.paragraphStyle }];
    _twoC = [[NSMutableAttributedString alloc] initWithString:cardSuit attributes:@{ NSFontAttributeName: cornerFont,
                                                                                                          NSParagraphStyleAttributeName: self.paragraphStyle }];
    _threeC = [[NSMutableAttributedString alloc] initWithString:cardSuit attributes:@{ NSFontAttributeName: cornerFont,
                                                                                                            NSParagraphStyleAttributeName: self.paragraphStyle }];
}

- (NSMutableAttributedString *)oneC{
    if (!_oneC) _oneC = [[NSMutableAttributedString alloc] init];
    return _oneC;
}

- (NSMutableAttributedString *)twoC{
    if (!_twoC) _twoC = [[NSMutableAttributedString alloc] init];
    return _twoC;
}

- (NSMutableAttributedString *)threeC{
    if (!_threeC) _threeC = [[NSMutableAttributedString alloc] init];
    return _threeC;
}

- (NSMutableParagraphStyle *)paragraphStyle{
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        _paragraphStyle.alignment = NSTextAlignmentCenter;
    } return _paragraphStyle;
}

@end
