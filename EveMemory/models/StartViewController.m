//
//  StartViewController.m
//  EveMemory
//
//  Created by Atuooo on 14/12/10.
//  Copyright (c) 2014年 Atuooo. All rights reserved.
//

#import "StartViewController.h"
#import "ViewController.h"
#import "DataSource.h"
#import "NSUserDefaults_Keys.h"

@interface StartViewController ()
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet StartView *startView;
@end

@implementation StartViewController

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)oneButton:(UIButton *)sender
{
    self.startView.perNum = 1;
}

- (IBAction)twoButton:(id)sender
{
    self.startView.perNum = 2;
}

- (IBAction)threeButton:(id)sender
{
    self.startView.perNum = 3;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setButtonBackgroundImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.startView.perNum forKey:KeyOfPerNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setButtonBackgroundImage
{
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:KeyOfDirection] isEqualToString: @"left" ])
    {
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"blackleft"] forState: UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"whiteright"] forState: UIControlStateNormal];
    }
    else
    {
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"whiteleft"] forState: UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"blackright"] forState: UIControlStateNormal];
    }
}

- (void)leftButtonAction
{
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:KeyOfDirection] isEqualToString: @"right" ])
    {
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"blackleft"] forState: UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"whiteright"] forState: UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"left" forKey:KeyOfDirection];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)rightButtonAction
{
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:KeyOfDirection] isEqualToString: @"left" ])
    {
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"whiteleft"] forState: UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"blackright"] forState: UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"right" forKey:KeyOfDirection];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - Navigation



@end
