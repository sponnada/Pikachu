//
//  mainVC.m
//  eggs
//
//  Created by Sri on 4/27/14.
//  Copyright (c) 2014 Sri. All rights reserved.
//

#import "mainVC.h"

@interface mainVC ()

@end

@implementation mainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gamescreen.png"]];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
    

}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear: (BOOL)animated
{
 //   [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(BOOL)prefersStatusBarHidden{
    return NO;
}
*/ 
@end
