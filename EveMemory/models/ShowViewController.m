//
//  ShowViewController.m
//  EveMemory
//
//  Created by Atuooo on 3/21/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "ShowViewController.h"
#import "DataSource.h"
#include "NSUserDefaults_Keys.h"

@implementation ShowViewController {
    NSMutableArray *chartsArray;
    NSInteger numOfWrong;
    float time;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *IdoArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:KeyOfMineDeck]];
    NSMutableArray *UdoArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:KeyOfYourDeck]];
    
    time = [[NSUserDefaults standardUserDefaults] floatForKey:KeyOfTimer];
    self.timeLabel.text = [NSString stringWithFormat:@"Time : %.2fs", time];
        
    numOfWrong = 0;
    for (NSInteger i = 0; i < IdoArray.count; i++)
    {
        if (! [IdoArray[i] isEqualToString:UdoArray[i]])
            numOfWrong++;
    }

    self.wrongLabel.text = [NSString stringWithFormat:@"Wrong : %ld", (long)numOfWrong];
    
    [self addToCharts];
    
//    if (chartsArray == nil)
//        self.bestTimeLabel.text = @"Best : null";
//    else
//        self.bestTimeLabel.text = [NSString stringWithFormat:@"Best : %@", chartsArray[0][0]] ;
    
    [[NSUserDefaults standardUserDefaults] setInteger:numOfWrong forKey:KeyOfNumOfWrong];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addToCharts
{
    chartsArray = [[NSMutableArray alloc] init];
    NSMutableArray *newChartArray = [[NSMutableArray alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KeyOfChartsInfo])
        chartsArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:KeyOfChartsInfo]];
    
    //get the date soucre
    if (! numOfWrong)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"2014.01.20"];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        NSString *timeString = [NSString stringWithFormat:@"%.2f", time];
        
        [newChartArray addObject:timeString];
        [newChartArray addObject:dateString];
        
        [chartsArray addObject:newChartArray];
        [chartsArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
         {
             NSString *string1 = obj1[0];
             NSString *string2 = obj2[0];
             
             if (string1.floatValue < string2.floatValue)
                 return NSOrderedAscending;
             if (string1.floatValue > string2.floatValue)
                 return NSOrderedDescending;
             
             return NSOrderedSame;
         }];
        
        self.bestTimeLabel.text = [NSString stringWithFormat:@"Best : %@s", chartsArray[0][0]];
        [[NSUserDefaults standardUserDefaults] setObject:chartsArray forKey:KeyOfChartsInfo];
   }
}

@end
