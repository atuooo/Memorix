//
//  ShowTableViewController.m
//  EveMemory
//
//  Created by Atuooo on 3/20/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "ShowTableViewController.h"
#import "DataSource.h"
#import "ShowTableViewCell.h"
#import "NSUserDefaults_Keys.h"

@implementation ShowTableViewController {
    NSMutableArray *IdoArray;
    NSMutableArray *UdoArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    
    IdoArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:KeyOfMineDeck]];
    UdoArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:KeyOfYourDeck]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationBar];
}

- (void)setNavigationBar
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [backButton setContentMode:UIViewContentModeScaleAspectFit];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return UdoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showCell" forIndexPath:indexPath];
    
    cell.numLabel.text = [NSString stringWithFormat:@"%d", (indexPath.row + 1)];
    
    cell.IdoImageView.image = [UIImage imageNamed:IdoArray[indexPath.row]];
    cell.UdoImageView.image = [UIImage imageNamed:UdoArray[indexPath.row]];
    
    if ([IdoArray[indexPath.row] isEqualToString:UdoArray[indexPath.row]])
        cell.resultImageView.image = [UIImage imageNamed:@"correct"];
    else
        cell.resultImageView.image = [UIImage imageNamed:@"wrong"];
    
    return cell;
}

@end
