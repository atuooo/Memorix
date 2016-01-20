//
//  MoveCollectionViewController.m
//  EveMemory
//
//  Created by Atuooo on 1/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "MoveCollectionViewController.h"
#import "MoveCollectionViewCell.h"
#import "RandomDeck.h"
#import "DataSource.h"
#import "CardView.h"
#import "ViewController.h"
#import "NSUserDefaults_Keys.h"

/**
 * Cell identifier for the cell.
 */
static NSString *MY_CELL = @"MY_CELL";

@interface MoveCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MoveCollectionViewController{
    NSMutableArray *originalArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.104053 green:0.421737 blue:0.120063 alpha:1];
    // Register cell
    [self.collectionView registerClass:[MoveCollectionViewCell class] forCellWithReuseIdentifier:MY_CELL];
    
    // Create Array for Demo data
    [self creatSourceData];
    
    // Setup item size
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(75, 110);
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.lineSpacing = 7;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 150, 10);
    
    [self setBarButtonItems];
}

#pragma mark - UINavigation bar button items

- (void)setBarButtonItems
{
    UIColor *titleColor = [UIColor blackColor];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [rightButton setTitle:@"Done" forState:UIControlStateNormal];
    
    rightButton.titleLabel.font = [UIFont fontWithName:@"Bradley Hand" size:23];

    [rightButton setTitleColor:titleColor forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = doneButton;

    [self.navigationItem setHidesBackButton:YES animated:YES];

    UIFont *titleFont = [UIFont fontWithName:@"Bradley Hand" size:33];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : titleFont};
    self.navigationItem.title = @"Sequence";
}

- (void)doneAction:(id)sender
{
    UIAlertController *doneAlert = [UIAlertController alertControllerWithTitle:@"Are you sure ?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"showVC"] animated:YES];
    }];
    
    [doneAlert addAction:cancleAction];
    [doneAlert addAction:okAction];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.dataArray forKey:KeyOfYourDeck];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self presentViewController:doneAlert animated:YES completion:nil];
}

#pragma mark UICollectionView Datasource/Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoveCollectionViewCell *cell = (MoveCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:MY_CELL forIndexPath:indexPath];
    
    // Set number on cell
    cell.imageView.image = [UIImage imageNamed: _dataArray[indexPath.row]];
//    cell.imageView.image = [UIImage imageNamed: [DataSource shareDataSource].sortedArray[indexPath.row]];

    cell.draggingDelegate = self;

    return cell;
}

#pragma mark - HTKDraggableCollectionViewCellDelegate

- (BOOL)userCanDragCell:(UICollectionViewCell *)cell
{
    // All cells can be dragged in this demo
    return YES;
}

- (void)userDidEndDraggingCell:(UICollectionViewCell *)cell
{
    [super userDidEndDraggingCell:cell];
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    
    // Save our dragging changes if needed
    if (flowLayout.finalIndexPath != nil)
    {
        // Update datasource
        NSObject *objectToMove = [self.dataArray objectAtIndex:flowLayout.draggedIndexPath.row];
        [self.dataArray removeObjectAtIndex:flowLayout.draggedIndexPath.row];
        [self.dataArray insertObject:objectToMove atIndex:flowLayout.finalIndexPath.row];
    }
}

#pragma mark - init

- (void)creatSourceData
{
    originalArray = [[NSMutableArray alloc] init];
    
    NSArray *ranks = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    NSArray *suits = @[@"♥",@"♦",@"♠",@"♣"];
    
    for (NSString *rank in ranks) {
        for (NSString *suit in suits) {
            [originalArray addObject:[suit stringByAppendingString:rank]];
        }
    }

    self.dataArray = [[NSMutableArray alloc] initWithArray:originalArray];
}

@end
