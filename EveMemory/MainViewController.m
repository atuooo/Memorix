//
//  MainViewController.m
//  EveMemory
//
//  Created by Atuooo on 3/23/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "MainViewController.h"
#import "NSUserDefaults_Keys.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self userDefaultInit];
}

- (void)userDefaultInit
{
    if (! [[NSUserDefaults standardUserDefaults] integerForKey:KeyOfPerNum])
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:KeyOfPerNum];
    if (! [[NSUserDefaults standardUserDefaults] stringForKey:KeyOfDirection])
        [[NSUserDefaults standardUserDefaults] setObject:@"right" forKey:KeyOfDirection];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
