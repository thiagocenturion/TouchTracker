//
//  DrawViewController.m
//  TouchTracker
//
//  Created by Thiago Centurion on 01/10/2017.
//  Copyright © 2017 Thiago Centurion. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

@interface DrawViewController ()

@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation DrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadView
{
    self.view = [[DrawView alloc] initWithFrame:CGRectZero];
}

@end
