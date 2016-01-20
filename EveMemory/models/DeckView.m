//
//  DeckView.m
//  EveMemory
//
//  Created by Atuooo on 1/31/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "DeckView.h"
#import "RandomDeck.h"

@interface DeckView ()
@property (nonatomic, strong) NSMutableArray *deckArray;
@property (nonatomic, strong) RandomDeck *deck;
@end

@implementation DeckView {
    
    UIImageView *oneView;
    UIImageView *twoView;
    UIImageView *threeView;
    
    BOOL isBegin;
    
    CGFloat deckRatio;
    NSInteger perNum;
}

- (void)setCardCount:(NSInteger)cardCount
{
    _cardCount = cardCount;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawTheDeck:self.frame perNum:perNum];
    
    if (!isBegin)
    {
        [self showBeginImage:perNum];
    }
    else
    {
        [self showCardImage:perNum];
    }
}

#pragma mark - deck view

#define CARD_HEIGHT_SCALE  240 / 680

- (CGFloat)cardHeigth { return self.bounds.size.height * CARD_HEIGHT_SCALE * deckRatio;}
- (CGFloat)cardWidth  { return [self cardHeigth] * 0.65;}
- (CGFloat)cardCorner { return [self cardHeigth] * 2/50;}

- (void)drawTheDeck:(CGRect)rect perNum:(NSInteger)pernum
{
    CGFloat deckW = [self cardWidth];
    CGFloat deckH = [self cardHeigth];
    CGFloat deckC = [self cardCorner];
    
    switch (pernum)
    {
        case 1:
        {
            oneView = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width - deckW)/2,
                                                                                (rect.size.height - deckH)/2,
                                                                                 deckW, deckH)];
            oneView.layer.cornerRadius = deckC;
            oneView.layer.masksToBounds = YES;
            
            [self addSubview:oneView];
        }
            break;
            
        case 2:
        {
            oneView = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width - deckW - 3 * deckC)/2,
                                                                    (rect.size.height - deckH)/2,
                                                                     deckW, deckH)];
            oneView.layer.cornerRadius = deckC;
            oneView.layer.masksToBounds = YES;
            
            twoView = [[UIImageView alloc] initWithFrame:CGRectMake(oneView.frame.origin.x + 3 * deckC,
                                                                    oneView.frame.origin.y,
                                                                    deckW, deckH)];
            twoView.layer.cornerRadius = deckC;
            twoView.layer.masksToBounds = YES;
            
            [self addSubview:oneView];
            [self addSubview:twoView];
        }
            break;
            
        case 3:
        {
            oneView = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width - deckW - 6 * deckC)/2,
                                                                                 (rect.size.height - deckH)/2,
                                                                                 deckW, deckH)];
            oneView.layer.cornerRadius = deckC;
            oneView.layer.masksToBounds = YES;
            
            twoView = [[UIImageView alloc] initWithFrame:CGRectMake(oneView.frame.origin.x + 3 * deckC,
                                                                    oneView.frame.origin.y,
                                                                    deckW, deckH)];
            twoView.layer.cornerRadius = deckC;
            twoView.layer.masksToBounds = YES;
            
            threeView = [[UIImageView alloc] initWithFrame:CGRectMake(twoView.frame.origin.x + 3 * deckC,
                                                                      twoView.frame.origin.y,
                                                                      deckW, deckH)];
            threeView.layer.cornerRadius = deckC;
            threeView.layer.masksToBounds = YES;
            
            [self addSubview:oneView];
            [self addSubview:twoView];
            [self addSubview:threeView];
        }
            break;
            
        default:
            break;
    }
}

- (void)showBeginImage:(NSInteger)pernum
{
    switch (pernum)
    {
        case 1:
            oneView.image = [UIImage imageNamed:@"1_back"];
            break;
        
        case 2:
            oneView.image = [UIImage imageNamed:@"1_back"];
            twoView.image = [UIImage imageNamed:@"1_back"];
            break;
        
        case 3:
            oneView.image = [UIImage imageNamed:@"1_back"];
            twoView.image = [UIImage imageNamed:@"1_back"];
            threeView.image = [UIImage imageNamed:@"1_back"];
            break;
            
        default:
            break;
    }
}

- (void)showCardImage:(NSInteger)pernum
{
    switch (pernum)
    {
        case 1:
            oneView.image = [UIImage imageNamed:self.deck.randomDeck[_cardCount - 1]];
//            NSLog(@"show one card %@", _deckArray[_cardCount - 1]);
            break;
            
        case 2:
            oneView.image = [UIImage imageNamed:self.deck.randomDeck[_cardCount - 2]];
            twoView.image = [UIImage imageNamed:self.deck.randomDeck[_cardCount - 1]];
            break;
            
         case 3:
            oneView.image = [UIImage imageNamed:_deckArray[_cardCount - 3]];
            twoView.image = [UIImage imageNamed:_deckArray[_cardCount - 2]];
            threeView.image = [UIImage imageNamed:_deckArray[_cardCount - 1]];
            break;
            
        default:
            break;
    }
}

#pragma mark - Gesture Recognizer

- (void)handelSwipe:(UIGestureRecognizer *)recognizer
{
    if (!isBegin)
    {
        isBegin = YES;
    }
    
    self.cardCount += perNum;
}

#pragma mark - data source

- (NSMutableArray *)deckArray
{
    if (!_deckArray)
    {
        _deckArray = [[NSMutableArray alloc] initWithArray:_deck.randomDeck copyItems:YES];
    }
    
    return _deckArray;
}

- (RandomDeck *)deck
{
    if (!_deck)
    {
        _deck = [[RandomDeck alloc] init];
        [_deck creatRandomDeck];
    }
    
    return _deck;
}

#pragma mark - set up

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handelSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
    
    isBegin = NO;
    perNum = 2;
    deckRatio = 1;
}


@end
