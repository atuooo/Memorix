//
//  ViewController.m
//  EveMemory
//
//  Created by Atuooo on 14/11/5.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"
#import "StartView.h"
#import "MoveCollectionViewController.h"
#import "NSUserDefaults_Keys.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet CardView *showCard;

@property (weak, nonatomic) IBOutlet UILabel *progressLable;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.showCard.delegate = self;
    
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:KeyOfDirection] isEqualToString:@"right"])
    {
        UISwipeGestureRecognizer *rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self.showCard action:@selector(swipeCardView:)];
        rightSwipeGR.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rightSwipeGR];
        
        UISwipeGestureRecognizer *leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self.showCard action:@selector(leftSwipeInCardView:)];
        leftSwipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:leftSwipeGR];
    }
    else
    {
        UISwipeGestureRecognizer *rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self.showCard action:@selector(leftSwipeInCardView:)];
        rightSwipeGR.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rightSwipeGR];
        
        UISwipeGestureRecognizer *leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self.showCard action:@selector(swipeCardView:)];
        leftSwipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:leftSwipeGR];
    }

    [self.showCard addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.showCard
                                                                                  action:@selector(pinchCardView:)]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    float startDate = -[[[NSUserDefaults standardUserDefaults] objectForKey:KeyOfStartDate] timeIntervalSinceNow];
    [[NSUserDefaults standardUserDefaults] setFloat:startDate forKey:KeyOfTimer];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - delegate

- (void)showTheProgress
{
    self.progressLable.text = [NSString stringWithFormat:@"%ld/52",(long)self.showCard.cardCount];
}

@end

