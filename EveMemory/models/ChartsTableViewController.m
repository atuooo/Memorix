//
//  ChartsTableViewController.m
//  EveMemory
//
//  Created by Atuooo on 3/25/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "ChartsTableViewController.h"
#import "ChartsTableViewCell.h"
#include "NSUserDefaults_Keys.h"

@implementation ChartsTableViewController {
    NSMutableArray *dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:KeyOfChartsInfo]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:KeyOfChartsInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - set navigation bar

- (void)setNavigationBar
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [backButton setContentMode:UIViewContentModeScaleAspectFit];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    if (dataArray.count)
    {
        UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        [resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        resetButton.titleLabel.font = [UIFont fontWithName:@"Bradley Hand" size:24];
        resetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *resetButtonItem = [[UIBarButtonItem alloc] initWithCustomView:resetButton];
        self.navigationItem.rightBarButtonItem = resetButtonItem;
    }
    else
    {
        UIButton *noneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 220, 20)];
        [noneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [noneButton setTitle:@"There is no record" forState:UIControlStateNormal];
        noneButton.titleLabel.font = [UIFont fontWithName:@"Bradley Hand" size:24];
        noneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        UIBarButtonItem *noneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:noneButton];
        self.navigationItem.rightBarButtonItem = noneButtonItem;
    }
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetAction
{
    UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"Are you sure ?" message:@"You can delete the one by sliding it to the left" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [dataArray removeAllObjects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [deleteAlert addAction:cancelAction];
    [deleteAlert addAction:yesAction];
    
    [self presentViewController:deleteAlert animated:YES completion:nil];
}

#pragma mark - gesture 

- (void)swipeCellToDelete:(UISwipeGestureRecognizer *)recognizer
{
    UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)recognizer;
    CGPoint location = [swipe locationInView:self.tableView];
    NSIndexPath *deletePath = [self.tableView indexPathForRowAtPoint:location];
    
    if ((deletePath != nil) & (recognizer.state == UIGestureRecognizerStateEnded))
    {
        NSArray *array = @[deletePath];
    
        [dataArray removeObjectAtIndex:deletePath.row];
        [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.2f];
    }
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chartsCell" forIndexPath:indexPath];
    NSArray *chartArray = [[NSArray alloc] initWithArray:dataArray[indexPath.row]];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", (indexPath.row+1)];
    
    cell.timeLabel.text = chartArray[0];
    cell.dateLabel.text = chartArray[1];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



@end
